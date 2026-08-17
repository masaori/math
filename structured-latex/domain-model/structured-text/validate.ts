/**
 * L1（入力言語）の**実行時検証**。型を経由せずに作られた値（外部から受け取った JSON、
 * `as` で型検査を迂回した値、動的生成した値）への唯一の関門。
 *
 * 役割分担（docs/type-coverage.md に根拠つきで記録）:
 *   - ここが見るのは**ブロック 1 件の形**（I4・未知フィールド・ノード種別）。
 *   - **文書全体にかかる不変条件（I1 一意性・I2 参照解決・I3 非空）は `resolved/resolve.ts`** が見る。
 *     1 ブロックだけでは判定できないため。
 *
 * throw しない。`.parse()` ではなく `.safeParse()` を使い Result で返す
 * （docs/error-handling-strategy.md §1, §5）。
 */

import { z } from 'zod'

import { err, ok, type Result } from '../result.ts'
import { HEADING_LEVELS, STANDING_BEARING_KINDS, THEOREM_LIKE_KINDS, THEOREM_STANDINGS } from './block.ts'
import type { Block, Note, StandingBearingKind, TheoremLikeKind } from './block.ts'

export type ValidationIssue = { path: string; message: string }

const issuesOf = (error: z.ZodError, prefix: string): ValidationIssue[] =>
  error.issues.map((issue) => ({
    path: [prefix, ...issue.path.map(String)].filter((part) => part !== '').join('.'),
    message: issue.message,
  }))

/** ノード。語彙が閉じていることを実行時にも表明する。 */
const nodeSchema: z.ZodType<unknown> = z.lazy(() =>
  z.discriminatedUnion('type', [
    z.object({ type: z.literal('text'), value: z.string() }).strict(),
    z.object({ type: z.literal('math'), tex: z.string() }).strict(),
    z.object({ type: z.literal('displayMath'), tex: z.string() }).strict(),
    z.object({ type: z.literal('todo'), value: z.string() }).strict(),
    z
      .object({ type: z.literal('image'), assetKey: z.string().min(1), alt: z.string().min(1) })
      .strict(),
    z
      .object({ type: z.literal('ref'), target: z.string().min(1), label: z.string().optional() })
      .strict(),
    // 引用キーの**実在**は `.bib` を読める出力器の仕事。ここで見るのは形だけで、
    // 「引用先の無い引用」（空配列）だけは意味を持たないので拒否する。
    z
      .object({
        type: z.literal('cite'),
        keys: z.array(z.string().min(1)).min(1),
        note: z.string().optional(),
      })
      .strict(),
    z.object({ type: z.literal('paragraph'), children: z.array(nodeSchema) }).strict(),
    z.object({ type: z.literal('list'), items: z.array(z.array(nodeSchema)) }).strict(),
  ]),
)

/** `text` か `tex` の少なくとも一方が必須（I4）。型側の union と同じ形にしてある。 */
const titleContentSchema = z.union([
  z.object({ text: z.string(), tex: z.string().optional() }).strict(),
  z.object({ text: z.string().optional(), tex: z.string() }).strict(),
])

const originSchema = z.object({ path: z.string(), ordinal: z.number().int().positive() }).strict()

const blockBaseShape = {
  id: z.string().min(1),
  labels: z.array(z.string().min(1)),
  origin: originSchema.optional(),
}

const headingSchema = z
  .object({
    ...blockBaseShape,
    kind: z.literal('heading'),
    // 型側は 1..6 のリテラル union。実行時は範囲で見る（同じ集合を 2 通りに書かない）。
    level: z
      .number()
      .int()
      .min(Math.min(...HEADING_LEVELS))
      .max(Math.max(...HEADING_LEVELS)),
    title: titleContentSchema,
  })
  .strict()

const figureSchema = z
  .object({
    ...blockBaseShape,
    kind: z.literal('figure'),
    content: z.array(nodeSchema),
    caption: z.array(nodeSchema).optional(),
  })
  .strict()

export type RuntimeSchema<L extends string, M> = {
  /** ブロック 1 件を検証する。`where` は診断に出す位置（ファイル名など）。 */
  validateBlock: (value: unknown, where: string) => Result<Block<L, M>, ValidationIssue[]>
  /** ブロック列を検証する。エラーは全件集めて返す（1 件目で止めない）。 */
  validateBlocks: (values: unknown, where: string) => Result<readonly Block<L, M>[], ValidationIssue[]>
  validateNote: (value: unknown, where: string) => Result<Note<L>, ValidationIssue[]>
  validateNotes: (values: unknown, where: string) => Result<readonly Note<L>[], ValidationIssue[]>
}

/**
 * プロジェクト固有メタデータ `MetaShape` を織り込んだ実行時スキーマを作る。
 *
 * ここで宣言されたキーだけが「未知フィールド」検査の許可キーに加わる。
 * 宣言しないキーを書くと `.strict()` が拒否する。打ち間違いで中身が黙って捨てられる事故
 * （先行実装で証明 2 件を失った事故と同じクラス）をここで塞ぐ。
 */
export const createRuntimeSchema = <
  L extends string = string,
  M = unknown,
  MetaShape extends z.ZodRawShape = Record<string, never>,
