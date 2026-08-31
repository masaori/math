/**
 * 章「自己写像の反復が生成する有限可換モノイド」。
 * 有限集合上の自己写像 F の反復だけから、物理的意味を入れずに得られる代数構造を抽出する。
 *
 * - 反復写像全体 P_F と写像の合成
 * - F^m ∘ F^n = F^{m+n}
 * - P_F が有限可換モノイドであること
 * - 写像空間の有限性による反復写像どうしの衝突と、有限代表集合
 * - 有限表の全走査によるモノイドの有限決定
 *
 * 有限集合と自然数だけを使う。無限反復の極限や位相は取らず、ℝ / ℂ は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_definition_power_set",
    kind: "definition",
    title: { text: "反復写像の集合" },
    labels: ["def_iterate_monoid"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合上の自己写像 ",
        math(String.raw`F:X\to X`),
        " に対し、反復 ",
        math(String.raw`F^n:X\to X`),
        " は ",
        ref("def_finite_self_map_iterate"),
        " の再帰で定める。写像の集合",
      ]),
      displayMath(String.raw`P_F:=\{\,F^n:X\to X\mid n\in\mathbb{N}\,\}`),
      paragraph([
        "を ",
        math(String.raw`F`),
        " の反復写像の集合と呼ぶ。二項演算は写像の合成 ",
        math(String.raw`\circ`),
        " とする。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_claim_addition_law",
    kind: "claim",
    title: { text: "反復回数の加法は写像の合成に一致する" },
    labels: ["claim_iterate_composition_addition"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`m,n\in\mathbb{N}`),
        " について、写像 ",
        math(String.raw`X\to X`),
        " として",
      ]),
      displayMath(String.raw`F^m\circ F^n=F^{m+n}`),
      paragraph(["が成り立つ。"])],
    proof: [
      paragraph([
        math(String.raw`m`),
        " について帰納法を行う。",
        math(String.raw`m=0`),
        " のとき、",
        ref("def_finite_self_map_iterate"),
        " と自然数の加法の単位元則より",
      ]),
      displayMath(String.raw`\begin{aligned}
F^0\circ F^n
&=\operatorname{id}_{X}\circ F^n
  \quad(\because\ \blkref{def_finite_self_map_iterate})\\
&=F^n
  \quad(\because\ \text{恒等写像の性質})\\
&=F^{0+n}
  \quad(\because\ \mathbb{N}\text{ の加法の単位元則})
\end{aligned}`),
      paragraph([
        math(String.raw`F^m\circ F^n=F^{m+n}`),
        " と仮定する。",
        ref("def_finite_self_map_iterate"),
        "、写像合成の結合律、帰納法の仮定を順に用いると",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{m+1}\circ F^n
&=(F\circ F^m)\circ F^n
  \quad(\because\ \blkref{def_finite_self_map_iterate})\\
&=F\circ(F^m\circ F^n)
  \quad(\because\ \text{写像合成の結合律})\\
&=F\circ F^{m+n}
  \quad(\because\ \text{帰納法の仮定})\\
&=F^{(m+n)+1}
  \quad(\because\ \blkref{def_finite_self_map_iterate})\\
&=F^{(m+1)+n}
  \quad(\because\ \mathbb{N}\text{ の加法の結合律と交換律})
\end{aligned}`),
      paragraph(["となるので、帰納法により主張が成り立つ。"]),
    ],
  },

  {
    id: "iterate_monoid_claim_finite_commutative_monoid",
    kind: "claim",
    title: { text: "反復写像は有限可換モノイドをなす" },
    labels: ["claim_iterate_powers_form_finite_commutative_monoid"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`(P_F,\circ)`),
        " は有限可換モノイドである。単位元は ",
        math(String.raw`F^0=\operatorname{id}_{X}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_finite_self_map_iterate"),
        " より ",
        math(String.raw`F^0=\operatorname{id}_{X}\in P_F`),
        " である。任意の ",
        math(String.raw`F^m,F^n\in P_F`),
        " に対し、",
        ref("claim_iterate_composition_addition"),
        " より",
      ]),
      displayMath(String.raw`F^m\circ F^n=F^{m+n}\in P_F`),
      paragraph([
        "なので合成について閉じている。結合律は写像合成の結合律から従う。さらに、",
        ref("claim_iterate_composition_addition"),
        " と自然数の加法の交換律より",
      ]),
      displayMath(String.raw`\begin{aligned}
F^m\circ F^n
&=F^{m+n}
  \quad(\because\ \blkref{claim_iterate_composition_addition})\\
&=F^{n+m}
  \quad(\because\ \mathbb{N}\text{ の加法の交換律})\\
&=F^n\circ F^m
  \quad(\because\ \blkref{claim_iterate_composition_addition})
\end{aligned}`),
      paragraph([
        "なので可換である。有限性を示す。",
        math(String.raw`M:=|X|\in\mathbb{N}`),
        " と置く。有限集合 ",
        math(String.raw`X`),
        " からそれ自身への写像は ",
        math(String.raw`M^M`),
        " 個なので、",
      ]),
      displayMath(String.raw`P_F\subseteq X^{X},\qquad |P_F|\leq M^M`),
      paragraph(["である。したがって ", math(String.raw`P_F`), " は有限集合である。"]),
    ],
  },

  {
    id: "iterate_monoid_claim_power_collision",
    kind: "claim",
    title: { text: "反復写像どうしの衝突から有限代表集合が得られる" },
    labels: ["claim_iterate_map_collision_finite_representatives"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`M:=|X|`),
        "、",
        math(String.raw`K:=M^M`),
        " と置く。ある ",
        math(String.raw`0\leq i<j\leq K`),
        " を満たす ",
        math(String.raw`i,j\in\mathbb{N}`),
        " について写像として ",
        math(String.raw`F^i=F^j`),
        " であり、そのような組を一つ取れば",
      ]),
      displayMath(String.raw`P_F=\{\,F^n\mid 0\leq n<j\,\}`),
      paragraph(["である。特に ", math(String.raw`|P_F|\leq j\leq K`), " である。"]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_powers_form_finite_commutative_monoid"),
        " の証明より、終域 ",
        math(String.raw`X^{X}`),
        " の元は ",
        math(String.raw`K=M^M`),
        " 個である。",
        math(String.raw`K+1`),
        " 個の写像 ",
        math(String.raw`F^0,F^1,\dots,F^K`),
        " に鳩の巣原理を適用すると、",
        math(String.raw`0\leq i<j\leq K`),
        " かつ ",
        math(String.raw`F^i=F^j`),
        " を満たす組が存在する。",
      ]),
      paragraph([
        math(String.raw`p:=j-i\in\mathbb{N}_{>0}`),
        " と置く。",
        math(String.raw`n\geq i`),
        " なら、自然数の除法の原理により ",
        math(String.raw`n-i=qp+r`),
        "、",
        math(String.raw`0\leq r<p`),
        " を満たす ",
        math(String.raw`q,r\in\mathbb{N}`),
        " が存在する。等式 ",
        math(String.raw`F^i=F^{i+p}`),
        " と ",
        ref("claim_iterate_composition_addition"),
        " より、各 ",
        math(String.raw`k\in\mathbb{N}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{i+p+k}
&=F^{j+k}
  \quad(\because\ j=i+p)\\
&=F^j\circ F^k
  \quad(\because\ \blkref{claim_iterate_composition_addition})\\
&=F^i\circ F^k
  \quad(\because\ F^i=F^j)\\
&=F^{i+k}
  \quad(\because\ \blkref{claim_iterate_composition_addition})
\end{aligned}`),
      paragraph([
        "である。この等式で指数から ",
        math(String.raw`p`),
        " を一つ除く操作を ",
        math(String.raw`q`),
        " 回繰り返す帰納法により",
      ]),
      displayMath(String.raw`\begin{aligned}
F^n
&=F^{i+qp+r}
  \quad(\because\ n-i=qp+r)\\
&=F^{i+r}
  \quad(\because\ \text{上の等式を }q\text{ 回適用})
\end{aligned}`),
      paragraph([
        "を得る。",
        math(String.raw`r<p=j-i`),
        " だから ",
        math(String.raw`i+r<j`),
        " である。",
        math(String.raw`n<i`),
        " なら初めから ",
        math(String.raw`n<j`),
        " である。したがって全ての反復写像は指数が ",
        math(String.raw`j`),
        " 未満の反復写像に等しい。逆の包含は ",
        ref("def_iterate_monoid"),
        " から直ちに従う。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_claim_finite_decidability",
    kind: "claim",
    title: { text: "反復モノイドは自己写像の有限表から決定できる" },
    labels: ["claim_iterate_monoid_finite_decidability"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`X`), " と自己写像 ", math(String.raw`F:X\to X`),
        " の有限表から、反復モノイド ",
        math(String.raw`(P_F,\circ)`),
        " の全ての元と合成表を有限回の ", math(String.raw`X`), " の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        "各 ",
        math(String.raw`0\leq n\leq K`),
        " について ",
        math(String.raw`F^n`),
        " の有限表を再帰的に計算する。二つの反復写像 ",
        math(String.raw`F^a,F^b`),
        " の等号は",
      ]),
      displayMath(String.raw`F^a=F^b\iff \forall y\in X,\ F^a y=F^b y`),
      paragraph([
        "であり、",
        math(String.raw`X`),
        " は有限集合なので、右辺は全ての元の有限走査で決定できる。",
        ref("claim_iterate_map_collision_finite_representatives"),
        " により、有限個の候補組 ",
        math(String.raw`0\leq i<j\leq K`),
        " の中に衝突がある。見つけた衝突の後は指数が ",
        math(String.raw`j`),
        " 未満の反復写像を等しいものごとにまとめれば ",
        math(String.raw`P_F`),
        " の元が全て得られる。各二元の合成は ",
        ref("claim_iterate_composition_addition"),
        " により指数を加え、同じ有限代表へ戻すことで決定できる。したがって全ての走査は有限回で終了する。",
      ]),
      paragraph([
        "この検査は有限集合と自然数だけで閉じる。無限時間の極限、位相、",
        "実数、複素数は使わない。",
      ]),
    ],
  },
]);
