/**
 * **検査 R の中身**（`verify-reference-rot.ts` は入出力だけを持つ）。
 *
 * 動機（cycle 24 step 2 で実際に起きたこと）: 英語版をローカライズモデルへ移したとき、
 * 「本文の文言を変えない」という方針を守った結果、**移した 12 ファイルの先頭コメントが
 * 撤去済みの `verify-ja-en-correspondence.ts`・存在しない `npm run verify:correspondence`・
 * 誤った相対パス `../../structured-latex/content/...` を指したまま腐った**。
 * 呼び出し元が手で見つけたので直ったが、**検査は素通りした**。
 * cycle 24 総括はこれを「本文中のツールへの参照は自動では直らない」と記録し、
 * 次サイクルの機械検出の対象に挙げている。
 *
 * ここが見るのは 3 種類だけである。**いずれも「実在するか」しか見ない**（§ 限界）。
 *
 *   1. **パス参照**   … 相対パス・リポジトリ相対パスが実在するファイル／ディレクトリを指すこと。
 *   2. **スクリプト名** … npm run <名前> / pnpm <名前> の名前が、その場所を治める package.json に実在すること。
 *   3. **ファイル名**  … 拡張子つきの裸のファイル名（`verify-ja-en-correspondence.ts` 等）が
 *                        リポジトリのどこかに実在すること。
 *
 * **限界（先に書く）**:
 *   - 「実在するが**別のものを指している**」参照は検出できない。実在性しか見ていない。
 *   - 文中の自然文としてのファイル名（拡張子を書かない言及）は拾えない。
 *   - `*` を含む記述（`content/*.ts` のような集合の指示）は候補から外している。
 *     glob を実際に展開して 0 件なら赤、という検査はしていない。
 *   - 走査対象は「腐りが実際に起きた場所」に限る（下の `SCAN_ROOTS`）。
 *     `outputs/reports/` は**過去の状態の記録**であり、当時実在したものを指す記述が
 *     現在実在しないのは腐りではないので、対象にしない（§ `SCAN_ROOTS` の doc）。
 */

import { readFile, readdir, stat } from "node:fs/promises";
import { dirname, join, relative, resolve } from "node:path";

import { projectRoot } from "./transcription-model.ts";

/** リポジトリのルート（`integrable-lattice/` の親）。 */
export const repoRoot = resolve(projectRoot, "..");

/** このプロジェクトの構造化テキスト（論文の中身）。 */
export const projectStructuredLatex = join(projectRoot, "structured-latex");

/** 入力言語のシステム（リポジトリ直下）。 */
export const systemStructuredLatex = join(repoRoot, "structured-latex");

/**
 * **走査対象**。`integrable-lattice/` からの相対で書く。
 *
 * 選定の根拠（一次情報）:
 *   - `structured-latex/content` と `structured-latex/locales` … **腐りが実際に起きた場所**
 *     （cycle 24 step 2。移動した英語本文 12 ファイルの先頭コメント）。
 *   - `structured-latex/tools` と `structured-latex/*.ts` … 検査道具どうしの参照。
 *     ツール名の変更で最初に腐るのはここである。
 *   - `docs/` と `README.md` / `MEMORY.md` … 作業手順がここからツールを名指しする
 *     （runbook の「検出ツール verify-no-lost-proofs.mjs を流用してよい」など）。
 *
 * **入れていないもの**:
 *   - `outputs/reports/` … report は**その時点の作業の記録**である。当時実在したファイルを
 *     指す記述が、後で撤去されて実在しなくなるのは腐りではなく履歴として正しい。
 *     ここを対象にすると「過去を書き換えろ」という圧力になるので入れない。
 *   - `MEMORY.md` と `docs/tasks/auto-loop-state.md` … 同じ理由。どちらも**追記専用の履歴**で、
 *     「当時 …、現在は …」という書き方が実際に多数ある（実測 20 件）。
 *     ここを対象にすると、毎サイクル追記されるたびに無関係な赤が出る。
 *   - `_old/` … 温存退避したものなので、外を指す参照が古いのは当然である。
 *   - `sagemath/` / `lean/` … 本 step の担当外であり、腐りの実例も無い。将来広げてよい。
 *
 * **除外は黙って行わない。** `verify-reference-rot` は毎回この除外の一覧を出力する。
 */