>(config?: {
  blockMeta?: MetaShape
  /**
   * 宣言されていないメタデータのキーをどう扱うか。既定は `reject`。
   *
   * `reject` … 未知のキーを拒否する。**語彙を所有する側（著者のプロジェクト）はこちら。**
   *            `proof` を `proofs` と打ち間違えて中身が黙って捨てられる事故を塞ぐのが目的。
   * `passthrough` … 未知のキーをそのまま通す。**語彙を所有しない側（汎用ビューア等、
   *            どのプロジェクトの文書でも読む立場）はこちら。** キー名を知りようがないので
   *            拒否しても打ち間違いの検出にはならず、正しい文書を読めなくするだけになる。
   *            値は検査しない（意味を解釈するのは語彙を所有する側の検証ツール）。
   *
   * 既定を `reject` にしてあるのは、「検査が緩いほうが既定」にならないようにするため。
   */
  unknownBlockMeta?: 'reject' | 'passthrough'
}): RuntimeSchema<L, M> => {
  const metaShape = config?.blockMeta ?? ({} as MetaShape)

  const theoremLikeBaseShape = {
    ...blockBaseShape,
    ...metaShape,
    title: titleContentSchema.nullish(),
    statement: z.array(nodeSchema),
    proof: z.array(nodeSchema).optional(),
  }

  // 身分（主定理 / サブ定理）を宣言できるのは主張型だけである。定義・注意・ノート側の
  // スキーマでは `standing` を「値を持ってはならないキー」として明示的に宣言しておく。
  // `.strict()` に任せると `passthrough`（語彙を所有しない読み手）で素通りしてしまう。
  const standingBearingObject = z.object({
    ...theoremLikeBaseShape,
    kind: z.enum(STANDING_BEARING_KINDS),
    standing: z.enum(THEOREM_STANDINGS).optional(),
  })
  const unrankedObject = z.object({
    ...theoremLikeBaseShape,
    kind: z.enum(
      THEOREM_LIKE_KINDS.filter(
        (kind): kind is Exclude<TheoremLikeKind, StandingBearingKind> =>
          !STANDING_BEARING_KINDS.includes(kind as StandingBearingKind),
      ) as unknown as [string, ...string[]],
    ),
    standing: z
      .undefined({
        invalid_type_error: `standing（主定理 / サブ定理の身分）を宣言できるのは ${STANDING_BEARING_KINDS.join(' / ')} だけである`,
      })
      .optional(),
  })
  // 見出しと図表はメタデータを持てない設計なので、常に strict のままにする。
  // 未知キーを通すのは「メタデータが載りうる定理型ブロック」だけである。
  const relaxed = config?.unknownBlockMeta === 'passthrough'
  const standingBearingSchema = relaxed
    ? standingBearingObject.passthrough()
    : standingBearingObject.strict()
  const unrankedSchema = relaxed ? unrankedObject.passthrough() : unrankedObject.strict()

  const noteSchema = z
    .object({
      id: z.string().min(1),
      targets: z.array(z.string().min(1)).min(1),
      title: titleContentSchema.nullish(),
      origin: originSchema.optional(),
      body: z.array(nodeSchema),
    })
    .strict()

  const validateBlock = (value: unknown, where: string): Result<Block<L, M>, ValidationIssue[]> => {
    if (typeof value !== 'object' || value === null || Array.isArray(value)) {
      return err([{ path: where, message: 'ブロックはオブジェクトでなければならない' }])
    }
    const kind = (value as { kind?: unknown }).kind
    const id = (value as { id?: unknown }).id
    const at = typeof id === 'string' ? `${where}:${id}` : where
    // kind で先に振り分ける。union のまま parse すると「どちらの候補にも合わない」という
    // 診断になり、どのフィールドが悪いのか読めなくなるため。
    const parsed =
      kind === 'heading'
        ? headingSchema.safeParse(value)
        : kind === 'figure'
          ? figureSchema.safeParse(value)
          : STANDING_BEARING_KINDS.includes(kind as StandingBearingKind)
            ? standingBearingSchema.safeParse(value)
            : unrankedSchema.safeParse(value)
    if (!parsed.success) return err(issuesOf(parsed.error, at))
    return ok(parsed.data as Block<L, M>)
  }

  const validateNote = (value: unknown, where: string): Result<Note<L>, ValidationIssue[]> => {
    const id = (value as { id?: unknown } | null)?.id
    const at = typeof id === 'string' ? `${where}:${id}` : where
    const parsed = noteSchema.safeParse(value)
    if (!parsed.success) return err(issuesOf(parsed.error, at))
    // 実行時にはラベルのユニオン型 `L` が存在しない（型は消える）。ここは
    // 「1 件以上の文字列」までを実行時に確かめ、`L` への絞り込みは境界のこの 1 か所だけで行う。
    // ラベルが実在するかどうかは文書全体を見る `resolve` が判定する（I2）。
    return ok(parsed.data as unknown as Note<L>)
  }

  const validateEach = <T>(
    values: unknown,
    where: string,
    validateOne: (value: unknown, where: string) => Result<T, ValidationIssue[]>,
  ): Result<readonly T[], ValidationIssue[]> => {
    if (!Array.isArray(values)) {
      return err([{ path: where, message: '配列でなければならない' }])
    }
    const data: T[] = []
    const issues: ValidationIssue[] = []
    values.forEach((value, index) => {
      const result = validateOne(value, `${where}[${index}]`)
      if (result.success) data.push(result.data)
      else issues.push(...result.error)
    })
    return issues.length > 0 ? err(issues) : ok(data)
  }

  return {
    validateBlock,
    validateBlocks: (values, where) => validateEach(values, where, validateBlock),
    validateNote,
    validateNotes: (values, where) => validateEach(values, where, validateNote),
  }
}
