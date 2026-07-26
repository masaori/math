#!/usr/bin/env node
/**
 * `content/*.mjs` と `notes/*.mjs` を `.ts` へ一括変換する codemod（第2段の実行手段）。
 *
 * 変換内容はこれだけである（本文の中身には一切触れない）:
 *   - 拡張子 `.mjs` → `.ts`（`git mv` で履歴を繋ぐ）
 *   - スキーマの import 指定子 `"../schema.mjs"` → `"../schema.ts"`
 *     （Node 22.18+ は `.ts` を型ストリップでそのまま読むため、ビルド成果物は不要）
 *   - その import 行のうち、そのファイルで使っていない名前を落とす
 *     （`.mjs` では無害だったが、`tsc` の `noUnusedLocals` が拾うため）
 *
 * 変換後は `tsc --noEmit` の検査対象に入るので、存在しないラベルへの参照・
 * 未登録ラベルの宣言・見出しへの本文混入などが**コンパイル時**に落ちるようになる。
 *
 * 使い方:
 *   node tools/codemod-mjs-to-ts.ts                 変換内容を表示するだけ（dry-run 既定）
 *   node tools/codemod-mjs-to-ts.ts --out-dir DIR   リポジトリを触らず DIR へ変換結果を書く（試験用）
 *   node tools/codemod-mjs-to-ts.ts --apply         実際に content/ と notes/ を変換する
 */

import { spawnSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { basename, join } from "node:path";

import ts from "typescript";

import { contentDir, listSourceFiles, notesDir, structuredLatexDir } from "./content-modules.ts";

const argv = process.argv.slice(2);
const apply = argv.includes("--apply");
const outDirIndex = argv.indexOf("--out-dir");
const outDir: string | undefined = outDirIndex === -1 ? undefined : argv[outDirIndex + 1];

if (outDirIndex !== -1 && (outDir === undefined || outDir.startsWith("--"))) {
  throw new Error("--out-dir にはディレクトリを指定する");
}
if (apply && outDir !== undefined) {
  throw new Error("--apply と --out-dir は同時に使えない");
}

/** import 指定子の書き換え。ここに書いた規則以外は変換しない。 */
const IMPORT_REWRITES: readonly [RegExp, string][] = [
  [/(from\s+["'])(\.\.?\/[^"']*?)\.mjs(["'])/g, "$1$2.ts$3"],
];

type Conversion = {
  dir: string;
  fileName: string;
  targetName: string;
  source: string;
  converted: string;
};

/**
 * named import のうち、本文で実際に使っていない名前を落とす（import 宣言すべてが対象）。
 *
 * 判定は TypeScript の構文解析による識別子の出現（文字列リテラルの中の同名語を
 * 「使用」と誤判定しないため。本文には「todo を除去した」のような日本語の記述が実在する）。
 * 書き換えるのは import 行だけで、本文には触れない。
 * default / namespace import を伴う宣言は、規則の想定外として触らない。
 */
function dropUnusedNamedImports(source: string, fileName: string): string {
  const sourceFile = ts.createSourceFile(fileName, source, ts.ScriptTarget.ES2022, true);
  const importDecls = sourceFile.statements.filter(
    (statement): statement is ts.ImportDeclaration => ts.isImportDeclaration(statement),
  );
  if (importDecls.length === 0) return source;

  const usedIdentifiers = new Set<string>();
  const visit = (node: ts.Node): void => {
    if (importDecls.includes(node as ts.ImportDeclaration)) return; // import 行自身は数えない
    if (ts.isIdentifier(node)) usedIdentifiers.add(node.text);
    ts.forEachChild(node, visit);
  };
  ts.forEachChild(sourceFile, visit);

  // 後ろから書き換えて、前方の位置情報をずらさない。
  let result = source;
  for (const importDecl of [...importDecls].reverse()) {
    const clause = importDecl.importClause;
    const namedBindings = clause?.namedBindings;
    if (clause === undefined || namedBindings === undefined || !ts.isNamedImports(namedBindings)) {
      continue;
    }
    if (clause.name !== undefined) continue; // default import 併用は触らない
    if (namedBindings.elements.some((element) => element.propertyName !== undefined)) {
      continue; // `as` による別名は触らない
    }
    const imported = namedBindings.elements.map((element) => element.name.text);
    const used = imported.filter((name) => usedIdentifiers.has(name));
    if (used.length === imported.length) continue;
    if (used.length === 0) {
      throw new Error(`${fileName}: import が全て未使用（変換規則の想定外）`);
    }
    const specifier = importDecl.moduleSpecifier.getText(sourceFile);
    const replacement = `import { ${used.join(", ")} } from ${specifier};`;
    result =
      result.slice(0, importDecl.getStart(sourceFile)) +
      replacement +
      result.slice(importDecl.getEnd());
  }
  return result;
}

/**
 * 本文中に埋め込まれた**自分たちのファイルへのパス参照**を `.ts` へ直す。
 *
 * `sourcePath: "structured-latex/content/002_linear_space_general.mjs"` のようなデータや、
 * 「notes/000_calculation_formulae.mjs へ移設した」のような記述が実在する。放置すると
 * 変換後に存在しないパスを指し続け、`verify-no-lost-proofs` は `existsSync` で黙って
 * 読み飛ばすため誰も気づけない。置換は**変換対象のファイル名に限定**する
 * （原本の Typst パスや無関係な `.mjs` を巻き込まないため）。
 */
function rewriteSelfPathReferences(source: string, convertedNames: ReadonlySet<string>): string {
  const withDir = source.replace(
    /((?:^|[^\w./-])(?:[\w./-]*?)(?:content|notes)\/)([\w.-]+)\.mjs/g,
    (whole, prefix: string, stem: string) =>
      convertedNames.has(`${stem}.mjs`) ? `${prefix}${stem}.ts` : whole,
  );
  // ディレクトリを伴わない裸のファイル名（本文中の言及。例: 「005_….mjs を参照」）。
  // 変換対象と完全一致する名前だけを置き換える。
  return withDir.replace(/([\w.-]+)\.mjs/g, (whole, stem: string) =>
    convertedNames.has(`${stem}.mjs`) ? `${stem}.ts` : whole,
  );
}

const targets: { dir: string; fileName: string }[] = [];
for (const dir of [contentDir, notesDir]) {
  for (const fileName of listSourceFiles(dir)) {
    if (!fileName.endsWith(".mjs")) continue;
    targets.push({ dir, fileName });
  }
}
const convertedNames = new Set(targets.map((target) => target.fileName));

const conversions: Conversion[] = [];
for (const { dir, fileName } of targets) {
  const source = readFileSync(join(dir, fileName), "utf8");
  let converted = source;
  for (const [pattern, replacement] of IMPORT_REWRITES) {
    converted = converted.replace(pattern, replacement);
  }
  converted = dropUnusedNamedImports(converted, fileName);
  converted = rewriteSelfPathReferences(converted, convertedNames);
  if (/from\s+["']\.\.?\/[^"']*\.mjs["']/.test(converted)) {
    throw new Error(`${fileName}: 変換規則で扱えない .mjs import が残っている`);
  }
  if (/import\s*\(\s*["'][^"']*\.mjs["']/.test(converted)) {
    throw new Error(`${fileName}: 動的 import の .mjs が残っている（規則の想定外）`);
  }
  conversions.push({
    dir,
    fileName,
    targetName: fileName.replace(/\.mjs$/, ".ts"),
    source,
    converted,
  });
}

if (conversions.length === 0) {
  console.log("変換対象の .mjs は無い（すでに全て .ts へ移行済み）");
  process.exit(0);
}

if (outDir !== undefined) {
  for (const conversion of conversions) {
    const subDir = join(outDir, basename(conversion.dir));
    mkdirSync(subDir, { recursive: true });
    writeFileSync(join(subDir, conversion.targetName), conversion.converted, "utf8");
  }
  // 出力をそのまま型検査できるよう、スキーマの再エクスポートと tsconfig を添える
  // （変換結果は `../schema.ts` を参照するため、出力先にも同名の入口が要る）。
  writeFileSync(join(outDir, "schema.ts"), 'export * from "../schema.ts";\n', "utf8");
  writeFileSync(join(outDir, "package.json"), '{ "type": "module" }\n', "utf8");
  writeFileSync(
    join(outDir, "tsconfig.json"),
    `${JSON.stringify(
      {
        extends: "../tsconfig.json",
        compilerOptions: { noEmit: true },
        include: ["schema.ts", "content", "notes"],
        exclude: [],
      },
      null,
      2,
    )}\n`,
    "utf8",
  );
  console.log(
    `${conversions.length} ファイルを ${outDir} へ変換した（リポジトリは未変更）。` +
      `\n  型検査: npx tsc -p ${outDir}/tsconfig.json`,
  );
  process.exit(0);
}

if (!apply) {
  console.log(`dry-run: ${conversions.length} ファイルを変換する（--apply で実行）`);
  for (const conversion of conversions) {
    const changedLines = conversion.source
      .split("\n")
      .filter((line, index) => line !== conversion.converted.split("\n")[index]).length;
    console.log(
      `  ${basename(conversion.dir)}/${conversion.fileName} -> ${conversion.targetName}` +
        `（import 行の書き換え ${changedLines} 行）`,
    );
  }
  console.log(
    "\n変換後に回すこと: node tools/generate-labels.ts && npx tsc -p tsconfig.json --noEmit " +
      "&& node tools/validate-content.ts",
  );
  process.exit(0);
}

for (const conversion of conversions) {
  const from = join(conversion.dir, conversion.fileName);
  const to = join(conversion.dir, conversion.targetName);
  if (existsSync(to)) {
    throw new Error(`${to} がすでに存在する（変換を中止）`);
  }
  const moved = spawnSync("git", ["mv", from, to], {
    cwd: structuredLatexDir,
    encoding: "utf8",
  });
  if (moved.status !== 0) {
    throw new Error(`git mv に失敗: ${from} -> ${to}\n${moved.stderr}`);
  }
  writeFileSync(to, conversion.converted, "utf8");
  console.log(`  ${basename(conversion.dir)}/${conversion.fileName} -> ${conversion.targetName}`);
}

console.log(
  `\n${conversions.length} ファイルを .ts へ変換した。` +
    "\n次: node tools/generate-labels.ts && npx tsc -p tsconfig.json --noEmit && node tools/validate-content.ts" +
    "\n（`schema.mjs` は全ファイルの変換完了後に削除する）",
);