export const SCAN_ROOTS: readonly string[] = [
  "structured-latex/content",
  "structured-latex/locales",
  "structured-latex/tools",
  "structured-latex/schema.ts",
  "structured-latex/locales.config.ts",
  "docs",
  "README.md",
];

/** 走査から外した場所と、その理由（毎回出力する）。 */
export const SCAN_EXCLUSIONS: readonly { where: string; why: string }[] = [
  { where: "outputs/reports/", why: "作業時点の記録。当時実在したものを指す記述は腐りではない" },
  { where: "MEMORY.md", why: "追記専用の履歴（「当時 …、現在は …」が実測 20 件）" },
  { where: "docs/tasks/auto-loop-state.md", why: "追記専用の履歴（同上）" },
  { where: "_old/", why: "温存退避。外を指す参照が古いのは当然" },
  { where: "sagemath/ · lean/ · inputs/ · pipeline/", why: "本 step の担当外。腐りの実例も無い" },
];

/** 走査するファイルの拡張子。 */
const SCANNED_EXTENSIONS = [".ts", ".md"];

/** 参照とみなす拡張子（この拡張子で終わる語をファイル参照の候補にする）。 */
const REFERENCE_EXTENSIONS = [
  ".ts", ".mjs", ".cjs", ".js", ".json", ".md", ".sage", ".sh", ".py",
  ".lean", ".typ", ".tex", ".bib", ".yml", ".yaml", ".toml", ".csv", ".pdf",
];

/** `pnpm <x>` の x が pnpm 自身のサブコマンドなら、スクリプト名ではない。 */
const PNPM_BUILTINS = new Set([
  "install", "i", "add", "remove", "rm", "update", "up", "why", "list", "ls",
  "exec", "dlx", "create", "init", "link", "unlink", "import", "prune", "store",
  "publish", "pack", "audit", "outdated", "licenses", "patch", "dedupe", "run",
  "config", "setup", "env", "server", "deploy", "fetch", "rebuild", "root", "bin",
]);

export type ReferenceKind = "path" | "script" | "basename";

export type FoundReference = {
  /** `integrable-lattice/` からの相対パス。 */
  file: string;
  line: number;
  /** 書かれているとおりの文字列。 */
  text: string;
  kind: ReferenceKind;
  /** その行（人が読むため・免除の pin に使う）。 */
  lineText: string;
};

export type RotFinding = FoundReference & {
  reason: "実在しないパス" | "実在しない npm script" | "実在しないファイル名";
  detail: string;
};

// --- 抽出 ---------------------------------------------------------------------

/**
 * その行のうち**コードとして書かれた部分**（インラインコード `` `…` ``）だけを返す。
 *
 * **なぜ地の文を見ないか。** 参照は文章の中でも「sagemath/Lean 投下可」のように
 * スラッシュ入りの語として現れるが、それはファイルを指していない。実際に起きた腐り
 * （cycle 24 step 2）は **3 件とも** `` `tools/verify-ja-en-correspondence.ts` ``、
 * `` `npm run verify:correspondence` ``、`` `../../structured-latex/content/001_intro.ts` `` と
 * **バッククォートの中**に書かれていた。「参照として書いたもの」を見るのが正しい範囲であり、
 * これを広げると地の文の言い回しが大量に偽陽性になる（実測 164 件 → §限界）。
 *
 * TypeScript のソースでは import 文が範囲外になるが、**そちらは `tsc` が既に解決を検査する**ので
 * 取りこぼしではない。
 */
