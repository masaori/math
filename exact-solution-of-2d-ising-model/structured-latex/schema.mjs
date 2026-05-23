const KINDS = new Set(["theorem", "definition", "claim", "remark", "note"]);

const NODE_TYPES = new Set([
  "paragraph",
  "math",
  "displayMath",
  "list",
  "ref",
  "text",
  "todo",
]);

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
  validateNodes(block.statement ?? [], `${block.id}.statement`);
  if (block.proof !== undefined) {
    validateNodes(block.proof, `${block.id}.proof`);
  }
  if (block.notes !== undefined) {
    validateNodes(block.notes, `${block.id}.notes`);
  }
  if (block.conversion !== undefined) {
    assertObject(block.conversion, `${block.id}.conversion`);
    assertString(block.conversion.status, `${block.id}.conversion.status`);
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
