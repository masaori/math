#!/usr/bin/env node
/**
 * Typst 原本（`_old/typst/main.typ` の `#include` 順）から、ブロックの索引を抽出する
 * リポジトリ固有のスクリプト。移行の突き合わせ用の参照情報を JSON で出す。
 */

import { readFileSync } from "node:fs";
import { join, resolve } from "node:path";

import { structuredLatexDir } from "./content-modules.ts";

// Typst 原本はアーカイブとして `_old/typst/` へ退避済み（正本は構造化テキスト側）。
const typstRoot = join(resolve(structuredLatexDir, ".."), "_old", "typst");
const mainTyp = join(typstRoot, "main.typ");

const main = readFileSync(mainTyp, "utf8");
const includePattern = /#include\s+"(parts\/000_計算公式\/[^"]+\.typ)"/g;

type SourceIndexEntry = {
  ordinal: number;
  sourcePath: string;
  lineCount: number;
  firstKind: string | null;
  firstTitleTypst: string | null;
  labels: string[];
};

const includes: SourceIndexEntry[] = [...main.matchAll(includePattern)]
  .slice(0, 30)
  .map((match, index) => {
    const sourcePath = match[1] ?? "";
    const source = readFileSync(join(typstRoot, sourcePath), "utf8");
    const firstBlock =
      source.match(/#(theorem|definition|claim)\(([\s\S]*?)\)\s*\[/) ??
      source.match(/#(remark|note)\s*\[/);
    const labels = [...source.matchAll(/(?<!#ref\()<([A-Za-z0-9_-]+)>/g)].map((m) => m[1] ?? "");
    return {
      ordinal: index + 1,
      sourcePath,
      lineCount: source.split("\n").length,
      firstKind: firstBlock?.[1] ?? null,
      firstTitleTypst: firstBlock?.[2]?.trim() ?? null,
      labels,
    };
  });

console.log(JSON.stringify({ count: includes.length, includes }, null, 2));