export function codeSpansOf(lineText: string): string[] {
  const out: string[] = [];
  for (const m of lineText.matchAll(/`([^`]+)`/g)) out.push(m[1]!);
  return out;
}

/**
 * 1 行から参照の候補を取り出す。
 *
 * `firstSegments` は「リポジトリに実在する第 1 階層の名前」の集合。**データで決める**
 * （ツール側に `docs`・`outputs` などと書き写すと、ディレクトリが増減したとき黙ってずれる）。
 * これにより `1/2`（分数）や `math-ph/9904003`（arXiv id）はパス候補にならない。
 *
 * `inCodeBlock` が真なら行全体をコードとして見る（markdown のフェンスの中）。
 */
export function extractReferences(
  lineText: string,
  firstSegments: ReadonlySet<string>,
  inCodeBlock = false,
): { text: string; kind: ReferenceKind }[] {
  const out: { text: string; kind: ReferenceKind }[] = [];
  const seen = new Set<string>();
  const push = (text: string, kind: ReferenceKind): void => {
    const key = `${kind}:${text}`;
    if (seen.has(key)) return;
    seen.add(key);
    out.push({ text, kind });
  };

  const spans = inCodeBlock ? [lineText] : codeSpansOf(lineText);
  for (const rawSpan of spans) {
    // markdown の表・見出しで `\_` と書かれることがある（表示上の下線のエスケープ）。
    // `${…}` は TypeScript のテンプレート文字列の埋め込み式（`${node.tex}` 等）であって
    // ファイル参照ではない。式ごと落とす（残すと node.tex を「実在しないファイル」と読む）。
    const span = rawSpan.replaceAll("\\_", "_").replaceAll(/\$\{[^}]*\}/g, "");

    // 1. npm / pnpm スクリプト名
    for (const m of span.matchAll(/\b(?:npm run|pnpm run|yarn run|pnpm)\s+([A-Za-z][A-Za-z0-9:_-]*)/g)) {
      const name = m[1]!;
      if (m[0].startsWith("pnpm ") && !m[0].startsWith("pnpm run") && PNPM_BUILTINS.has(name)) continue;
      push(name, "script");
    }

    // 2. パス・ファイル名
    for (const m of span.matchAll(/[A-Za-z0-9_@.][A-Za-z0-9_@./+-]*/g)) {
      const after = span[m.index + m[0].length];
      // `xxx*`（glob）・`xxx<topic>`（穴あき）は「集合の指示」であって参照ではない
      if (after === "*" || after === "<") continue;
      const trimmed = trimPunctuation(m[0]);
      if (trimmed === "") continue;
      if (trimmed.includes("://") || /^https?$/i.test(trimmed)) continue;
      const head = trimmed.split("/")[0]!;
      // 外部のホスト名（`zbmath.org/static/...`）はリポジトリ内のパスではない
      if (/^[a-z0-9-]+\.[a-z]{2,}$/i.test(head) && trimmed.includes("/")) continue;
      const hasSlash = trimmed.includes("/");
      const ext = REFERENCE_EXTENSIONS.find((e) => trimmed.endsWith(e));
      if (ext !== undefined) {
        // 「拡張子だけ」（`.mjs` のような書き方）は参照ではない
        const base = trimmed.slice(trimmed.lastIndexOf("/") + 1);
        if (!/^[A-Za-z0-9_]/.test(base)) continue;
        push(trimmed, hasSlash ? "path" : "basename");
        continue;
      }
      if (!hasSlash) continue;
      if (head === "." || head === ".." || firstSegments.has(head)) {
        // ディレクトリ参照とみなす（末尾の `/` はあってもなくてもよい）
        push(trimmed, "path");
      }
    }
  }
  return out;
}

/** 前後の記号・句読点を落とす（``` `path` ``` や `path。` や `(path)` から本体を取る）。 */
function trimPunctuation(token: string): string {
  let s = token;
  while (s.length > 0 && /[.,;:)\]}]$/.test(s)) s = s.slice(0, -1);
  while (s.length > 0 && /^[.]$/.test(s[0]!) && !s.startsWith("./") && !s.startsWith("../") && !s.startsWith(".")) {
    s = s.slice(1);
  }
  return s;
}

// --- 走査 ---------------------------------------------------------------------

/** `docs/` の中にあるが履歴なので外すもの（`SCAN_EXCLUSIONS` に理由がある）。 */
const EXCLUDED_FILES = new Set([join(projectRoot, "docs", "tasks", "auto-loop-state.md")]);

async function listFilesUnder(absolute: string, out: string[]): Promise<void> {
  if (EXCLUDED_FILES.has(absolute)) return;
  let info;
  try {
    info = await stat(absolute);
  } catch {
    return;
  }
  if (info.isFile()) {
    if (SCANNED_EXTENSIONS.some((e) => absolute.endsWith(e))) out.push(absolute);
    return;
  }
  for (const entry of await readdir(absolute, { withFileTypes: true })) {
    if (entry.name.startsWith(".") || entry.name === "node_modules") continue;
    await listFilesUnder(join(absolute, entry.name), out);
  }
}

/** 走査対象のファイル（`integrable-lattice/` からの相対、昇順）。 */
export async function scanTargets(roots: readonly string[] = SCAN_ROOTS): Promise<string[]> {
  const absolute: string[] = [];
  for (const root of roots) await listFilesUnder(join(projectRoot, root), absolute);
  return absolute.map((p) => relative(projectRoot, p)).sort();
}

/** リポジトリ第 1 階層の名前（`extractReferences` の判定材料。データで決める）。 */
export async function firstSegmentsOfRepo(): Promise<Set<string>> {
  const out = new Set<string>();
  for (const dir of [repoRoot, projectRoot]) {
    for (const entry of await readdir(dir, { withFileTypes: true })) {
      if (entry.name.startsWith(".")) continue;
      out.add(entry.name);
    }
  }
  return out;
}

export async function collectReferences(files: readonly string[]): Promise<FoundReference[]> {
  const firstSegments = await firstSegmentsOfRepo();
  const out: FoundReference[] = [];
  for (const file of files) {
    const text = await readFile(join(projectRoot, file), "utf8");
    let inCodeBlock = false;
    text.split("\n").forEach((lineText, index) => {
      if (file.endsWith(".md") && lineText.trimStart().startsWith("```")) {
        inCodeBlock = !inCodeBlock;
        return;
      }
      for (const { text: reference, kind } of extractReferences(lineText, firstSegments, inCodeBlock)) {
        out.push({ file, line: index + 1, text: reference, kind, lineText: lineText.trim() });
      }
    });
  }
  return out;
}

