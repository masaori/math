export type BlockKind = "theorem" | "definition" | "claim" | "remark" | "note";

export type Title =
  | {
      text?: string;
      tex?: string;
    }
  | null;

export type Node =
  | { type: "text"; value: string }
  | { type: "math"; tex: string }
  | { type: "displayMath"; tex: string }
  | { type: "paragraph"; children: Node[] }
  | { type: "list"; items: Node[][] }
  | { type: "ref"; target: string; label?: string }
  | { type: "todo"; value: string };

export type ConvertedBlock = {
  id: string;
  kind: BlockKind;
  sourcePath: string;
  sourceOrdinal: number;
  title?: Title;
  labels: string[];
  statement: Node[];
  proof?: Node[];
  notes?: Node[];
  conversion?: {
    status: string;
    notes?: string[];
  };
};

export function defineBlocks(blocks: ConvertedBlock[]): ConvertedBlock[];
export function text(value: string): Node;
export function math(tex: string): Node;
export function displayMath(tex: string): Node;
export function paragraph(children: Array<string | Node>): Node;
export function list(items: Array<Array<string | Node>>): Node;
export function ref(target: string, label?: string): Node;
export function todo(value: string): Node;
export function validateBlock(block: ConvertedBlock): void;
