/**
 * 章「最小前周期と最小周期」: 前章「自己写像の反復と軌道の最終周期性」の続き。
 * 各元 y について、最終周期性を与える組 (i,p) の集合 P(y) を定義し、
 * その最小元として最小前周期 μ(y) と最小周期 π(y) を定める。
 *
 * - P(y) の所属は F^{i+p} y = F^{i} y という 1 回の元の等号と同値（有限決定の根拠）
 * - μ(y), π(y) は ℕ の整列性により一意に定まる
 * - 任意の周期 p は最小前周期の位置へ降りる（F^{μ(y)+p} y = F^{μ(y)} y）
 * - μ(y) + π(y) ≤ |X|。したがって有限範囲の走査で μ(y), π(y) が決まる
 *
 * 使う ℕ の構造は後者・加法・乗法（k q の形）・大小比較・等号・整列性だけである。
 * 「過渡」「アトラクタ」等の名前は使わない。ℝ/ℂ は現れない。
 * 文書順はこの配列の並びが正本である。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "minimal_preperiod_period_definition_periodicity_pairs",
    kind: "definition",
    title: { text: "前周期・周期の組の集合" },
    labels: ["def_periodicity_pairs"],
    habitat: "N",
    statement: [
      paragraph([
        "元 ",
        math(String.raw`y\in X`),
        " に対し、集合",
      ]),
      displayMath(
        String.raw`P(y):=\{\,(i,p)\in\mathbb{N}\times\mathbb{N}\ :\ p\ge 1\ \text{かつ}\ \forall n\in\mathbb{N}\,(\,n\ge i\ \Rightarrow\ F^{n+p}\,y=F^{n}\,y\,)\,\}`,
      ),
      paragraph([
        "を ",
        math(String.raw`y`),
        " の前周期・周期の組の集合と呼ぶ（",
        math(String.raw`F^{n}`),
        " は ",
        ref("def_finite_self_map_iterate"),
        "）。",
        ref("claim_finite_self_map_repeating_tail"),
        " により ",
        math(String.raw`P(y)\neq\emptyset`),
        " である。",
      ]),
    ],
  },

  {
    id: "minimal_preperiod_period_claim_pair_iff_collision",
    kind: "claim",
    title: { text: "組の所属は 1 回の元の等号と同値である" },
    labels: ["claim_periodicity_pair_iff_collision"],
    habitat: "N",
    statement: [
      paragraph([
        "各 ",
        math(String.raw`y\in X`),
        " と ",
        math(String.raw`(i,p)\in\mathbb{N}\times\mathbb{N}`),
        " について、",
        math(String.raw`(i,p)\in P(y)`),
        " ",
        math(String.raw`\iff`),
        " （",
        math(String.raw`p\ge 1`),
        " かつ ",
        math(String.raw`F^{i+p}\,y=F^{i}\,y`),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "（",
        math(String.raw`\Rightarrow`),
        "）",
        math(String.raw`(i,p)\in P(y)`),
        " とする。",
        ref("def_periodicity_pairs"),
        " により ",
        math(String.raw`p\ge 1`),
        "。同じ定義の全称文で ",
        math(String.raw`n:=i`),
        " を取る（",
        math(String.raw`i\ge i`),
        " は ",
        math(String.raw`\mathbb{N}`),
        " の大小関係の反射性）と ",
        math(String.raw`F^{i+p}\,y=F^{i}\,y`),
        "。",
      ]),
      paragraph([
        "（",
        math(String.raw`\Leftarrow`),
        "）",
        math(String.raw`p\ge 1`),
        " かつ ",
        math(String.raw`F^{i+p}\,y=F^{i}\,y`),
        " とする。",
        math(String.raw`n\in\mathbb{N}`),
        "、",
        math(String.raw`n\ge i`),
        " を任意に取り、",
        math(String.raw`k:=n-i\in\mathbb{N}`),
        " と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{n+p}\,y
&=F^{(i+k)+p}\,y\qquad(\because\ n=i+k.\ k \text{ の定義})\\
&=F^{(i+p)+k}\,y\qquad(\because\ \mathbb{N} \text{ の加法の結合則と交換則})\\
&=F^{i+k}\,y\qquad(\because\ \blkref{claim_collision_shift}\ \text{を } F^{i+p}y=F^{i}y \text{ と } k \text{ に適用})\\
&=F^{n}\,y\qquad(\because\ i+k=n.\ k \text{ の定義})
\end{aligned}`),
      paragraph([
        math(String.raw`n`),
        " は任意だったので ",
        ref("def_periodicity_pairs"),
        " の全称文が成り立ち、",
        math(String.raw`(i,p)\in P(y)`),
        "。",
      ]),
    ],
  },

  {
    id: "minimal_preperiod_period_definition_min_preperiod",
    kind: "definition",
    title: { text: "最小前周期" },
    labels: ["def_min_preperiod"],
    habitat: "N",
    statement: [
      paragraph([
        "元 ",
        math(String.raw`y\in X`),
        " に対し、集合",
      ]),
      displayMath(
        String.raw`I(y):=\{\,i\in\mathbb{N}\ :\ \exists p\in\mathbb{N}\,(\,(i,p)\in P(y)\,)\,\}\subseteq\mathbb{N}`,
      ),
      paragraph([
        "は ",
        math(String.raw`P(y)\neq\emptyset`),
        "（",
        ref("def_periodicity_pairs"),
        "）により空でない。",
        math(String.raw`\mathbb{N}`),
        " の整列性（空でない部分集合は最小元をもつ）により最小元が存在し、最小元は ",
        math(String.raw`\mathbb{N}`),
        " の大小関係の反対称性により一意である。この最小元を",
      ]),
      displayMath(String.raw`\mu(y):=\min I(y)\in\mathbb{N}`),
      paragraph([
        "と書き、",
        math(String.raw`y`),
        " の最小前周期と呼ぶ。",
      ]),
    ],
  },

  {
    id: "minimal_preperiod_period_definition_min_period",
    kind: "definition",
    title: { text: "最小周期" },
    labels: ["def_min_period"],
    habitat: "N",
    statement: [
      paragraph([
        "元 ",
        math(String.raw`y\in X`),
        " に対し、集合",
      ]),
      displayMath(
        String.raw`Q(y):=\{\,p\in\mathbb{N}\ :\ (\mu(y),p)\in P(y)\,\}\subseteq\mathbb{N}`,
      ),
      paragraph([
        "は、",
        math(String.raw`\mu(y)\in I(y)`),
        "（",
        ref("def_min_preperiod"),
        "。最小元は集合の元である）により空でない。",
        math(String.raw`\mathbb{N}`),
        " の整列性と反対称性により最小元が一意に存在する。この最小元を",
      ]),
      displayMath(String.raw`\pi(y):=\min Q(y)\in\mathbb{N}`),
      paragraph([
        "と書き、",
        math(String.raw`y`),
        " の最小周期と呼ぶ。",
        math(String.raw`(\mu(y),\pi(y))\in P(y)`),
        " なので ",
        ref("def_periodicity_pairs"),
        " により ",
        math(String.raw`\pi(y)\ge 1`),
        " である。",
      ]),
    ],
  },

  {
    id: "minimal_preperiod_period_claim_period_multiples",
    kind: "claim",
    title: { text: "周期の倍数も周期である" },
    labels: ["claim_period_multiples"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`y\in X`),
        "、",
        math(String.raw`i,q\in\mathbb{N}`),
        " が ",
        math(String.raw`F^{i+q}\,y=F^{i}\,y`),
        " を満たすなら、すべての ",
        math(String.raw`k\in\mathbb{N}`),
        " について ",
        math(String.raw`F^{i+kq}\,y=F^{i}\,y`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k`),
        " についての帰納法で示す。",
        math(String.raw`k=0`),
        " のときは ",
        math(String.raw`0\cdot q=0`),
        "、",
        math(String.raw`i+0=i`),
        "（",
        math(String.raw`\mathbb{N}`),
        " の乗法の零元、加法の単位元）なので両辺は同じ ",
        math(String.raw`F^{i}\,y`),
        " である。",
        math(String.raw`k`),
        " で成り立つとして ",
        math(String.raw`k+1`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{i+(k+1)q}\,y
&=F^{(i+kq)+q}\,y\qquad(\because\ \mathbb{N} \text{ の分配則と加法の結合則})\\
&=F^{(i+q)+kq}\,y\qquad(\because\ \mathbb{N} \text{ の加法の結合則と交換則})\\
&=F^{i+kq}\,y\qquad(\because\ \blkref{claim_collision_shift}\ \text{を } F^{i+q}y=F^{i}y \text{ と } kq \text{ に適用})\\
&=F^{i}\,y\qquad(\because\ \text{帰納法の仮定})
\end{aligned}`),
    ],
  },

  {
    id: "minimal_preperiod_period_claim_period_descends",
    kind: "claim",
    title: { text: "任意の周期は最小前周期の位置へ降りる" },
    labels: ["claim_period_descends_to_min_preperiod"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`y\in X`),
        " と ",
        math(String.raw`(i,p)\in P(y)`),
        " について、",
        math(String.raw`F^{\mu(y)+p}\,y=F^{\mu(y)}\,y`),
        "。したがって ",
        math(String.raw`(\mu(y),p)\in P(y)`),
        " であり、",
        math(String.raw`\pi(y)\le p`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mu:=\mu(y)`),
        "、",
        math(String.raw`q:=\pi(y)`),
        " と略記する。",
        ref("def_min_period"),
        " により ",
        math(String.raw`(\mu,q)\in P(y)`),
        "、",
        math(String.raw`q\ge 1`),
        "。",
        ref("claim_periodicity_pair_iff_collision"),
        " により ",
        math(String.raw`F^{\mu+q}\,y=F^{\mu}\,y`),
        "。また ",
        math(String.raw`i\in I(y)`),
        "（",
        math(String.raw`(i,p)\in P(y)`),
        " による）なので、",
        ref("def_min_preperiod"),
        " の最小性により ",
        math(String.raw`\mu\le i`),
        "。",
        math(String.raw`k:=i-\mu\in\mathbb{N}`),
        " と置く。",
        math(String.raw`q\ge 1`),
        " なので ",
        math(String.raw`kq\ge k`),
        "（",
        math(String.raw`\mathbb{N}`),
        " の乗法の単調性）、したがって ",
        math(String.raw`\mu+kq\ge\mu+k=i`),
        "（",
        math(String.raw`\mathbb{N}`),
        " の加法の単調性と ",
        math(String.raw`k`),
        " の定義）。",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{\mu+p}\,y
&=F^{(\mu+kq)+p}\,y\qquad(\because\ \blkref{claim_period_multiples}\ \text{を } F^{\mu+q}y=F^{\mu}y \text{ と } k \text{ に適用して得た } F^{\mu+kq}y=F^{\mu}y \text{ に、}\blkref{claim_collision_shift}\ \text{を } p \text{ で適用})\\
&=F^{\mu+kq}\,y\qquad(\because\ (i,p)\in P(y) \text{ の全称文を } n:=\mu+kq\ge i \text{ に適用。}\blkref{def_periodicity_pairs})\\
&=F^{\mu}\,y\qquad(\because\ \blkref{claim_period_multiples}\ \text{を } F^{\mu+q}y=F^{\mu}y \text{ と } k \text{ に適用})
\end{aligned}`),
      paragraph([
        math(String.raw`p\ge 1`),
        "（",
        math(String.raw`(i,p)\in P(y)`),
        "）と合わせて ",
        ref("claim_periodicity_pair_iff_collision"),
        " により ",
        math(String.raw`(\mu,p)\in P(y)`),
        "、すなわち ",
        math(String.raw`p\in Q(y)`),
        "。",
        ref("def_min_period"),
        " の最小性により ",
        math(String.raw`\pi(y)\le p`),
        "。",
      ]),
    ],
  },

  {
    id: "minimal_preperiod_period_claim_bound",
    kind: "claim",
    title: { text: "最小前周期と最小周期の和は元の個数以下である" },
    labels: ["claim_min_preperiod_period_bound"],
    habitat: "N",
    statement: [
      paragraph([
        "各 ",
        math(String.raw`y\in X`),
        " について ",
        math(String.raw`\mu(y)+\pi(y)\le |X|`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_finite_self_map_repeating_tail"),
        " により ",
        math(String.raw`(i,p)\in P(y)`),
        " で ",
        math(String.raw`i+p\le |X|`),
        " を満たすものを取る。",
        math(String.raw`i\in I(y)`),
        " なので ",
        ref("def_min_preperiod"),
        " の最小性により ",
        math(String.raw`\mu(y)\le i`),
        "。",
        ref("claim_period_descends_to_min_preperiod"),
        " により ",
        math(String.raw`\pi(y)\le p`),
        "。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mu(y)+\pi(y)
&\le i+\pi(y)\qquad(\because\ \mu(y)\le i \text{ と } \mathbb{N} \text{ の加法の単調性})\\
&\le i+p\qquad(\because\ \pi(y)\le p \text{ と } \mathbb{N} \text{ の加法の単調性})\\
&\le |X|\qquad(\because\ (i,p) \text{ の取り方})
\end{aligned}`),
    ],
  },

  {
    id: "minimal_preperiod_period_claim_finite_decidability",
    kind: "claim",
    title: { text: "最小前周期と最小周期は有限範囲の走査で決まる" },
    labels: ["claim_min_preperiod_period_finite_decidability"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`M:=|X|`),
        " と置く。各 ",
        math(String.raw`y\in X`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\mu(y)&=\min\{\,i\in[0,M]_{\mathbb{N}}\ :\ \exists p\in[1,M-i]_{\mathbb{N}}\,(\,F^{i+p}\,y=F^{i}\,y\,)\,\},\\
\pi(y)&=\min\{\,p\in[1,M-\mu(y)]_{\mathbb{N}}\ :\ F^{\mu(y)+p}\,y=F^{\mu(y)}\,y\,\}
\end{aligned}`),
      paragraph([
        "が成り立ち、右辺の各集合は空でない有限集合である。したがって ",
        math(String.raw`\mu(y),\pi(y)`),
        " は、高々 ",
        math(String.raw`\tfrac{1}{2}(M+1)M`),
        " 回の ", math(String.raw`X`), " の元の等号検査（",
        ref("claim_collision_finite_decidability"),
        "）で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        "右辺の一つ目の集合を ",
        math(String.raw`I'(y)`),
        " と書く。",
        ref("claim_periodicity_pair_iff_collision"),
        " により、",
        math(String.raw`i\in I'(y)`),
        " ",
        math(String.raw`\iff`),
        " （",
        math(String.raw`i\le M`),
        " かつ ある ",
        math(String.raw`p\in\mathbb{N}`),
        " で ",
        math(String.raw`1\le p\le M-i`),
        " かつ ",
        math(String.raw`(i,p)\in P(y)`),
        "）。特に ",
        math(String.raw`I'(y)\subseteq I(y)`),
        "（",
        ref("def_min_preperiod"),
        "）。一方 ",
        ref("claim_min_preperiod_period_bound"),
        " により ",
        math(String.raw`\mu(y)+\pi(y)\le M`),
        " なので、",
        math(String.raw`\mu(y)\le M`),
        "、",
        math(String.raw`1\le\pi(y)\le M-\mu(y)`),
        "（",
        ref("def_min_period"),
        " により ",
        math(String.raw`\pi(y)\ge 1`),
        "、",
        math(String.raw`(\mu(y),\pi(y))\in P(y)`),
        "）、よって ",
        math(String.raw`\mu(y)\in I'(y)`),
        "。",
        math(String.raw`I'(y)\subseteq I(y)`),
        " により ",
        math(String.raw`\min I'(y)\ge\min I(y)=\mu(y)`),
        "、",
        math(String.raw`\mu(y)\in I'(y)`),
        " により ",
        math(String.raw`\min I'(y)\le\mu(y)`),
        "。",
        math(String.raw`\mathbb{N}`),
        " の大小関係の反対称性により ",
        math(String.raw`\min I'(y)=\mu(y)`),
        "。",
      ]),
      paragraph([
        "右辺の二つ目の集合を ",
        math(String.raw`Q'(y)`),
        " と書く。",
        ref("claim_periodicity_pair_iff_collision"),
        " により ",
        math(String.raw`Q'(y)=\{\,p\in Q(y)\ :\ p\le M-\mu(y)\,\}\subseteq Q(y)`),
        "（",
        ref("def_min_period"),
        "）。上と同じく ",
        math(String.raw`\pi(y)\le M-\mu(y)`),
        " により ",
        math(String.raw`\pi(y)\in Q'(y)`),
        "。包含と所属から、反対称性により ",
        math(String.raw`\min Q'(y)=\pi(y)`),
        "。",
      ]),
      paragraph([
        "走査回数: 検査する組 ",
        math(String.raw`(i,i+p)`),
        " は ",
        math(String.raw`0\le i<i+p\le M`),
        " を満たすので、",
        ref("claim_collision_finite_decidability"),
        " の証明で数えた ",
        math(String.raw`\{(i,j):0\le i<j\le M\}`),
        " の元であり、その個数は ",
        math(String.raw`\tfrac{1}{2}(M+1)M`),
        "。",
        math(String.raw`\mu(y)`),
        " の走査で ",
        math(String.raw`(\mu(y),\mu(y)+p)`),
        " の形の組は既に検査されているので、",
        math(String.raw`\pi(y)`),
        " の決定に追加の等号検査は要らない。",
      ]),
    ],
  },
]);