// --- 解決 ---------------------------------------------------------------------

const existsCache = new Map<string, boolean>();
async function exists(absolute: string): Promise<boolean> {
  const cached = existsCache.get(absolute);
  if (cached !== undefined) return cached;
  let ok = true;
  try {
    await stat(absolute);
  } catch {
    ok = false;
  }
  existsCache.set(absolute, ok);
  return ok;
}

/** 拡張子つきの裸のファイル名の索引（リポジトリ全体。`node_modules` と `.git` を除く）。 */
let basenameIndex: Set<string> | undefined;
async function basenamesOfRepo(): Promise<Set<string>> {
  if (basenameIndex !== undefined) return basenameIndex;
  const out = new Set<string>();
  const walk = async (dir: string): Promise<void> => {
    for (const entry of await readdir(dir, { withFileTypes: true })) {
      if (entry.name === "node_modules" || entry.name === ".git") continue;
      if (entry.isDirectory()) await walk(join(dir, entry.name));
      else out.add(entry.name);
    }
  };
  await walk(repoRoot);
  basenameIndex = out;
  return out;
}

/** そのファイルを治める package.json（最も近い祖先）。無ければ undefined。 */
async function nearestPackageJson(fileAbsolute: string): Promise<string | undefined> {
  let dir = dirname(fileAbsolute);
  for (;;) {
    const candidate = join(dir, "package.json");
    if (await exists(candidate)) return candidate;
    const parent = dirname(dir);
    if (parent === dir || !parent.startsWith(repoRoot)) return undefined;
    dir = parent;
  }
}

const scriptsCache = new Map<string, Set<string>>();
async function scriptsOf(packageJson: string): Promise<Set<string>> {
  const cached = scriptsCache.get(packageJson);
  if (cached !== undefined) return cached;
  const parsed = JSON.parse(await readFile(packageJson, "utf8")) as { scripts?: Record<string, unknown> };
  const out = new Set(Object.keys(parsed.scripts ?? {}));
  scriptsCache.set(packageJson, out);
  return out;
}

