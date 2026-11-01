import { defineNotes, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineNotes([
  {
    id: "note_thermodynamic_limit_def_rational_log_order_group_sequence_lower_set_downward_closed_archived",
    targets: ["def_rational_log_order_group_sequence_lower_set"],
    title: { text: "参照用: 列が定める下組の下閉性" },
    body: [
      paragraph([
        "旧主張。", ref("def_rational_log_order_group_sequence_lower_set"),
        " の列 ", math(String.raw`(\lambda_L)_{L\ge1}`),
        " が定める集合 ", math(String.raw`A`),
        " について、任意の ", math(String.raw`\mu,\mu'\in\Lambda_{\mathbb Q}`),
        " で次が成り立つ。",
      ]),
      displayMath(String.raw`\mu\in A,\quad\mu'\le_{\Lambda_{\mathbb Q}}\mu\quad\Longrightarrow\quad\mu'\in A.`),
      paragraph([
        "証明は ", math(String.raw`\mu\in A`),
        " の証人 ", math(String.raw`\varepsilon,N`),
        " を引き継ぐ。", ref("claim_rational_log_order_group_add_monotone"),
        " と ", ref("claim_rational_log_order_group_linear_order"),
        " により、", math(String.raw`N\le L`), " のとき次の鎖を得る。",
      ]),
      displayMath(String.raw`\mu'+\varepsilon\le_{\Lambda_{\mathbb Q}}\mu+\varepsilon\le_{\Lambda_{\mathbb Q}}\lambda_L.`),
      paragraph([
        "後続の到達点は下組の定義と所属の証人を直接使い、この下閉性を引用しない。独立した到達点でもないため本文から退避した。有限検算と Lean 二版は保管した。",
      ]),
    ],
  },
]);
