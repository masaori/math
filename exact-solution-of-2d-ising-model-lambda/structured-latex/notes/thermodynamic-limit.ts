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
  },  {
    id: "note_real_escape_claim_twisted_mode_product_sum_reindex_archived",
    targets: ["claim_twisted_mode_product_bijection"],
    title: { text: "参照用: 横・縦モードの有限和の再添字付け" },
    body: [
      paragraph([
        "旧主張。", ref("claim_twisted_mode_product_bijection"),
        " の全単射 ", math(String.raw`\Theta_{L,a,b}`),
        " について、任意の写像 ",
        math(String.raw`F:E_{L,a}\times E_{L,b}\to\mathbb C`),
        " は次の等式を満たす。",
      ]),
      displayMath(String.raw`\sum_{(\varpi,\varsigma)\in\mathcal U_a\times\mathcal W_b}F(\Theta_{L,a,b}(\varpi,\varsigma))=\sum_{(z,w)\in E_{L,a}\times E_{L,b}}F(z,w).`),
      paragraph([
        "有限和の再添字付けは全単射から従う。後続のモード和は全単射を直接引用し、この独立した主張を引用しないため本文から退避した。有限検算は全単射の検証として残した。",
      ]),
    ],
  },
]);
