import { readFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const projectRoot = join(__dirname, "..", "..");
const mainTyp = join(projectRoot, "main.typ");

const main = readFileSync(mainTyp, "utf8");
const includePattern = /#include\s+"(parts\/000_計算公式\/[^"]+\.typ)"/g;

const includes = [...main.matchAll(includePattern)].slice(0, 30).map((match, index) => {
  const sourcePath = match[1];
  const source = readFileSync(join(projectRoot, sourcePath), "utf8");
  const firstBlock =
    source.match(/#(theorem|definition|claim)\(([\s\S]*?)\)\s*\[/) ??
    source.match(/#(remark|note)\s*\[/);
  const labels = [...source.matchAll(/(?<!#ref\()<([A-Za-z0-9_-]+)>/g)].map((m) => m[1]);
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
