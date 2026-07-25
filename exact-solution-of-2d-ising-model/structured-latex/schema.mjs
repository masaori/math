// 定理型ブロック(証明環境)の kind。
const THEOREM_LIKE_KINDS = new Set(["theorem", "definition", "claim", "remark", "note"]);

// 章見出しブロックの kind。定理型ブロックと同じ配列に、文書順のとおり並べる。
const HEADING_KIND = "heading";

const KINDS = new Set([...THEOREM_LIKE_KINDS, HEADING_KIND]);

// 見出しの深さ。1 が最上位（Typst の `=`、`==` は 2）。
const MAX_HEADING_LEVEL = 6;

const NODE_TYPES = new Set([
  "paragraph",
  "math",
  "displayMath",
  "list",
  "ref",
  "text",
  "todo",
]);

/**
 * 1ファイル分のブロック列を定義する。
 * **配列の並びが文書順の正準表現**であり、文書全体の順序は
 * 「content/*.mjs をファイル名昇順に並べ、各ファイル内は配列順」で復元される
 * （旧 main.typ の `#include` 順がこれに一致するように content 側を並べる）。
 * `sourceOrdinal` は「ソース内での通し番号」であって文書順ではない
 * （parts/ のファイル名連番と `#include` 順は一致しないため）。
 */
export function defineBlocks(blocks) {
  if (!Array.isArray(blocks)) {
    throw new TypeError("defineBlocks expects an array");
  }
  for (const block of blocks) {
    validateBlock(block);
  }
  return blocks;
}

export function text(value) {
  return { type: "text", value };
}

export function math(tex) {
  return { type: "math", tex };
}

export function displayMath(tex) {
  return { type: "displayMath", tex };
}

export function paragraph(children) {
  return { type: "paragraph", children: normalizeChildren(children) };
}

export function list(items) {
  return {
    type: "list",
    items: items.map((item) => normalizeChildren(item)),
  };
}

export function ref(target, label = undefined) {
  return { type: "ref", target, label };
}

export function todo(value) {
  return { type: "todo", value };
}

function normalizeChildren(children) {
  if (!Array.isArray(children)) {
    throw new TypeError("children must be an array");
  }
  return children.map((child) => {
    if (typeof child === "string") return text(child);
    return child;
  });
}

export function validateBlock(block) {
  assertObject(block, "block");
  assertString(block.id, "block.id");
  assertString(block.sourcePath, `${block.id}.sourcePath`);
  assertInteger(block.sourceOrdinal, `${block.id}.sourceOrdinal`);
  if (!KINDS.has(block.kind)) {
    throw new TypeError(`${block.id}.kind must be one of ${[...KINDS].join(", ")}`);
  }
  if (block.title !== null && block.title !== undefined) {
    validateTitle(block.title, `${block.id}.title`);
  }
  if (!Array.isArray(block.labels)) {
    throw new TypeError(`${block.id}.labels must be an array`);
  }
  for (const label of block.labels) {
    assertString(label, `${block.id}.labels[]`);
  }
  if (block.conversion !== undefined) {
    assertObject(block.conversion, `${block.id}.conversion`);
    assertString(block.conversion.status, `${block.id}.conversion.status`);
  }
  if (block.kind === HEADING_KIND) {
    validateHeadingBlock(block);
    return;
  }
  validateNodes(block.statement ?? [], `${block.id}.statement`);
  if (block.proof !== undefined) {
    validateNodes(block.proof, `${block.id}.proof`);
  }
  if (block.notes !== undefined) {
    validateNodes(block.notes, `${block.id}.notes`);
  }
}

/**
 * 見出しブロックの検証。
 * 見出しは「文書構造」だけを持ち、本文（statement/proof/notes）を持たない。
 */
function validateHeadingBlock(block) {
  assertInteger(block.level, `${block.id}.level`);
  if (block.level < 1 || block.level > MAX_HEADING_LEVEL) {
    throw new TypeError(`${block.id}.level must be between 1 and ${MAX_HEADING_LEVEL}`);
  }
  if (block.title === null || block.title === undefined) {
    throw new TypeError(`${block.id}.title is required for kind "${HEADING_KIND}"`);
  }
  if (block.title.text === undefined && block.title.tex === undefined) {
    throw new TypeError(`${block.id}.title must have text or tex`);
  }
  for (const field of ["statement", "proof", "notes"]) {
    if (block[field] !== undefined) {
      throw new TypeError(`${block.id}.${field} is not allowed for kind "${HEADING_KIND}"`);
    }
  }
}

function validateTitle(title, path) {
  assertObject(title, path);
  if (title.text !== undefined) assertString(title.text, `${path}.text`);
  if (title.tex !== undefined) assertString(title.tex, `${path}.tex`);
}

function validateNodes(nodes, path) {
  if (!Array.isArray(nodes)) {
    throw new TypeError(`${path} must be an array`);
  }
  nodes.forEach((node, index) => validateNode(node, `${path}[${index}]`));
}

function validateNode(node, path) {
  assertObject(node, path);
  if (!NODE_TYPES.has(node.type)) {
    throw new TypeError(`${path}.type is invalid: ${node.type}`);
  }
  switch (node.type) {
    case "paragraph":
      validateNodes(node.children, `${path}.children`);
      break;
    case "math":
    case "displayMath":
      assertString(node.tex, `${path}.tex`);
      break;
    case "list":
      if (!Array.isArray(node.items)) throw new TypeError(`${path}.items must be an array`);
      node.items.forEach((item, index) => validateNodes(item, `${path}.items[${index}]`));
      break;
    case "ref":
      assertString(node.target, `${path}.target`);
      if (node.label !== undefined) assertString(node.label, `${path}.label`);
      break;
    case "text":
    case "todo":
      assertString(node.value, `${path}.value`);
      break;
  }
}

function assertObject(value, path) {
  if (value === null || typeof value !== "object" || Array.isArray(value)) {
    throw new TypeError(`${path} must be an object`);
  }
}

function assertString(value, path) {
  if (typeof value !== "string") {
    throw new TypeError(`${path} must be a string`);
  }
}

function assertInteger(value, path) {
  if (!Number.isInteger(value)) {
    throw new TypeError(`${path} must be an integer`);
  }
}