/** リポジトリ内の全 package.json のスクリプト名（治める package.json が無い場所のため）。 */
let allScripts: Set<string> | undefined;
async function allScriptNames(): Promise<Set<string>> {
  if (allScripts !== undefined) return allScripts;
  const out = new Set<string>();
  const walk = async (dir: string): Promise<void> => {
    for (const entry of await readdir(dir, { withFileTypes: true })) {
      if (entry.name === "node_modules" || entry.name === ".git") continue;
      if (entry.isDirectory()) await walk(join(dir, entry.name));
      else if (entry.name === "package.json") {
        for (const name of await scriptsOf(join(dir, entry.name))) out.add(name);
      }
    }
  };
  await walk(repoRoot);
  allScripts = out;
  return out;
}

/**
 * 参照 1 件を解決する。解決できなければ違反。
 *
 * 解決の順序（甘い側へ倒してある。**偽陽性を出さないこと**を優先する）:
 *   - `./` `../` で始まるパス … そのファイルからの相対**だけ**（書き手が意図した基準が一意なので）
 *   - それ以外のパス       … そのファイルからの相対 / リポジトリ root / `integrable-lattice/` /
 *                            プロジェクトの structured-latex / システムの structured-latex
 *   - 裸のファイル名       … 上に加えてリポジトリ全体のファイル名索引
 *   - スクリプト名         … そのファイルを治める package.json（無ければリポジトリ全体）
 */
export async function resolveReference(reference: FoundReference): Promise<RotFinding | undefined> {
  const fileAbsolute = join(projectRoot, reference.file);
  if (reference.kind === "script") {
    const packageJson = await nearestPackageJson(fileAbsolute);
    const names = packageJson === undefined ? await allScriptNames() : await scriptsOf(packageJson);
    if (names.has(reference.text)) return undefined;
    return {
      ...reference,
      reason: "実在しない npm script",
      detail:
        packageJson === undefined
          ? `リポジトリ内のどの package.json にも "${reference.text}" が無い`
          : `${relative(repoRoot, packageJson)} に "${reference.text}" が無い`,
    };
  }

  const relativeStart = reference.text.startsWith("./") || reference.text.startsWith("../");
  const roots = relativeStart
    ? [dirname(fileAbsolute)]
    : [dirname(fileAbsolute), repoRoot, projectRoot, projectStructuredLatex, systemStructuredLatex];
  for (const root of roots) {
    if (await exists(resolve(root, reference.text))) return undefined;
  }
  if (reference.kind === "basename") {
    if ((await basenamesOfRepo()).has(reference.text)) return undefined;
    return {
      ...reference,
      reason: "実在しないファイル名",
      detail: `リポジトリのどこにも "${reference.text}" というファイルが無い`,
    };
  }
  return {
    ...reference,
    reason: "実在しないパス",
    detail: `次のどこからも解決できない: ${roots.map((r) => relative(repoRoot, r) || ".").join(" / ")}`,
  };
}

export async function findRot(files: readonly string[]): Promise<RotFinding[]> {
  const references = await collectReferences(files);
  const out: RotFinding[] = [];
  for (const reference of references) {
    const finding = await resolveReference(reference);
    if (finding !== undefined) out.push(finding);
  }
  return out;
}

// --- 免除（実在しないが正当な記述）と、その腐りの検出 -------------------------------

/**
 * **実在しない参照を認める宣言。**
 *
 * 実在しない記述にも正当なものがある。放置すると検査が赤のままになり、他の作業が止まる。
 * かといって黙って通すと、cycle 24 step 2 の腐り（撤去済みツールを現在形で指す）が
 * また素通りする。そこで**1 件ずつ、型つきで宣言させ、宣言が腐ったら赤くする**。
 *
 * どの型でも共通に次を検査する（`checkAllowances`）。
 *   - その参照が**いまもそのファイルに書かれていること**（消えたら宣言は余りである＝赤）。
 *   - その参照が**いまも解決できないこと**（実在するようになったら宣言は余りである＝赤）。
 *   - 型ごとの根拠が生きていること（下の各型）。
 */
