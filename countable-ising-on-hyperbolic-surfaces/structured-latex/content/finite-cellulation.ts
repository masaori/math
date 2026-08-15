import { defineBlocks, displayMath, math, paragraph } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_cellulation_heading_input",
    kind: "heading",
    level: 1,
    title: { text: "有限セル分割の入力" },
    labels: [],
  },
  {
    id: "finite_cellulation_definition_cell_sets",
    kind: "definition",
    title: { text: "頂点・辺・面の有限集合" },
    labels: ["def_finite_cellulation_cell_sets"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限セル分割のセル集合入力を、空でない三つの有限集合 ",
        math(String.raw`V_{\mathrm{cell}}`),
        "、",
        math(String.raw`E_{\mathrm{cell}}`),
        "、",
        math(String.raw`F_{\mathrm{cell}}`),
        " の順序付き三つ組",
      ]),
      displayMath(String.raw`\mathcal C_{\mathrm{cell}}:=\bigl(V_{\mathrm{cell}},E_{\mathrm{cell}},F_{\mathrm{cell}}\bigr)`),
      paragraph([
        "と定める。",
        math(String.raw`V_{\mathrm{cell}}`),
        " は頂点の集合、",
        math(String.raw`E_{\mathrm{cell}}`),
        " は辺の集合、",
        math(String.raw`F_{\mathrm{cell}}`),
        " は面の集合である。三つの集合には",
      ]),
      displayMath(String.raw`V_{\mathrm{cell}}\cap E_{\mathrm{cell}}=\varnothing,\qquad E_{\mathrm{cell}}\cap F_{\mathrm{cell}}=\varnothing,\qquad F_{\mathrm{cell}}\cap V_{\mathrm{cell}}=\varnothing`),
      paragraph(["を要求し、頂点、辺、面の元を互いに同一視しない。"]),
    ],
  },
]);
