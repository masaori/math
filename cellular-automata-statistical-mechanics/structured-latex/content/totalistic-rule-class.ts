/**
 * 規則クラスの分別の最初の対象として、有限な閉近傍舞台上の総和型局所規則族を定義し、
 * クラス所属を有限真理値表の比較へ落とす。
 *
 * 状態集合 A={0,1} には加法を入れず、近傍内で値 1 を取る元の個数だけを自然数として数える。
 * 有限集合・有限写像表・自然数だけで閉じ、対数、除算、実数体、複素数体は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "totalistic_rule_class_definition_closed_symmetric_stage",
    kind: "definition",
    title: { text: "有限な閉近傍舞台" },
    labels: ["def_finite_closed_symmetric_stage"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限近傍系 ", math(String.raw`(V,N)`), "（", ref("def_finite_neighborhood_system"),
        "）が有限な閉近傍舞台であるとは、全ての ", math(String.raw`u,v\in V`), " について",
      ]),
      displayMath(String.raw`v\in N(v)`),
      displayMath(String.raw`u\in N(v)\iff v\in N(u)`),
      paragraph([
        "が成り立つことをいう。各 ", math(String.raw`v\in V`), " に対し ",
        math(String.raw`B(v):=N(v)\setminus\{v\}`), " と置き、これを ", math(String.raw`v`),
        " の開近傍と呼ぶ。これはグラフの辺を別の原始データとして加えず、閉近傍の割り当てだけで対称な隣接を表す定義である。",
      ]),
    ],
  },
  {
    id: "totalistic_rule_class_definition_local_signature",
    kind: "definition",
    title: { text: "局所入力の中心値と一状態数" },
    labels: ["def_totalistic_local_signature"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限な閉近傍舞台 ", math(String.raw`(V,N)`), "（", ref("def_finite_closed_symmetric_stage"),
        "）と ", math(String.raw`v\in V`), "、局所入力 ", math(String.raw`x\in A^{N(v)}`), " に対し、",
      ]),
      displayMath(String.raw`c_v(x):=\bigl|\{\,w\in B(v)\mid x(w)=1\,\}\bigr|\in\mathbb N`),
      displayMath(String.raw`s_v(x):=\bigl(x(v),c_v(x)\bigr)\in A\times[0,|V|]_{\mathbb{N}}`),
      paragraph([
        "と定める。ここで ", math(String.raw`A=\{0,1\}`), " は ", ref("def_state_set"),
        "、", math(String.raw`[0,|V|]_{\mathbb{N}}:=\{k\in\mathbb{N}\mid k\leq |V|\}`),
        " である。", math(String.raw`B(v)\subseteq V`), " なので ", math(String.raw`c_v(x)\leq|V|`),
        " であり、", math(String.raw`s_v`), " の終域は有限集合である。状態同士の加法は使わず、値が ",
        math(String.raw`1`), " である元の個数だけを数える。",
      ]),
    ],
  },
  {
    id: "totalistic_rule_class_definition_totalistic_family",
    kind: "definition",
    title: { text: "総和型の局所規則族" },
    labels: ["def_totalistic_local_rule_family"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限な閉近傍舞台 ", math(String.raw`(V,N)`), " 上の局所規則族 ",
        math(String.raw`(f_v:A^{N(v)}\to A)_{v\in V}`), "（", ref("def_finite_ca"),
        "）が総和型であるとは、有限表",
      ]),
      displayMath(String.raw`\varphi:A\times[0,|V|]_{\mathbb{N}}\longrightarrow A`),
      paragraph(["が存在し、全ての ", math(String.raw`v\in V`), " と ", math(String.raw`x\in A^{N(v)}`), " について"]),
      displayMath(String.raw`f_v(x)=\varphi\bigl(s_v(x)\bigr)`),
      paragraph([
        "が成り立つことをいう（", math(String.raw`s_v`), " は ", ref("def_totalistic_local_signature"),
        "）。したがって出力は中心値と開近傍で値 ", math(String.raw`1`),
        " を取る元の個数だけに依存し、近傍の元の並べ方には依存しない。",
      ]),
    ],
  },
  {
    id: "totalistic_rule_class_claim_pairwise_characterization",
    kind: "claim",
    title: { text: "総和型は同じ中心値と一状態数を持つ入力の比較で特徴づけられる" },
    labels: ["claim_totalistic_pairwise_characterization"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限な閉近傍舞台 ", math(String.raw`(V,N)`), " と局所規則族 ", math(String.raw`(f_v)_{v\in V}`),
        " について、この族が総和型であることと、",
      ]),
      displayMath(String.raw`\forall\,u,v\in V\ \forall\,x\in A^{N(u)}\ \forall\,y\in A^{N(v)}:\quad
s_u(x)=s_v(y)\Longrightarrow f_u(x)=f_v(y)`),
      paragraph(["が成り立つことは同値である。"]),
    ],
    proof: [
      paragraph([math(String.raw`(\Rightarrow)`), "　", ref("def_totalistic_local_rule_family"), " の ", math(String.raw`\varphi`), " を取る。仮定 ", math(String.raw`s_u(x)=s_v(y)`), " に対し"]),
      displayMath(String.raw`\begin{aligned}
f_u(x)
&=\varphi\bigl(s_u(x)\bigr)\qquad(\because\ \blkref{def_totalistic_local_rule_family})\\
&=\varphi\bigl(s_v(y)\bigr)\qquad(\because\ s_u(x)=s_v(y))\\
&=f_v(y)\qquad(\because\ \blkref{def_totalistic_local_rule_family}).
\end{aligned}`),
      paragraph([
        math(String.raw`(\Leftarrow)`), "　表示された条件を仮定する。各 ",
        math(String.raw`(a,k)\in A\times[0,|V|]_{\mathbb{N}}`), " に対し、",
        math(String.raw`s_v(x)=(a,k)`), " を満たす組 ", math(String.raw`(v,x)`),
        " が存在するときはその一つを選び ", math(String.raw`\varphi(a,k):=f_v(x)`),
        " と置き、存在しないときは ", math(String.raw`\varphi(a,k):=0`), " と置く。",
        "前者の値は、別の組を選んでも仮定により同じ出力になるので well-defined である。",
      ]),
      paragraph(["任意の ", math(String.raw`v\in V`), " と ", math(String.raw`x\in A^{N(v)}`), " について、組 ", math(String.raw`(v,x)`), " 自身が ", math(String.raw`s_v(x)`), " を実現するので"]),
      displayMath(String.raw`\varphi\bigl(s_v(x)\bigr)=f_v(x)\qquad(\because\ \varphi\ \text{の実現される入力での定義}).`),
      paragraph(["よって ", ref("def_totalistic_local_rule_family"), " により局所規則族は総和型である。全ての選択と比較は有限集合上で行われる。"]),
    ],
  },
  {
    id: "totalistic_rule_class_claim_finite_decidability",
    kind: "claim",
    title: { text: "有限な閉近傍舞台上の総和型所属は有限決定できる" },
    labels: ["claim_totalistic_membership_finite_decidable"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限な閉近傍舞台と、その上の有限真理値表として与えられた局所規則族について、総和型であるか否かは有限決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        "セル ", math(String.raw`u,v\in V`), " の全ての組と、有限集合 ", math(String.raw`A^{N(u)}`),
        "・", math(String.raw`A^{N(v)}`), " の全ての入力 ", math(String.raw`x,y`),
        " を列挙する。各組で ", math(String.raw`s_u(x)=s_v(y)`), " を自然数と二元状態の有限比較で判定し、",
        "等しい場合だけ ", math(String.raw`f_u(x)=f_v(y)`), " を比較する。全比較が成立することは ",
        ref("claim_totalistic_pairwise_characterization"), " により総和型であることと同値である。",
        "したがってこの有限走査は必ず停止し、総和型所属を決定する。",
      ]),
    ],
  },
]);