export type ReferenceAllowance = {
  /** `integrable-lattice/` からの相対パス。 */
  file: string;
  /** 参照の文字列（書かれているとおり）。 */
  reference: string;
  /** 人が読む理由。 */
  reason: string;
  grounds: ReferenceGrounds;
};

export type ReferenceGrounds =
  /**
   * **過去の状態として書かれている**（「cycle 24 step 2 までは …」「以前は …」）。
   * 腐り方: その文が現在形へ書き換えられると、過去の記述という前提が消える。
   * 検査: `marker` が**同じファイル**に実在すること。
   * **検証できないこと**: 「過去形で書いてある」という判定そのもの。
   */
  | { type: "historical"; marker: string }
  /**
   * **例示・否定の文脈**（「そうしていない」「こう書いてはならない」の例として名を挙げている）。
   * 腐り方: その文脈が消えると、ただの誤った参照になる。
   * 検査: `marker` が同じファイルに実在すること。
   */
  | { type: "illustration"; marker: string }
  /**
   * **生成物**（`build/` 以下。gitignore されるので普段は実在しない）。
   * 腐り方: それを作るスクリプトが消える／改名されると、その記述は嘘になる。
   * 検査: `producedBy` がプロジェクトの package.json のスクリプトに実在すること。
   */
  | { type: "generated"; producedBy: string }
  /**
   * **別プロジェクトのファイル**（「Ising 側にある …」）。
   * 腐り方: 向こうがそのファイルを消すと、記述は嘘になる。
   * 検査: `project` の下に実在すること。
   */
  | { type: "otherProject"; project: string }
  /**
   * **本当に腐っている。ただし直すのが本 step の担当範囲外。**
   * 黙らせるためではなく、**直すべきものとして記録**するための型である。
   * 腐り方: 記録が消えたらただの黙殺になる。
   * 検査: `recordedIn` の report が実在し、`marker` を含むこと。
   * なお**直れば「宣言が余っている」で赤になる**ので、両方向が閉じている。
   */
  | { type: "outOfScope"; ownedBy: string; recordedIn: { report: string; marker: string } };

export type AllowanceFinding = {
  file: string;
  reference: string;
  kind:
    | "宣言が指すファイルが読めない"
    | "宣言が余っている（その参照がもう書かれていない）"
    | "宣言が余っている（その参照が解決するようになった）"
    | "根拠の目印が同じファイルに無い"
    | "生成物を作るスクリプトが無い"
    | "別プロジェクトにもそのファイルが無い"
    | "記録が見つからない"
    | "根拠の指定が短すぎて何も pin していない";
  detail: string;
};

const MIN_MARKER = 10;

