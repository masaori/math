import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import {
  loadContentFiles as loadStructuredContentFiles,
  loadNoteFiles as loadStructuredNoteFiles,
} from "../../../structured-latex/codegen/structured-text-index/content-modules.ts";
import type { ConvertedBlock, Note } from "../schema.ts";

const here = dirname(fileURLToPath(import.meta.url));
export const structuredLatexDir = join(here, "..");

export async function loadContentFiles(): Promise<{ file: string; blocks: ConvertedBlock[] }[]> {
  const loaded = await loadStructuredContentFiles(structuredLatexDir);
  return loaded.map(({ file, blocks }) => ({ file, blocks: [...blocks] as ConvertedBlock[] }));
}

export async function loadNoteFiles(): Promise<{ file: string; notes: Note[] }[]> {
  const loaded = await loadStructuredNoteFiles(structuredLatexDir);
  return loaded.map(({ file, notes }) => ({ file, notes: [...notes] as Note[] }));
}
