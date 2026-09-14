/**
 * 有限舞台上の有理重みの確率的局所規則族、大域遷移重み、有限回合成を定義する。
 * 有理数の有限和・有限積だけを使い、極限、実数体、複素数体は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "probabilistic_rule_class_definition_local_family",
    kind: "definition",
    title: { text: "有限舞台上の有理重みの確率的局所規則族" },
    labels: ["def_rational_probabilistic_local_rule_family"],
    habitat: "Q",
    statement: [
      paragraph(["有限舞台 ", math(String.raw`(V,N)`), " と二元状態集合 ", math(String.raw`A=\{0,1\}`), "（", ref("def_finite_ca"), "）を取る。有理確率重みの集合を ", math(String.raw`\mathbb Q_{\mathrm{prob}}:=\{q\in\mathbb Q\mid0\le q\le1\}`), " と定め、各 ", math(String.raw`v\in V`), " に有限表"]),
      displayMath(String.raw`\kappa_v:A^{N(v)}\longrightarrow\mathbb Q_{\mathrm{prob}}`),
      paragraph(["を与えた族 ", math(String.raw`\kappa=(\kappa_v)_{v\in V}`), " を有理重みの確率的局所規則族という。", math(String.raw`\mathbb Q_{\mathrm{prob}}`), " は高々可算な集合であり、実数区間ではない。", math(String.raw`\kappa_v(z)`), " は入力 ", math(String.raw`z`), " のもとで出力が一になる重み、", math(String.raw`1-\kappa_v(z)`), " は出力が零になる重みである。"]),
    ],
  },
  {
    id: "probabilistic_rule_class_definition_local_output_weight",
    kind: "definition",
    title: { text: "一セルの条件付き出力重み" },
    labels: ["def_probabilistic_local_output_weight"],
    habitat: "Q",
    statement: [
      paragraph([ref("def_rational_probabilistic_local_rule_family"), " の規則族に対し ", math(String.raw`w_{v,z}:A\to\mathbb Q_{\mathrm{prob}}`), " を"]),
      displayMath(String.raw`w_{v,z}(a):=\begin{cases}1-\kappa_v(z),&a=0,\\\kappa_v(z),&a=1\end{cases}`),
      paragraph(["で定める。このとき ", math(String.raw`w_{v,z}(0)+w_{v,z}(1)=1`), " である。"]),
    ],
  },
  {
    id: "probabilistic_rule_class_definition_global_transition_weight",
    kind: "definition",
    title: { text: "有限配位間の大域遷移重み" },
    labels: ["def_probabilistic_global_transition_weight"],
    habitat: "Q",
    statement: [
      paragraph(["有限配位集合を ", math(String.raw`X:=A^V`), " と置く。各セルの次状態を現在配位のもとで独立に選ぶ大域遷移重み ", math(String.raw`K_\kappa:X\times X\to\mathbb Q_{\mathrm{prob}}`), " を"]),
      displayMath(String.raw`K_\kappa(x,y):=\prod_{v\in V}w_{v,\,x|_{N(v)}}\bigl(y(v)\bigr)`),
      paragraph(["で定める。これは有限集合 ", math(String.raw`V`), " 上の有限積である。"]),
    ],
  },
  {
    id: "probabilistic_rule_class_theorem_global_normalization",
    kind: "theorem",
    title: { text: "大域遷移重みは各入力配位で有理確率分布になる" },
    labels: ["theorem_probabilistic_global_transition_normalized"],
    habitat: "Q",
    statement: [paragraph(["全ての ", math(String.raw`x\in X`), " について"]), displayMath(String.raw`\sum_{y\in X}K_\kappa(x,y)=1`), paragraph(["が成り立つ。従って ", math(String.raw`y\mapsto K_\kappa(x,y)`), " は有限集合 ", math(String.raw`X`), " 上の有理確率分布である。"])],
    proof: [
      paragraph([math(String.raw`x\in X`), " を固定する。"]),
      displayMath(String.raw`\begin{aligned}
\sum_{y\in X}K_\kappa(x,y)
&=\sum_{y\in A^V}\prod_{v\in V}w_{v,\,x|_{N(v)}}(y(v))\qquad(\because\ \blkref{def_probabilistic_global_transition_weight})\\
&=\prod_{v\in V}\left(\sum_{a\in A}w_{v,\,x|_{N(v)}}(a)\right)\qquad(\because\ \text{有限和に対する有限積の分配則})\\
&=\prod_{v\in V}1\qquad(\because\ \blkref{def_probabilistic_local_output_weight})\\
&=1\qquad(\because\ \text{有限積の単位元}).
\end{aligned}`),
      paragraph(["各項の非負性は ", ref("def_rational_probabilistic_local_rule_family"), " の値域と有限積の非負性による。"]),
    ],
  },
  {
    id: "probabilistic_rule_class_claim_finite_step_rational_closure",
    kind: "claim",
    title: { text: "有限回の確率的更新は有理数の中で閉じる" },
    labels: ["claim_probabilistic_finite_step_rational_closure"],
    habitat: "Q",
    statement: [
      paragraph(["有限回遷移重み ", math(String.raw`K_\kappa^{\langle n\rangle}:X\times X\to\mathbb Q_{\mathrm{prob}}`), " を"]),
      displayMath(String.raw`K_\kappa^{\langle0\rangle}(x,y):=\begin{cases}1,&x=y,\\0,&x\ne y,\end{cases}`),
      displayMath(String.raw`K_\kappa^{\langle n+1\rangle}(x,y):=\sum_{z\in X}K_\kappa^{\langle n\rangle}(x,z)K_\kappa(z,y)`),
      paragraph(["で再帰的に定める。全ての ", math(String.raw`n\in\mathbb N`), " で各重みは有理数かつ非負であり、", math(String.raw`\sum_{y\in X}K_\kappa^{\langle n\rangle}(x,y)=1`), " である。これは有限回の主張であり、", math(String.raw`n\to\infty`), " の極限、実数への埋め込み、収束概念を定義していない。"]),
    ],
    proof: [
      paragraph([math(String.raw`n`), " に関する帰納法を使う。零回では有限配位の等号判定と定義から成り立つ。帰納法の仮定のもとで、各項は有理数の積なので有理数かつ非負であり、有限和も同じである。総和は"]),
      displayMath(String.raw`\begin{aligned}
\sum_{y\in X}K_\kappa^{\langle n+1\rangle}(x,y)
&=\sum_{y\in X}\sum_{z\in X}K_\kappa^{\langle n\rangle}(x,z)K_\kappa(z,y)\qquad(\because\ K_\kappa^{\langle n+1\rangle}\ \text{の定義})\\
&=\sum_{z\in X}K_\kappa^{\langle n\rangle}(x,z)\left(\sum_{y\in X}K_\kappa(z,y)\right)\qquad(\because\ \text{有限和の交換と分配則})\\
&=\sum_{z\in X}K_\kappa^{\langle n\rangle}(x,z)\qquad(\because\ \blkref{theorem_probabilistic_global_transition_normalized})\\
&=1\qquad(\because\ \text{帰納法の仮定}).
\end{aligned}`),
    ],
  },
  {
    id: "probabilistic_rule_class_claim_membership_finite_decidable",
    kind: "claim",
    title: { text: "有理表の確率的局所規則族への所属は有限決定できる" },
    labels: ["claim_probabilistic_membership_finite_decidable"],
    habitat: "Q",
    statement: [paragraph(["有限舞台と候補となる有限有理表 ", math(String.raw`(r_v:A^{N(v)}\to\mathbb Q)_{v\in V}`), " が与えられたとき、それが有理重みの確率的局所規則族であるか否かは有限決定できる。"])],
    proof: [paragraph(["全ての ", math(String.raw`v\in V`), " と ", math(String.raw`z\in A^{N(v)}`), " を有限列挙し、", math(String.raw`0\le r_v(z)\le1`), " を有理数の順序で比較する。全比較の成立は ", ref("def_rational_probabilistic_local_rule_family"), " の条件そのものである。"])],
  },
  {
    id: "probabilistic_rule_class_claim_deterministic_boundary",
    kind: "claim",
    title: { text: "決定論的規則は零一重みの特別な場合に限られる" },
    labels: ["claim_deterministic_rules_are_zero_one_probabilistic_rules"],
    habitat: "Q",
    statement: [paragraph(["決定論的局所規則族 ", math(String.raw`(f_v:A^{N(v)}\to A)_{v\in V}`), " に対して ", math(String.raw`\kappa_v(z):=f_v(z)\in\{0,1\}`), " と置くと ", ref("def_rational_probabilistic_local_rule_family"), " の確率的局所規則族を得る。逆に全局所重みが零か一なら一意な決定論的規則族を回復できる。一セル舞台で一定値 ", math(String.raw`\kappa_v(z)=1/2`), " を取る規則は確率的だが決定論的規則からは得られない。"])],
    proof: [paragraph(["決定論的規則は出力 ", math(String.raw`f_v(z)`), " に重み一、もう一方に重み零を与える。逆向きでは重み一となる状態を出力に定める。零一の二つの場合は排反で全てを尽くすため一意である。", math(String.raw`1/2`), " は零でも一でもないので回復条件を満たさない。"])],
  },
]);
