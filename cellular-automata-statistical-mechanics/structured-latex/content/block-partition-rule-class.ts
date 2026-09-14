/**
 * 規則クラスの分別として、有限舞台上のブロック（分割）型更新を定義する。
 *
 * 分割の一つのブロックだけを見る一相更新、有限個の相を順に施す一巡更新、
 * 一相更新として表せるための有限な必要十分条件、および同期更新との境界を記す。
 * 有限集合と有限写像表だけで閉じ、対数、除算、極限、実数体、複素数体は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "block_partition_rule_class_definition_partition",
    kind: "definition",
    title: { text: "有限集合のブロック分割" },
    labels: ["def_block_partition"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " に対し、その有限部分集合の有限集合 ",
        math(String.raw`\mathcal P`), " がブロック分割であるとは、全ての ",
        math(String.raw`B\in\mathcal P`), " が空でなく、全ての ", math(String.raw`v\in V`),
        " に対して ", math(String.raw`v\in B`), " を満たす ", math(String.raw`B\in\mathcal P`),
        " がただ一つ存在することをいう。その唯一のブロックを ", math(String.raw`B_{\mathcal P}(v)`),
        " と書く。",
      ]),
    ],
  },
  {
    id: "block_partition_rule_class_claim_blocks_are_membership_fibers",
    kind: "claim",
    title: { text: "各ブロックは所属ブロック写像の繊維として復元される" },
    labels: ["claim_block_partition_blocks_are_membership_fibers"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_block_partition"), " のブロック分割 ", math(String.raw`\mathcal P`),
        " の各 ", math(String.raw`B\in\mathcal P`), " に対し、",
      ]),
      displayMath(String.raw`\{v\in V\mid B_{\mathcal P}(v)=B\}=B`),
      paragraph(["が成り立つ。"])],
    proof: [
      paragraph([
        math(String.raw`v\in V`), " が左辺に属するとする。すると ",
        math(String.raw`B_{\mathcal P}(v)=B`), " である。", ref("def_block_partition"),
        " により ", math(String.raw`v\in B_{\mathcal P}(v)`), " だから ",
        math(String.raw`v\in B`), " であり、左辺は右辺に含まれる。",
      ]),
      paragraph([
        "逆に ", math(String.raw`v\in B`), " とする。", ref("def_block_partition"),
        " により ", math(String.raw`B_{\mathcal P}(v)`), " は ", math(String.raw`v`),
        " を含む唯一の ", math(String.raw`\mathcal P`), " の元であり、",
        math(String.raw`B`), " も ", math(String.raw`v`), " を含む ",
        math(String.raw`\mathcal P`), " の元だから ",
        math(String.raw`B_{\mathcal P}(v)=B`), " である。したがって ",
        math(String.raw`v`), " は左辺に属し、右辺は左辺に含まれる。二つの包含から等号を得る。",
      ]),
    ],
  },
  {
    id: "block_partition_rule_class_definition_rule_family",
    kind: "definition",
    title: { text: "ブロック局所規則族" },
    labels: ["def_block_local_rule_family"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_block_partition"), " のブロック分割 ", math(String.raw`\mathcal P`), " に対し、",
        math(String.raw`g=(g_B:A^B\to A^B)_{B\in\mathcal P}`),
        " をブロック局所規則族という。ここで ", math(String.raw`A=\{0,1\}`), " は ",
        ref("def_state_set"), " の二元集合である。各 ", math(String.raw`g_B`),
        " は一つのブロックの入力だけから同じブロックの出力を返す有限真理値表である。",
      ]),
    ],
  },
  {
    id: "block_partition_rule_class_definition_phase_update",
    kind: "definition",
    title: { text: "一つの分割による一相更新" },
    labels: ["def_block_phase_update"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_block_partition"), " のブロック分割 ", math(String.raw`\mathcal P`), " と ",
        ref("def_block_local_rule_family"), " の規則族 ", math(String.raw`g`), " に対し、一相更新 ",
        math(String.raw`U_{\mathcal P,g}:A^V\to A^V`), " を",
      ]),
      displayMath(String.raw`\bigl(U_{\mathcal P,g}(x)\bigr)(v)
:=g_{B_{\mathcal P}(v)}\!\left(x|_{B_{\mathcal P}(v)}\right)(v)
\qquad(x\in A^V,\ v\in V)`),
      paragraph([
        "で定める。", math(String.raw`B_{\mathcal P}(v)`), " は ", ref("def_block_partition"),
        " で一意なので右辺は定まり、同じ相では互いに交わらない全ブロックを並行して更新する。",
      ]),
    ],
  },
  {
    id: "block_partition_rule_class_definition_schedule",
    kind: "definition",
    title: { text: "有限ブロックスケジュール" },
    labels: ["def_finite_block_schedule"],
    habitat: "finite",
    statement: [
      paragraph([
        "正の自然数 ", math(String.raw`m\in\mathbb N_{>0}`), " と、各 ",
        math(String.raw`j\in[0,m-1]_{\mathbb{N}}`), " に対する、同じ有限集合 ",
        math(String.raw`V`), " の ", ref("def_block_partition"), " のブロック分割 ",
        math(String.raw`\mathcal P_j`), " および ", math(String.raw`\mathcal P_j`), " 上の ",
        ref("def_block_local_rule_family"), " のブロック局所規則族 ", math(String.raw`g_j`),
        " の列を有限ブロックスケジュールという。ここで ",
        math(String.raw`[0,m-1]_{\mathbb{N}}:=\{j\in\mathbb{N}\mid j<m\}`), " である。",
      ]),
    ],
  },
  {
    id: "block_partition_rule_class_definition_sweep_update",
    kind: "definition",
    title: { text: "ブロック型の一巡更新" },
    labels: ["def_block_sweep_update"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_finite_block_schedule"), " の有限ブロックスケジュールに対し、一巡更新 ",
        math(String.raw`U:A^V\to A^V`), " を",
      ]),
      displayMath(String.raw`U:=U_{\mathcal P_{m-1},g_{m-1}}\circ\cdots\circ U_{\mathcal P_1,g_1}\circ U_{\mathcal P_0,g_0}`),
      paragraph([
        "で定める。各 ", math(String.raw`U_{\mathcal P_j,g_j}`), " は ",
        ref("def_block_phase_update"), " の一相更新である。この有限スケジュールと一巡更新を備えた更新方式をブロック（分割）型という。",
        "相の順序は合成順序としてデータに含め、全セルを同じ局所規則族で同時更新する ",
        ref("def_global_map"), " とは区別する。",
      ]),
    ],
  },
  {
    id: "block_partition_rule_class_claim_phase_characterization",
    kind: "claim",
    title: { text: "一相ブロック更新はブロック内入力だけへの依存で特徴づけられる" },
    labels: ["claim_block_phase_characterization"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " のブロック分割 ", math(String.raw`\mathcal P`),
        " と写像 ", math(String.raw`H:A^V\to A^V`), " を取る。あるブロック局所規則族 ",
        math(String.raw`g`), " により ", math(String.raw`H=U_{\mathcal P,g}`), " と書けることと、",
      ]),
      displayMath(String.raw`\forall B\in\mathcal P\ \forall x,y\in A^V:\quad
x|_B=y|_B\Longrightarrow H(x)|_B=H(y)|_B`),
      paragraph(["が成り立つことは同値である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`(\Rightarrow)`), "　", math(String.raw`H=U_{\mathcal P,g}`),
        " とし、", math(String.raw`B\in\mathcal P`), " と ", math(String.raw`x|_B=y|_B`),
        " を取る。任意の ", math(String.raw`v\in B`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
H(x)(v)
&=g_B(x|_B)(v)\qquad(\because\ \blkref{def_block_phase_update})\\
&=g_B(y|_B)(v)\qquad(\because\ x|_B=y|_B)\\
&=H(y)(v)\qquad(\because\ \blkref{def_block_phase_update}).
\end{aligned}`),
      paragraph([
        "したがって写像の外延性により ", math(String.raw`H(x)|_B=H(y)|_B`), " である。",
      ]),
      paragraph([
        math(String.raw`(\Leftarrow)`), "　表示された条件を仮定する。各 ",
        math(String.raw`B\in\mathcal P`), " と ", math(String.raw`z\in A^B`),
        " に対し、零延長 ", math(String.raw`\widehat z_B\in A^V`), " を、",
        math(String.raw`v\in B`), " なら ", math(String.raw`\widehat z_B(v):=z(v)`),
        "、", math(String.raw`v\notin B`), " なら ", math(String.raw`\widehat z_B(v):=0`),
        " と定め、", math(String.raw`g_B(z):=H(\widehat z_B)|_B`), " と置く。",
      ]),
      paragraph(["任意の ", math(String.raw`x\in A^V`), " と ", math(String.raw`B\in\mathcal P`), " について"]),
      displayMath(String.raw`\begin{aligned}
\widehat{(x|_B)}_B|_B
&=x|_B\qquad(\because\ \widehat{(x|_B)}_B\ \text{の定義})\\
H\!\left(\widehat{(x|_B)}_B\right)|_B
&=H(x)|_B\qquad(\because\ \text{仮定})\\
g_B(x|_B)
&=H(x)|_B\qquad(\because\ g_B\ \text{の定義}).
\end{aligned}`),
      paragraph([
        ref("def_block_partition"), " により各 ", math(String.raw`v\in V`),
        " は唯一のブロックに属するので、", ref("def_block_phase_update"),
        " と写像の外延性から ", math(String.raw`U_{\mathcal P,g}(x)=H(x)`),
        " を得る。したがって ", math(String.raw`H=U_{\mathcal P,g}`), " である。",
      ]),
    ],
  },
  {
    id: "block_partition_rule_class_claim_membership_finite_decidable",
    kind: "claim",
    title: { text: "固定した分割に対する一相ブロック更新への所属は有限決定できる" },
    labels: ["claim_block_phase_membership_finite_decidable"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "、ブロック分割 ", math(String.raw`\mathcal P`),
        "、有限表として与えられた写像 ", math(String.raw`H:A^V\to A^V`),
        " について、", math(String.raw`H`), " が一相ブロック更新として表せるか否かは有限決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        "有限集合 ", math(String.raw`\mathcal P`), " の全ブロック ", math(String.raw`B`),
        " と、有限集合 ", math(String.raw`A^V\times A^V`), " の全入力対 ", math(String.raw`(x,y)`),
        " を列挙する。", math(String.raw`x|_B=y|_B`), " の場合だけ ",
        math(String.raw`H(x)|_B=H(y)|_B`), " を有限比較する。全比較の成立は ",
        ref("claim_block_phase_characterization"), " により一相ブロック更新として表せることと同値である。",
        "したがって有限走査は必ず停止し、所属を決定する。",
      ]),
    ],
  },
  {
    id: "block_partition_rule_class_claim_synchronous_boundary",
    kind: "claim",
    title: { text: "同期局所更新は固定したブロック分割に従うとは限らない" },
    labels: ["claim_synchronous_rule_not_forced_block_local"],
    habitat: "finite",
    statement: [
      paragraph([
        "二セル舞台 ", math(String.raw`V=\{u,v\}`), "、近傍 ",
        math(String.raw`N(u)=N(v)=V`), " 上の同期局所規則を ",
        math(String.raw`f_u(x):=x(v)`), "、", math(String.raw`f_v(x):=x(u)`),
        " とする。この大域写像 ", math(String.raw`F:A^V\to A^V`), " は二セルの状態を交換するが、",
        "一元ブロック分割 ", math(String.raw`\mathcal P=\{\{u\},\{v\}\}`),
        " の一相ブロック更新としては表せない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x,y\in A^V`), " を ", math(String.raw`x(u)=y(u)=0`),
        "、", math(String.raw`x(v)=0`), "、", math(String.raw`y(v)=1`), " で定めると",
      ]),
      displayMath(String.raw`\begin{aligned}
x|_{\{u\}}
&=y|_{\{u\}}\qquad(\because\ x(u)=y(u)=0)\\
F(x)(u)
&=x(v)\qquad(\because\ \blkref{def_global_map})\\
&=0\qquad(\because\ x(v)=0),\\
F(y)(u)
&=y(v)\qquad(\because\ \blkref{def_global_map})\\
&=1\qquad(\because\ y(v)=1).
\end{aligned}`),
      paragraph([
        "ゆえに ", math(String.raw`F(x)|_{\{u\}}\neq F(y)|_{\{u\}}`), " であり、",
        ref("claim_block_phase_characterization"), " の必要条件が破れる。したがって同期局所更新であることから、",
        "指定したブロック分割に従うことは導かれない。",
      ]),
    ],
  },
]);
