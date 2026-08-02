/**
 * **検査 T（`field_simp` の直後の `ring`）の型と走査**。
 *
 * ## なぜこの検査が要るのか（3 サイクル連続の再発を検査にする）
 *
 * `field_simp` はしばしばゴールを閉じきる。閉じたあとに `ring` を書くと Lean は
 * `No goals to be solved` で落ちる。この誤りは記録されているのに 3 サイクル連続で再発した:
 *
 * | いつ | 記録 |
 * |---|---|
 * | cycle 23 step 4 | `cycle23_ops_lean_cycle22_theorems.md` §7 の誤り 2 |
 * | cycle 24 step 5 | `cycle24_ops_lean_cycle23_corrections.md` §6 の誤り 1（「記録を読んだうえで再発」） |
 * | cycle 25 step 3 | `cycle25_ops_lean_cycle25.md` §7 の誤り 1（最重。2 箇所） |
 *
 * cycle 25 step 3 の記録が、なぜ注意書きで止まらないかを言い当てている——
 * **「`field_simp` を書いた瞬間に `ring` まで一続きの語として出力されるので、
 * 読んだ記憶は出力の途中に介在しない。機械で落ちる形にするしかない。」**
 * 同記録は是正の形まで指定している: **`field_simp` の直後に `ring` を書かないという構文レベルの禁止**。
 *
 * ## どう禁止するか（一律禁止にはできない。既存 10 箇所は `ring` が必要である）
 *
 * `field_simp` の直後の `ring` が**必要な場合もある**。実測では現在 10 箇所あり、
 * **`lake build` が通っている以上、その 10 箇所の `ring` はいずれも必要である**——
 * 不要なら Lean が `No goals to be solved` で落ちるからである。
 * したがって一律禁止は 10 件の偽陽性を出す。
 *
 * そこで**宣言制**にする。既存の対は 1 つずつ台帳（`lean-tactic-allowances.ts`）に登録し、
 * **新しく書かれた対は宣言が無いので即座に赤くなる**。これが求められている guard である:
 * 新しく `field_simp; ring` を書いた手は、`lake build` を回すより早く
 * `npm run check` の早い段で止まり、**1 つ目で閉じないことを確かめてから 2 つ目を書く**
 * 手順へ戻される。
 *
 * 台帳が腐ったら赤くなる（cycle 24 step 3 以来の設計）:
 * 宣言が指す宣言名がファイルに無い／その宣言の中にもう対が無い／対の個数が宣言と違う、
 * のいずれでも落ちる。**直したのに宣言が残る状態は作れない。**
 *
 * ## 限界（正直に書く）
 *
 * - **この検査は `ring` が必要かどうかを自分で確かめない。** 確かめるのは `lake build` である
 *   （不要なら落ちる）。この検査が保証するのは「新しい対が黙って入らないこと」だけである。
 * - 走査は**行ベース**である。`field_simp` と `ring` が同じ行に `;` で並ぶ形、
 *   `<;>` で繋がる形、`ring_nf` は**対象外**（実測 0 件。増えたらここを広げること）。
 * - 対象は `lean/IntegrableLattice/` 配下の `.lean` だけ。
 */

export type TacticPairSite = {
  /** `lean/` からの相対パス。 */
  readonly file: string;
  /** その対を含む宣言（`theorem` / `lemma` / `def` …）の名前。 */
  readonly declaration: string;
  /** 同じ宣言の中で何番目の対か（0 始まり）。同じ宣言に複数あるため。 */
  readonly index: number;
  /** `ring` の行番号（1 始まり。報告用。台帳の同一性判定には使わない）。 */
  readonly line: number;
};

export type TacticPairAllowance = {
  readonly file: string;
  readonly declaration: string;
  readonly index: number;
  /** なぜこの対を許すのか。 */
  readonly reason: string;
};

const DECL_RE =
  /^\s*(?:private\s+|protected\s+|noncomputable\s+)*(?:theorem|lemma|example|def|instance|abbrev)\s+([^\s({\[:]+)/;

/** `field_simp` だけの行（末尾の空白・行コメントは許す）。 */
const FIELD_SIMP_RE = /^\s*field_simp\s*(?:--.*)?$/;
/** `ring` だけの行。 */
const RING_RE = /^\s*ring\s*(?:--.*)?$/;

/** 1 ファイル分の走査。`field_simp` の**次の行**が `ring` である箇所を返す。 */
export const scanFile = (file: string, source: string): TacticPairSite[] => {
  const lines = source.split("\n");
  const found: TacticPairSite[] = [];
  const perDeclaration = new Map<string, number>();
  let declaration = "(ファイル先頭。宣言の外)";
  for (const [i, line] of lines.entries()) {
    const declMatch = DECL_RE.exec(line);
    if (declMatch?.[1] !== undefined) declaration = declMatch[1];
    if (!FIELD_SIMP_RE.test(line)) continue;
    const next = lines[i + 1];
    if (next === undefined || !RING_RE.test(next)) continue;
    const index = perDeclaration.get(declaration) ?? 0;
    perDeclaration.set(declaration, index + 1);
    found.push({ file, declaration, index, line: i + 2 });
  }
  return found;
};

export const keyOf = (site: { file: string; declaration: string; index: number }): string =>
  `${site.file}::${site.declaration}#${site.index}`;
