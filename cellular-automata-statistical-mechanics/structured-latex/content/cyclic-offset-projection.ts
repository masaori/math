import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "cyclic_offset_definition_remainder",
    kind: "definition",
    title: { text: "整数の有限剰余代表への写像" },
    labels: ["def_cyclic_integer_remainder"],
    habitat: "countable",
    statement: [
      paragraph(["元数の記法は ", ref("def_cardinality_notation"), " による。自然数から整数への写像を ", math(String.raw`\iota:\mathbb N\to\mathbb Z`),
        "（自然数を同じ非負整数へ送る写像）とする。", math(String.raw`L\in\mathbb N_{>0}`),
        " に対し ", math(String.raw`\ell:=\iota(L)`), " と置き、有限集合と写像を"]),
      displayMath(String.raw`C_L:=\{z\in\mathbb Z:0\le z<\ell\},\qquad
\pi_L:\mathbb Z\longrightarrow C_L`),
      paragraph(["で定める。ただし ", math(String.raw`\pi_L(z)`), " は整数の除法で一意に定まる余り、すなわち ",
        math(String.raw`z=\ell t+\pi_L(z)`), " を満たす ", math(String.raw`t\in\mathbb Z`),
        " が存在する。", math(String.raw`|C_L|=L`), " である。代表と剰余類を同一視せず、以下は整数の代表とこの写像だけを使う。"]),
    ],
  },
  {
    id: "cyclic_offset_definition_interval",
    kind: "definition",
    title: { text: "有限な整数オフセット区間" },
    labels: ["def_integer_offset_interval"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_cyclic_integer_remainder"), " の ", math(String.raw`\iota`),
        " を用い、", math(String.raw`r\in\mathbb N`), " に対し ", math(String.raw`\varrho:=\iota(r)`), " と置く。"]),
      displayMath(String.raw`D_r:=\{j\in\mathbb Z:-\varrho\le j\le \varrho\},\qquad |D_r|=2r+1.`),
      paragraph(["元の順序は整数の順序である。特に ", math(String.raw`r=0`), " を許す。"]),
    ],
  },
  {
    id: "cyclic_offset_definition_projection",
    kind: "definition",
    title: { text: "平行移動したオフセットの有限像" },
    labels: ["def_cyclic_offset_projection"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_cyclic_integer_remainder"), "、", ref("def_integer_offset_interval"),
        " の ", math(String.raw`L,r`), " と ", math(String.raw`v\in C_L`), " に対し、"]),
      displayMath(String.raw`q_{L,r,v}:D_r\longrightarrow C_L,\qquad q_{L,r,v}(j):=\pi_L(v+j),`),
      displayMath(String.raw`M_{L,r,v}:=\{q_{L,r,v}(j):j\in D_r\}\subseteq C_L`),
      paragraph(["と定める。", math(String.raw`L,r`), " を固定した議論では ",
        math(String.raw`q_v:=q_{L,r,v},\ M_v:=M_{L,r,v}`), " と書く。加法は整数の加法である。"]),
    ],
  },
  {
    id: "cyclic_offset_claim_collision",
    kind: "claim",
    title: { text: "オフセットの衝突は差の整除だけで決まる" },
    labels: ["claim_cyclic_offset_collision"],
    habitat: "countable",
    statement: [
      paragraph([ref("def_cyclic_offset_projection"), " の入力で、任意の ", math(String.raw`j,k\in D_r`), " について"]),
      displayMath(String.raw`q_v(j)=q_v(k)\quad\Longleftrightarrow\quad
\exists t\in\mathbb Z:\ j-k=\ell t.`),
      paragraph(["従って等しい像を持つオフセットの組は ", math(String.raw`v`), " に依存しない。"]),
    ],
    proof: [
      paragraph([ref("def_cyclic_integer_remainder"), " による商を ", math(String.raw`a,b\in\mathbb Z`),
        " とし、", math(String.raw`v+j=\ell a+q_v(j),\ v+k=\ell b+q_v(k)`),
        " と書く（", ref("def_cyclic_offset_projection"), "）。像が等しいなら"]),
      displayMath(String.raw`\begin{aligned}
j-k&=(v+j)-(v+k)\\
&=(\ell a+q_v(j))-(\ell b+q_v(k))\quad(\because\ \text{上の除法の表示})\\
&=\ell(a-b)\quad(\because\ q_v(j)=q_v(k)).
\end{aligned}`),
      paragraph(["逆に ", math(String.raw`j-k=\ell t`), " なら"]),
      displayMath(String.raw`\begin{aligned}
v+j&=v+k+\ell t\\
&=\ell b+q_v(k)+\ell t\quad(\because\ \text{上の除法の表示})\\
&=\ell(b+t)+q_v(k).
\end{aligned}`),
      paragraph([math(String.raw`q_v(k)\in C_L`), " なので、", ref("def_cyclic_integer_remainder"),
        " の余りの一意性より ", math(String.raw`q_v(j)=q_v(k)`), "。右辺の存在条件には ",
        math(String.raw`v`), " が現れない。"]),
    ],
  },
  {
    id: "cyclic_offset_claim_image_count",
    kind: "claim",
    title: { text: "オフセットの像の元数は区間長と周期の小さい方である" },
    labels: ["claim_cyclic_offset_image_count"],
    habitat: "N",
    statement: [
      paragraph([ref("def_cyclic_offset_projection"), " の入力で、"]),
      displayMath(String.raw`|M_v|=\min(L,2r+1).`),
    ],
    proof: [
      paragraph([math(String.raw`2r+1\le L`), " の場合を考える。", math(String.raw`j,k\in D_r`),
        " なら ", math(String.raw`-\ell<j-k<\ell`), " である（", ref("def_integer_offset_interval"),
        "）。この範囲の ", math(String.raw`\ell`), " の整数倍は零だけなので、",
        ref("claim_cyclic_offset_collision"), " により像の等号は ", math(String.raw`j=k`), " を含意する。従って"]),
      displayMath(String.raw`\begin{aligned}
|M_v|&=|D_r|\quad(\because\ \text{像への単射は全単射})\\
&=2r+1\quad(\because\ \blkref{def_integer_offset_interval}).
\end{aligned}`),
      paragraph([math(String.raw`L<2r+1`), " の場合には ", math(String.raw`L\le 2r`),
        "。集合 ", math(String.raw`J:=\{-\varrho+s:s\in C_L\}\subseteq D_r`),
        " は ", math(String.raw`L`), " 元を持つ。異なる二元の差は ",
        math(String.raw`-\ell<j-k<\ell`), " にあるため、同じ議論で ",
        math(String.raw`q_v|_J`), " は単射である。像は ", math(String.raw`L`),
        " 元の ", math(String.raw`C_L`), " に含まれるので ", math(String.raw`q_v(J)=C_L`),
        "。従って ", math(String.raw`M_v=C_L`), " であり ", math(String.raw`|M_v|=L`),
        "。これで両方の場合の元数が得られた。"]),
    ],
  },
  {
    id: "cyclic_offset_claim_injective_boundary",
    kind: "claim",
    title: { text: "オフセットの射影が単射となる周期の境界" },
    labels: ["claim_cyclic_offset_injective_boundary"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_cyclic_offset_projection"), " の入力では、"]),
      displayMath(String.raw`q_v\text{ が単射}\quad\Longleftrightarrow\quad 2r+1\le L.`),
    ],
    proof: [
      paragraph(["有限集合からその像への全射が単射であることは元数の一致と同値なので、"]),
      displayMath(String.raw`\begin{aligned}
q_v\text{ が単射}
&\Longleftrightarrow |M_v|=|D_r|\quad(\because\ \text{有限全射の元数})\\
&\Longleftrightarrow \min(L,2r+1)=|D_r|\quad(\because\ \blkref{claim_cyclic_offset_image_count})\\
&\Longleftrightarrow \min(L,2r+1)=2r+1\quad(\because\ \blkref{def_integer_offset_interval})\\
&\Longleftrightarrow 2r+1\le L\quad(\because\ \text{自然数の最小値}).
\end{aligned}`),
      paragraph(["特に短い周期では ", math(String.raw`-\varrho,-\varrho+\ell\in D_r`),
        " が異なる同像の二元になる（", ref("claim_cyclic_offset_collision"), "）。"]),
    ],
  },
]);
