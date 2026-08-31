/**
 * 章「冗長近傍からの独立性」: 局所真理値表 (S, f) の入力の添字集合 S を、f が使わない元を
 * 含む有限集合 T ⊇ S へ広げても、本質的依存台が変わらないことを示す。
 *
 * 「広げる」は同一視で済ませず、写像に名前を付けて行う（docs/context/証明の書き方.md の
 * 「同一視は写像を定義してからでないとできない」）: 制限写像 ρ で A^T の入力を A^S に落とし、
 * f との合成を冗長拡大と呼ぶ。逆向きの経路は基準値延長写像 ι だけを通る。
 *
 * 物理的な意味（近傍半径・光円錐など）はここへ持ち込まない。前章「本質的依存台」の定義だけを
 * 使う。どの章にも ℝ/ℂ は現れない。文書順はこの配列の並びが正本である。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "redundant_neighbor_definition_restriction_map",
    kind: "definition",
    title: { text: "制限写像" },
    labels: ["def_restriction_map"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ",
        math(String.raw`T`),
        " とその部分集合 ",
        math(String.raw`S\subseteq T`),
        " に対し、写像 ",
        math(String.raw`\rho^{T}_{S}:A^{T}\to A^{S}`),
        " を",
      ]),
      displayMath(String.raw`(\rho^{T}_{S}\,y)(u):=y(u)\qquad(y\in A^{T},\ u\in S)`),
      paragraph([
        "で定める（",
        math(String.raw`A^{T}`),
        "・",
        math(String.raw`A^{S}`),
        " はそれぞれ ",
        math(String.raw`T`),
        "・",
        math(String.raw`S`),
        " から ",
        math(String.raw`A`),
        " への写像全体で、いずれも有限集合。",
        ref("def_local_truth_table"),
        "）。",
        math(String.raw`u\in S`),
        " なら ",
        math(String.raw`u\in T`),
        " なので右辺は定義されている。",
        math(String.raw`\rho^{T}_{S}\,y`),
        " を ",
        math(String.raw`y`),
        " の ",
        math(String.raw`S`),
        " への制限と呼ぶ。",
      ]),
    ],
  },

  {
    id: "redundant_neighbor_definition_redundant_extension",
    kind: "definition",
    title: { text: "冗長拡大" },
    labels: ["def_redundant_extension"],
    habitat: "finite",
    statement: [
      paragraph([
        "局所真理値表 ",
        math(String.raw`(S,f)`),
        "（",
        ref("def_local_truth_table"),
        "）と有限集合 ",
        math(String.raw`T\supseteq S`),
        " に対し、合成写像",
      ]),
      displayMath(
        String.raw`f\circ\rho^{T}_{S}:A^{T}\to A,\qquad (f\circ\rho^{T}_{S})(y):=f\bigl(\rho^{T}_{S}\,y\bigr)\quad(y\in A^{T})`,
      ),
      paragraph([
        "を考える（",
        math(String.raw`\rho^{T}_{S}`),
        " は ",
        ref("def_restriction_map"),
        "）。組 ",
        math(String.raw`(T,\ f\circ\rho^{T}_{S})`),
        " は ",
        math(String.raw`T`),
        " を添字集合とする局所真理値表（",
        ref("def_local_truth_table"),
        "）であり、これを ",
        math(String.raw`f`),
        " の ",
        math(String.raw`T`),
        " への",
        "冗長拡大",
        "と呼ぶ。",
        math(String.raw`T\setminus S`),
        " の元は ",
        math(String.raw`f`),
        " へ渡されない添字であり、これが「規則が使わない元を近傍へ足す」ことの写像による定式化である。",
      ]),
    ],
  },

  {
    id: "redundant_neighbor_definition_base_value_extension",
    kind: "definition",
    title: { text: "基準値延長写像" },
    labels: ["def_base_value_extension"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ",
        math(String.raw`T`),
        " とその部分集合 ",
        math(String.raw`S\subseteq T`),
        " に対し、写像 ",
        math(String.raw`\iota^{T}_{S}:A^{S}\to A^{T}`),
        " を",
      ]),
      displayMath(String.raw`(\iota^{T}_{S}\,x)(u):=\begin{cases}
x(u) & (u\in S)\\
0 & (u\in T\setminus S)
\end{cases}\qquad(x\in A^{S},\ u\in T)`),
      paragraph([
        "で定める（",
        math(String.raw`0\in A`),
        " は ",
        ref("def_state_set"),
        " の元。値 ",
        math(String.raw`0`),
        " の選択に意味はなく、",
        math(String.raw`T\setminus S`),
        " 上で一定でありさえすればよい）。各 ",
        math(String.raw`x\in A^{S}`),
        " と ",
        math(String.raw`u\in S`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(\rho^{T}_{S}(\iota^{T}_{S}\,x))(u)
&=(\iota^{T}_{S}\,x)(u)\qquad(\because\ \blkref{def_restriction_map})\\
&=x(u)\qquad(\because\ \text{上の場合分けの上段})
\end{aligned}`),
      paragraph([
        "である。写像の外延性より ",
        math(String.raw`\rho^{T}_{S}\circ\iota^{T}_{S}`),
        " は ",
        math(String.raw`A^{S}`),
        " の恒等写像である。",
      ]),
    ],
  },

  {
    id: "redundant_neighbor_claim_no_dependency_on_redundant_element",
    kind: "claim",
    title: { text: "冗長拡大は足した元に本質的に依存しない" },
    labels: ["claim_no_dependency_on_redundant_element"],
    habitat: "finite",
    verification: ["sagemath/check/redundant-neighbor-independence"],
    statement: [
      paragraph([
        "局所真理値表 ",
        math(String.raw`(S,f)`),
        "（",
        ref("def_local_truth_table"),
        "）、有限集合 ",
        math(String.raw`T\supseteq S`),
        "、",
        math(String.raw`w\in T\setminus S`),
        " について、冗長拡大 ",
        math(String.raw`f\circ\rho^{T}_{S}`),
        "（",
        ref("def_redundant_extension"),
        "）は ",
        math(String.raw`w`),
        " に本質的に依存しない（本質的依存は ",
        ref("def_essential_dependency"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`y\in A^{T}`),
        " を任意に取る。すべての ",
        math(String.raw`u\in S`),
        " について、",
        math(String.raw`w\notin S`),
        " より ",
        math(String.raw`u\neq w`),
        " なので、",
      ]),
      displayMath(String.raw`\bigl(\rho^{T}_{S}(\varphi_w y)\bigr)(u)
=(\varphi_w y)(u)\qquad(\because\ \blkref{def_restriction_map})`),
      displayMath(String.raw`\phantom{\bigl(\rho^{T}_{S}(\varphi_w y)\bigr)(u)}
=y(u)\qquad(\because\ \blkref{def_flip_map}\ \text{の場合分けの下段。}u\neq w)`),
      displayMath(String.raw`\phantom{\bigl(\rho^{T}_{S}(\varphi_w y)\bigr)(u)}
=\bigl(\rho^{T}_{S}\,y\bigr)(u)\qquad(\because\ \blkref{def_restriction_map})`),
      paragraph([
        "である（",
        math(String.raw`\varphi_w`),
        " は局所真理値表 ",
        math(String.raw`(T,\ f\circ\rho^{T}_{S})`),
        " に対する一点反転写像 ",
        ref("def_flip_map"),
        "）。写像の外延性より ",
        math(String.raw`\rho^{T}_{S}(\varphi_w y)=\rho^{T}_{S}\,y`),
        "、したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(f\circ\rho^{T}_{S})(\varphi_w y)
&=f\bigl(\rho^{T}_{S}(\varphi_w y)\bigr)\qquad(\because\ \blkref{def_redundant_extension})\\
&=f\bigl(\rho^{T}_{S}\,y\bigr)\qquad(\because\ \rho^{T}_{S}(\varphi_w y)=\rho^{T}_{S}\,y)\\
&=(f\circ\rho^{T}_{S})(y)\qquad(\because\ \blkref{def_redundant_extension})
\end{aligned}`,
      ),
      paragraph([
        "である。よって ",
        math(String.raw`(f\circ\rho^{T}_{S})(y)\neq(f\circ\rho^{T}_{S})(\varphi_w y)`),
        " を満たす ",
        math(String.raw`y\in A^{T}`),
        " は存在しない。",
        ref("claim_flip_test_equivalence"),
        " を局所真理値表 ",
        math(String.raw`(T,\ f\circ\rho^{T}_{S})`),
        " に適用すると、",
        math(String.raw`f\circ\rho^{T}_{S}`),
        " は ",
        math(String.raw`w`),
        " に本質的に依存しない。有限集合の元の比較だけを使い、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "redundant_neighbor_claim_dependency_transfer",
    kind: "claim",
    title: { text: "もとの元への本質的依存は冗長拡大で変わらない" },
    labels: ["claim_dependency_transfer"],
    habitat: "finite",
    verification: ["sagemath/check/redundant-neighbor-independence"],
    statement: [
      paragraph([
        "局所真理値表 ",
        math(String.raw`(S,f)`),
        "（",
        ref("def_local_truth_table"),
        "）、有限集合 ",
        math(String.raw`T\supseteq S`),
        "、",
        math(String.raw`w\in S`),
        " について、次の 2 条件は同値である（本質的依存は ",
        ref("def_essential_dependency"),
        "、冗長拡大は ",
        ref("def_redundant_extension"),
        "）。",
      ]),
      displayMath(
        String.raw`f\circ\rho^{T}_{S}\ \text{が}\ w\ \text{に本質的に依存する}\iff f\ \text{が}\ w\ \text{に本質的に依存する}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`(\Leftarrow)`),
        "　",
        ref("def_essential_dependency"),
        " の存在文を満たす ",
        math(String.raw`x,x'\in A^{S}`),
        " を取る。すなわち、すべての ",
        math(String.raw`u\in S\setminus\{w\}`),
        " で ",
        math(String.raw`x(u)=x'(u)`),
        " かつ ",
        math(String.raw`f(x)\neq f(x')`),
        " である。",
        math(String.raw`y:=\iota^{T}_{S}\,x`),
        "、",
        math(String.raw`y':=\iota^{T}_{S}\,x'`),
        " と置く（",
        math(String.raw`\iota^{T}_{S}`),
        " は ",
        ref("def_base_value_extension"),
        "）。任意の ",
        math(String.raw`u\in T\setminus\{w\}`),
        " について、",
        math(String.raw`u\in S\setminus\{w\}`),
        " の場合は",
      ]),
      displayMath(String.raw`\begin{aligned}
y(u)
&=x(u)\qquad(\because\ \blkref{def_base_value_extension}\ \text{の場合分けの上段})\\
&=x'(u)\qquad(\because\ \text{上の一致})\\
&=y'(u)\qquad(\because\ \blkref{def_base_value_extension}\ \text{の場合分けの上段})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`u\in T\setminus S`),
        " の場合は",
      ]),
      displayMath(String.raw`\begin{aligned}
y(u)
&=0\qquad(\because\ \blkref{def_base_value_extension}\ \text{の場合分けの下段})\\
&=y'(u)\qquad(\because\ \blkref{def_base_value_extension}\ \text{の場合分けの下段})
\end{aligned}`),
      paragraph([
        "である。いずれの場合も ",
        math(String.raw`y(u)=y'(u)`),
        " である。また",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(f\circ\rho^{T}_{S})(y)
&=f\bigl(\rho^{T}_{S}(\iota^{T}_{S}\,x)\bigr)\qquad(\because\ \blkref{def_redundant_extension})\\
&=f(x)\qquad(\because\ \blkref{def_base_value_extension}\ \text{の後段})
\end{aligned}`,
      ),
      paragraph([
        "である。同じ二つの定義を ",
        math(String.raw`y'=\iota^{T}_{S}\,x'`),
        " に適用すると",
      ]),
      displayMath(String.raw`\begin{aligned}
(f\circ\rho^{T}_{S})(y')
&=f\bigl(\rho^{T}_{S}(\iota^{T}_{S}\,x')\bigr)\qquad(\because\ \blkref{def_redundant_extension})\\
&=f(x')\qquad(\because\ \blkref{def_base_value_extension}\ \text{の後段})
\end{aligned}`),
      paragraph([
        "である。仮定 ",
        math(String.raw`f(x)\neq f(x')`),
        " と上の二つの等式より ",
        math(String.raw`(f\circ\rho^{T}_{S})(y)\neq(f\circ\rho^{T}_{S})(y')`),
        " である。よって ",
        math(String.raw`(y,y')`),
        " が ",
        ref("def_essential_dependency"),
        " の存在文を局所真理値表 ",
        math(String.raw`(T,\ f\circ\rho^{T}_{S})`),
        " と ",
        math(String.raw`w`),
        " について満たす。",
      ]),
      paragraph([
        math(String.raw`(\Rightarrow)`),
        "　",
        ref("def_essential_dependency"),
        " の存在文を満たす ",
        math(String.raw`y,y'\in A^{T}`),
        " を取る。すなわち、すべての ",
        math(String.raw`u\in T\setminus\{w\}`),
        " で ",
        math(String.raw`y(u)=y'(u)`),
        " かつ ",
        math(String.raw`(f\circ\rho^{T}_{S})(y)\neq(f\circ\rho^{T}_{S})(y')`),
        " である。",
        math(String.raw`x:=\rho^{T}_{S}\,y`),
        "、",
        math(String.raw`x':=\rho^{T}_{S}\,y'`),
        " と置く。任意の ",
        math(String.raw`u\in S\setminus\{w\}`),
        " について、",
        math(String.raw`S\subseteq T`),
        " より ",
        math(String.raw`u\in T\setminus\{w\}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x(u)
&=y(u)\qquad(\because\ \blkref{def_restriction_map})\\
&=y'(u)\qquad(\because\ \text{上の一致})\\
&=x'(u)\qquad(\because\ \blkref{def_restriction_map})
\end{aligned}`,
      ),
      paragraph([
        "である。また、",
        ref("def_redundant_extension"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
f(x)
&=(f\circ\rho^{T}_{S})(y)\qquad(\because\ x=\rho^{T}_{S}\,y)\\
f(x')
&=(f\circ\rho^{T}_{S})(y')\qquad(\because\ x'=\rho^{T}_{S}\,y')
\end{aligned}`),
      paragraph([
        "である。仮定 ",
        math(String.raw`(f\circ\rho^{T}_{S})(y)\neq(f\circ\rho^{T}_{S})(y')`),
        " と上の二つの等式より ",
        math(String.raw`f(x)\neq f(x')`),
        " である。よって ",
        math(String.raw`(x,x')`),
        " が ",
        ref("def_essential_dependency"),
        " の存在文を局所真理値表 ",
        math(String.raw`(S,f)`),
        " と ",
        math(String.raw`w`),
        " について満たす。以上は有限集合の元の比較と写像の値の計算だけからなり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "redundant_neighbor_claim_support_invariance",
    kind: "claim",
    title: { text: "本質的依存台は冗長拡大で変わらない" },
    labels: ["claim_support_invariance"],
    habitat: "finite",
    verification: ["sagemath/check/redundant-neighbor-independence"],
    statement: [
      paragraph([
        "局所真理値表 ",
        math(String.raw`(S,f)`),
        "（",
        ref("def_local_truth_table"),
        "）と有限集合 ",
        math(String.raw`T\supseteq S`),
        " について、",
      ]),
      displayMath(
        String.raw`\operatorname{supp}\bigl(f\circ\rho^{T}_{S}\bigr)=\operatorname{supp}(f)`,
      ),
      paragraph([
        "が集合として成り立つ（本質的依存台は ",
        ref("def_essential_dependency_support"),
        "、冗長拡大は ",
        ref("def_redundant_extension"),
        "）。左辺は ",
        math(String.raw`T`),
        " の部分集合、右辺は ",
        math(String.raw`S`),
        " の部分集合であり、",
        math(String.raw`S\subseteq T`),
        " より両辺とも ",
        math(String.raw`T`),
        " の部分集合なので、この等号は ",
        math(String.raw`T`),
        " の部分集合の間の等号として意味を持つ。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`w\in T`),
        " を任意に取り、",
        math(String.raw`w\in\operatorname{supp}(f\circ\rho^{T}_{S})\iff w\in\operatorname{supp}(f)`),
        " を示す。",
        math(String.raw`T=S\cup(T\setminus S)`),
        " なので ",
        math(String.raw`w\in S`),
        " か ",
        math(String.raw`w\in T\setminus S`),
        " のいずれか一方が成り立つ。",
      ]),
      paragraph([
        math(String.raw`w\in T\setminus S`),
        " の場合。",
        ref("claim_no_dependency_on_redundant_element"),
        " より ",
        math(String.raw`f\circ\rho^{T}_{S}`),
        " は ",
        math(String.raw`w`),
        " に本質的に依存しないので、",
        ref("def_essential_dependency_support"),
        " より ",
        math(String.raw`w\notin\operatorname{supp}(f\circ\rho^{T}_{S})`),
        " である。一方 ",
        ref("def_essential_dependency_support"),
        " より ",
        math(String.raw`\operatorname{supp}(f)\subseteq S`),
        " であり ",
        math(String.raw`w\notin S`),
        " なので ",
        math(String.raw`w\notin\operatorname{supp}(f)`),
        " である。よって両辺とも ",
        math(String.raw`w`),
        " を含まず、所属は一致する。",
      ]),
      paragraph([
        math(String.raw`w\in S`),
        " の場合。",
        ref("def_essential_dependency_support"),
        " より ",
        math(String.raw`w\in\operatorname{supp}(f\circ\rho^{T}_{S})`),
        " は ",
        math(String.raw`f\circ\rho^{T}_{S}`),
        " が ",
        math(String.raw`w`),
        " に本質的に依存することと同値であり、",
        ref("claim_dependency_transfer"),
        " よりそれは ",
        math(String.raw`f`),
        " が ",
        math(String.raw`w`),
        " に本質的に依存することと同値であり、再び ",
        ref("def_essential_dependency_support"),
        " よりそれは ",
        math(String.raw`w\in\operatorname{supp}(f)`),
        " と同値である。よって所属は一致する。",
      ]),
      paragraph([
        "すべての ",
        math(String.raw`w\in T`),
        " で所属が一致するので、集合の外延性より両辺は等しい。有限集合の場合分けと所属の同値だけを使い、実数体も複素数体も現れない。",
      ]),
    ],
  },
]);
