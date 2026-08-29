import { z } from "zod";

import {
  createRuntimeSchema,
  createStructuredTextSchema,
  type Block,
  type Node as SystemNode,
  type Note as SystemNote,
  type TheoremLikeBlock as SystemTheoremLikeBlock,
  type HeadingBlock as SystemHeadingBlock,
  compileDocumentStructure,
} from "../../structured-latex/domain-model/index.ts";

import type { Label } from "./labels.generated.ts";

export {
  cite,
  displayMath,
  image,
  list,
  math,
  paragraph,
  text,
  todo,
} from "../../structured-latex/domain-model/index.ts";

export type {
  Block,
  BlocksOfSections,
  DocumentStructure,
  SectionMember,
  HeadingLevel,
  Result,
  TheoremLikeKind,
  ValidationIssue,
} from "../../structured-latex/domain-model/index.ts";
export { compileDocumentStructure };

export type CountableHabitat =
  | "finite"
  | "N"
  | "Z"
  | "Q"
  | "F2"
  | "ZPolynomial"
  | "QPolynomial"
  | "Lambda"
  | "Qbar"
  | "none";

export type EscapingHabitat = "R" | "C" | "mixed";
export type Habitat = CountableHabitat | EscapingHabitat;

const COUNTABLE_HABITATS = [
  "finite",
  "N",
  "Z",
  "Q",
  "F2",
  "ZPolynomial",
  "QPolynomial",
  "Lambda",
  "Qbar",
  "none",
] as const satisfies readonly CountableHabitat[];

const ESCAPING_HABITATS = ["R", "C", "mixed"] as const satisfies readonly EscapingHabitat[];
const ALL_HABITATS = [...COUNTABLE_HABITATS, ...ESCAPING_HABITATS] as const;

export type Habitation =
  | { habitat: CountableHabitat; realEscape?: never }
  | { habitat: EscapingHabitat; realEscape: string };

export type Linkage = {
  verification?: readonly string[];
  lean?: readonly string[];
};

export type ProjectMeta = Habitation & Linkage;
export type TheoremLikeBlock = SystemTheoremLikeBlock<Label, ProjectMeta>;
export type HeadingBlock = SystemHeadingBlock<Label>;
export type ConvertedBlock = Block<Label, ProjectMeta>;
export type Node = SystemNode<Label>;
export type Note = SystemNote<Label>;

const schema = createStructuredTextSchema<Label, ProjectMeta>();
export const defineBlocks = schema.defineBlocks;
export const defineDocumentStructure = schema.defineDocumentStructure;
export const defineSection = schema.defineSection;
export const defineNotes = schema.defineNotes;
export const ref = schema.ref;

type BlockMetaSchema = {
  habitat: z.ZodTypeAny;
  realEscape: z.ZodTypeAny;
  verification: z.ZodTypeAny;
  lean: z.ZodTypeAny;
};

const blockMeta: BlockMetaSchema = {
  habitat: z.enum(ALL_HABITATS),
  realEscape: z.string().min(1).optional(),
  verification: z.array(z.string().min(1)).optional(),
  lean: z.array(z.string().min(1)).optional(),
};

export const runtimeSchema = createRuntimeSchema<Label, ProjectMeta, BlockMetaSchema>({ blockMeta });

export const HABITAT_VALUES = {
  countable: new Set<string>(COUNTABLE_HABITATS),
  escaping: new Set<string>(ESCAPING_HABITATS),
} as const;

export function checkHabitation(block: {
  id: string;
  habitat?: unknown;
  realEscape?: unknown;
}): string[] {
  if (typeof block.habitat !== "string") return [`${block.id}: habitat が無い`];
  if (HABITAT_VALUES.escaping.has(block.habitat)) {
    return typeof block.realEscape === "string" && block.realEscape.trim() !== ""
      ? []
      : [`${block.id}: 非可算側の habitat には realEscape が必要`];
  }
  if (!HABITAT_VALUES.countable.has(block.habitat)) {
    return [`${block.id}: 未知の habitat ${block.habitat}`];
  }
  return block.realEscape === undefined
    ? []
    : [`${block.id}: 可算側の habitat に realEscape は書けない`];
}