/** 免除の根拠が生きているかを検査する。 */
export async function checkAllowances(
  allowances: readonly ReferenceAllowance[],
): Promise<AllowanceFinding[]> {
  const firstSegments = await firstSegmentsOfRepo();
  const out: AllowanceFinding[] = [];
  const add = (file: string, reference: string, kind: AllowanceFinding["kind"], detail: string): void => {
    out.push({ file, reference, kind, detail });
  };

  for (const allowance of allowances) {
    const { file, reference, grounds } = allowance;
    let text: string;
    try {
      text = await readFile(join(projectRoot, file), "utf8");
    } catch {
      add(file, reference, "宣言が指すファイルが読めない", `${file} が読めない。宣言を消すこと`);
      continue;
    }
    const lines = text.split("\n");

    // 共通 1: その参照がいまもそのファイルに書かれていること（抽出器を通す。目で見た文字列ではなく
    // 「検査が実際に参照として取り出すもの」と一致していなければ、宣言は当たっていない）
    let inCodeBlock = false;
    let found = false;
    for (const lineText of lines) {
      if (file.endsWith(".md") && lineText.trimStart().startsWith("```")) {
        inCodeBlock = !inCodeBlock;
        continue;
      }
      if (extractReferences(lineText, firstSegments, inCodeBlock).some((r) => r.text === reference)) {
        found = true;
        break;
      }
    }
    if (!found) {
      add(file, reference, "宣言が余っている（その参照がもう書かれていない）", `${file} に "${reference}" が無い。宣言を消すこと`);
      continue;
    }

    // 共通 2: いまも解決できないこと。
    // **`generated` だけは除く。** 生成物は「ビルドを走らせたか」で実在が変わるので、
    // 実在を条件にすると `npm run check` の中での実行順（`verify:no-notes` がビルドする）に
    // 結果が依存してしまう。生成物の免除が腐るのは「作るスクリプトが消えたとき」だけである。
    if (grounds.type === "generated") {
      const names = await scriptsOf(join(projectStructuredLatex, "package.json"));
      if (!names.has(grounds.producedBy)) {
        add(file, reference, "生成物を作るスクリプトが無い", `package.json に "${grounds.producedBy}" が無い。生成物の作り方が変わったなら記述を直すこと`);
      }
      continue;
    }
    const kind: ReferenceKind = reference.includes("/")
      ? "path"
      : REFERENCE_EXTENSIONS.some((e) => reference.endsWith(e))
        ? "basename"
        : "script";
    const still = await resolveReference({ file, line: 0, text: reference, kind, lineText: "" });
    if (still === undefined) {
      add(file, reference, "宣言が余っている（その参照が解決するようになった）", `"${reference}" は実在するようになった。宣言を消すこと`);
      continue;
    }

    // 型ごとの根拠
    if (grounds.type === "historical" || grounds.type === "illustration") {
      if (grounds.marker.length < MIN_MARKER) {
        add(file, reference, "根拠の指定が短すぎて何も pin していない", `marker が ${grounds.marker.length} 文字: "${grounds.marker}"`);
      } else if (!text.includes(grounds.marker)) {
        add(file, reference, "根拠の目印が同じファイルに無い", `${file} に "${grounds.marker}" が無い。文が書き換わったなら判定し直すこと`);
      }
      continue;
    }
    if (grounds.type === "otherProject") {
      const roots = [
        join(repoRoot, grounds.project),
        join(repoRoot, grounds.project, "structured-latex"),
      ];
      let ok = false;
      for (const root of roots) if (await exists(resolve(root, reference))) ok = true;
      if (!ok) {
        add(file, reference, "別プロジェクトにもそのファイルが無い", `${grounds.project} の下にも "${reference}" が無い`);
      }
      continue;
    }
    const { report, marker } = grounds.recordedIn;
    if (marker.length < MIN_MARKER) {
      add(file, reference, "根拠の指定が短すぎて何も pin していない", `marker が ${marker.length} 文字: "${marker}"`);
      continue;
    }
    let record: string;
    try {
      record = await readFile(join(projectRoot, report), "utf8");
    } catch {
      add(file, reference, "記録が見つからない", `${report} が読めない`);
      continue;
    }
    if (!record.includes(marker)) {
      add(file, reference, "記録が見つからない", `${report} に "${marker}" が無い。記録が消えたら、これはただの黙殺である`);
    }
  }
  return out;
}

/** 免除で説明できない腐りだけを返す。 */
export function unexplained(
  findings: readonly RotFinding[],
  allowances: readonly ReferenceAllowance[],
): RotFinding[] {
  const allowed = new Set(allowances.map((a) => `${a.file} ${a.reference}`));
  return findings.filter((f) => !allowed.has(`${f.file} ${f.text}`));
}

/**
 * 1 件も当たらなかった免除（登録が古い）。
 *
 * `generated` は除く。生成物はビルドを走らせたかで実在が変わるので、
 * 「腐りとして挙がらなかった＝免除が余っている」とは言えない
 * （`checkAllowances` の共通 2 を `generated` で外しているのと同じ理由）。
 */
export function unusedAllowances(
  findings: readonly RotFinding[],
  allowances: readonly ReferenceAllowance[],
): ReferenceAllowance[] {
  const hit = new Set(findings.map((f) => `${f.file} ${f.text}`));
  return allowances
    .filter((a) => a.grounds.type !== "generated")
    .filter((a) => !hit.has(`${a.file} ${a.reference}`));
}
