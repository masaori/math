/**
 * 章「因果集合の一次文献との照合」: 前章までで得た組 (E_τ, ⪯_τ, D_τ) を、
 * 一次文献（Bombelli–Lee–Meyer–Sorkin, Phys. Rev. Lett. 59 (1987) 521–524）の
 * 本文で確認した「因果集合」の数学的定義（局所有限な部分順序集合）と、
 * 恒等写像を比較写像として突き合わせる。
 *
 * - 局所有限な部分順序集合の定義（順序の言葉だけで書く。物理的意味は入れない）
 * - (E_τ, ⪯_τ) がその定義を満たすこと（既証明の部分順序性と区間有限性の合成。
 *   有限集合上では区間有限性が自動で従うことも明記する）
 * - 成立しない同一視（連続時空への近似・物理的因果・時刻写像の復元）は remark に限定し、
 *   数学的主張として立てない
 *
 * 使う ℕ の構造は前章までと同じく大小比較・後者・等号だけである。ℝ/ℂ は現れない。
 * 文書順はこの配列の並びが正本である。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "causal_set_primary_literature_remark_source",
    kind: "remark",
    title: { text: "照合する一次文献とこの章の範囲" },
    labels: ["remark_causal_set_source"],
    habitat: "none",
    statement: [
      paragraph([
        "照合先は L. Bombelli, J. Lee, D. Meyer, R. D. Sorkin, “Space-Time as a Causal Set,” ",
        "Physical Review Letters 59 (1987) 521–524 の本文で確認した定義である。",
        "同論文は、集合上の推移的かつ非循環的な関係を（反射的な規約で）部分順序と呼び、",
        "任意の二点の間の区間が有限であることを局所有限性と呼び、",
        "局所有限な部分順序集合を因果集合と定義する。",
        "この章では、その定義を順序の言葉だけで書き直し（",
        ref("def_locally_finite_partial_order"),
        "）、前章までの組 ",
        math(String.raw`(E_\tau,\preceq_\tau)`),
        " が恒等写像を比較写像としてその定義を満たすこと（",
        ref("claim_event_order_locally_finite"),
        "）だけを主張する。",
        "同論文が連続時空への近似として要求する条件（時間向き Lorentz 多様体への順序を保つ埋め込み、",
        "点の一様密度、連続幾何の尺度と点間隔の分離）は、比較先の多様体・埋め込み・密度・尺度・",
        "誤差または収束概念をこのプロジェクトが定義していないので、この章では扱わず、主張もしない（",
        ref("remark_causal_set_not_claimed"),
        "）。",
      ]),
    ],
  },

  {
    id: "finite_poset_locally_finite_definition_locally_finite_partial_order",
    kind: "definition",
    title: { text: "局所有限な部分順序集合" },
    labels: ["def_locally_finite_partial_order"],
    habitat: "none",
    statement: [
      paragraph([
        "集合 ",
        math(String.raw`X`),
        " と ",
        math(String.raw`X`),
        " 上の部分順序 ",
        math(String.raw`R\subseteq X\times X`),
        "（",
        ref("def_partial_order"),
        "）について、各 ",
        math(String.raw`x,y\in X`),
        " に対する集合",
      ]),
      displayMath(
        String.raw`A_R(x,y):=\bigl\{\,z\in X\ \bigm|\ (x,z)\in R\ \text{かつ}\ (z,y)\in R\,\bigr\}`,
      ),
      paragraph([
        "がすべて有限集合であるとき、組 ",
        math(String.raw`(X,R)`),
        " を",
        "局所有限な部分順序集合",
        "と呼ぶ。",
      ]),
    ],
  },

  {
    id: "finite_poset_locally_finite_claim_finite_partial_order_locally_finite",
    kind: "claim",
    title: { text: "有限集合上の部分順序は局所有限である" },
    labels: ["claim_finite_partial_order_locally_finite"],
    habitat: "finite",
    statement: [paragraph([
      "有限集合 ", math(String.raw`X`), " 上の任意の部分順序 ",
      math(String.raw`R\subseteq X\times X`), " は局所有限（",
      ref("def_locally_finite_partial_order"), "）である。",
    ])],
    proof: [paragraph([
      "任意の ", math(String.raw`x,y\in X`), " に対し ",
      math(String.raw`A_R(x,y)\subseteq X`), "（", math(String.raw`\because`), " ",
      ref("def_locally_finite_partial_order"), "）であり、有限集合の部分集合は有限である。",
    ])],
  },

  {
    id: "causal_set_primary_literature_claim_event_order_locally_finite",
    kind: "claim",
    title: { text: "反射的到達可能関係を備えたイベント集合は局所有限な部分順序集合である" },
    labels: ["claim_event_order_locally_finite"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台上の 2 値セルオートマトン ",
        math(String.raw`\bigl((V,N),(f_v)_{v\in V}\bigr)`),
        "（",
        ref("def_finite_ca"),
        "）と ",
        math(String.raw`\tau\in\mathbb{N}`),
        " に対し、組 ",
        math(String.raw`(E_\tau,\preceq_\tau)`),
        "（",
        ref("def_event_set"),
        "、",
        ref("def_ca_reflexive_reachability"),
        "）は局所有限な部分順序集合（",
        ref("def_locally_finite_partial_order"),
        "）である。さらに、その区間 ",
        math(String.raw`A_{\preceq_\tau}(a,b)`),
        " は前章の区間 ",
        math(String.raw`I_\tau(a,b)`),
        "（",
        ref("def_order_interval"),
        "）と集合として等しい。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_event_set_cardinality"), " より ", math(String.raw`E_\tau`),
        " は有限集合であり、", ref("def_ca_reflexive_reachability"), " の関係 ",
        math(String.raw`\preceq_\tau`), " を備える。",
        ref("claim_reachability_partial_order"),
        " より ",
        math(String.raw`\preceq_\tau`),
        " は ",
        math(String.raw`E_\tau`),
        " 上の部分順序である。したがって ", ref("claim_finite_partial_order_locally_finite"),
        " より局所有限である。",
      ]),
      paragraph([
        "任意の ",
        math(String.raw`a,b\in E_\tau`),
        " について、",
        ref("def_locally_finite_partial_order"),
        " の集合 ",
        math(String.raw`A_{\preceq_\tau}(a,b)`),
        " と ",
        ref("def_order_interval"),
        " の集合 ",
        math(String.raw`I_\tau(a,b)`),
        " は、いずれも「",
        math(String.raw`c\in E_\tau`),
        " であって ",
        math(String.raw`a\preceq_\tau c`),
        " かつ ",
        math(String.raw`c\preceq_\tau b`),
        "」を満たす ",
        math(String.raw`c`),
        " 全体として定義されているので、集合として等しい。",
        ref("claim_order_interval_finite"),
        " より ",
        math(String.raw`I_\tau(a,b)`),
        " は有限集合なので、",
        math(String.raw`A_{\preceq_\tau}(a,b)`),
        " も有限集合である。以上で ",
        ref("def_locally_finite_partial_order"),
        " の条件がすべて満たされた。使った事実は既証明の部分順序性と区間の有限性だけであり、",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "causal_set_primary_literature_remark_not_claimed",
    kind: "remark",
    title: { text: "この照合で主張しないこと" },
    labels: ["remark_causal_set_not_claimed"],
    habitat: "finite",
    statement: [
      paragraph([
        "確定した対応は、恒等写像 ",
        math(String.raw`E_\tau\to E_\tau`),
        " のもとで ",
        math(String.raw`(E_\tau,\preceq_\tau)`),
        " が一次文献の因果集合の数学的定義を満たすこと（",
        ref("claim_event_order_locally_finite"),
        "）と、一段依存関係 ",
        math(String.raw`D_\tau`),
        " がその部分順序の被覆関係として復元できること（",
        ref("claim_one_step_equals_covering"),
        "）までである。",
        "次はいずれも主張しない。",
        math(String.raw`(E_\tau,\preceq_\tau)`),
        " が連続時空を近似すること（比較先の多様体・埋め込み・密度・尺度・誤差または収束概念が未定義）。",
        math(String.raw`\preceq_\tau`),
        " が物理的因果そのものであること。",
        math(String.raw`D_\tau`),
        " が光円錐や時空の最近接関係であること。",
        "また、順序を保つ全単射が時刻写像を保つとは限らない（",
        ref("claim_order_iso_not_time_preserving"),
        "）ので、時刻写像 ",
        math(String.raw`t:E_\tau\to\mathbb{N}`),
        " は部分順序だけから復元できない。これは一次文献の定義が外部ラベルの復元を要求しないので、",
        "その定義との矛盾ではなく、失われる情報の記録である。",
      ]),
    ],
  },
]);
