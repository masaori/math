import { existsSync, readdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

import type { ConvertedBlock, Note } from "../schema.ts";
import { organizePublication } from "./publication-order.ts";

const here = dirname(fileURLToPath(import.meta.url));
export const structuredLatexDir = join(here, "..");
export const contentDir = join(structuredLatexDir, "content");
export const notesDir = join(structuredLatexDir, "notes");

function sourceFiles(dir: string): string[] {
  if (!existsSync(dir)) return [];
  const entries = readdirSync(dir);
  const legacy = entries.filter((name) => name.endsWith(".mjs"));
  if (legacy.length > 0) throw new Error(`.mjs は使わない: ${legacy.join(", ")}`);
  return entries.filter((name) => name.endsWith(".ts") && !name.endsWith(".d.ts")).sort();
}

async function load(dir: string, file: string): Promise<unknown> {
  const module: { default?: unknown } = await import(pathToFileURL(join(dir, file)).href);
  return module.default;
}

export async function loadContentFiles(): Promise<{ file: string; blocks: ConvertedBlock[] }[]> {
  const result: { file: string; blocks: ConvertedBlock[] }[] = [];
  for (const file of sourceFiles(contentDir)) {
    const value = await load(contentDir, file);
    if (!Array.isArray(value)) throw new TypeError(`${file}: default export は配列でなければならない`);
    result.push({ file, blocks: value as ConvertedBlock[] });
  }
  return result;
}

export async function loadPublicationContentFiles(): Promise<{ file: string; blocks: ConvertedBlock[] }[]> {
  return organizePublication(await loadContentFiles());
}

export async function loadNoteFiles(): Promise<{ file: string; notes: Note[] }[]> {
  const result: { file: string; notes: Note[] }[] = [];
  for (const file of sourceFiles(notesDir)) {
    const value = await load(notesDir, file);
    if (!Array.isArray(value)) throw new TypeError(`${file}: default export は配列でなければならない`);
    result.push({ file, notes: value as Note[] });
  }
  return result;
}
