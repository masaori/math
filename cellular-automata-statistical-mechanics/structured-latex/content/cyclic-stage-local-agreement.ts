import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "cyclic_stage_local_agreement_definition_family",
    kind: "definition",
    title: { text: "有限巡回舞台の族と整数からの比較写像" },
    labels: ["def_cyclic_stage_family"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_cyclic_integer_remainder"),
        " の有限集合と余り写像を、正の自然数全体で添字づけた族",
      ]),
      displayMath(String.raw`\mathcal C:=\bigl((C_L,\pi_L)\bigr)_{L\in\mathbb N_{>0}}`),
      paragraph([
        "とする。各 ",
        math(String.raw`C_L`),
        " は ",
        math(String.raw`L`),
        " 元の有限集合であり、比較写像 ",
        math(String.raw`\pi_L:\mathbb Z\to C_L`),
        " は整数をその有限剰余代表へ送る。この族全体は可算個の有限データからなる。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_definition_window_relations",
    kind: "definition",
    title: { text: "有限窓で比較する等号関係" },
    labels: ["def_cyclic_stage_window_equality_relations"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_cyclic_stage_family"),
        " と ",
        ref("def_integer_offset_interval"),
        " を用いる。任意の ",
        math(String.raw`s\in\mathbb N`),
        " と ",
        math(String.raw`L\in\mathbb N_{>0}`),
        " に対し、有限集合 ",
        math(String.raw`D_s\times D_s`),
        " の部分集合を",
      ]),
      displayMath(String.raw`E_{L,s}:=\{(j,k)\in D_s\times D_s:\pi_L(j)=\pi_L(k)\}`),
      displayMath(String.raw`E_{\mathbb Z,s}:=\{(j,k)\in D_s\times D_s:j=k\}`),
      paragraph([
        "と定める。前者は有限巡回舞台で同じセルへ移るオフセットの関係、後者は整数上の等号を同じ有限窓へ制限した関係である。どちらの所属も有限検査で決まる。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_definition_group_operations",
    kind: "definition",
    title: { text: "有限剰余代表集合の巡回群演算" },
    labels: ["def_cyclic_stage_group_operations"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_cyclic_stage_family"),
        " の ",
        math(String.raw`L\in\mathbb N_{>0}`),
        " を固定する。任意の ",
        math(String.raw`a,b\in C_L`),
        " に対し、有限集合 ",
        math(String.raw`C_L`),
        " 上の二項演算、単位元候補、逆元候補を",
      ]),
      displayMath(String.raw`a\oplus_L b:=\pi_L(a+b),\qquad
0_L:=\pi_L(0),\qquad \ominus_L a:=\pi_L(-a)`),
      paragraph([
        "で定める。括弧内の加法と負号は整数の演算であり、値は比較写像を通って ",
        math(String.raw`C_L`),
        " に属する。代表集合と整数を同一視した群演算は使わない。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_claim_remainder_preserves_addition",
    kind: "claim",
    title: { text: "有限剰余への比較写像は整数の加法を巡回演算へ移す" },
    labels: ["claim_cyclic_stage_projection_preserves_addition"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_cyclic_stage_group_operations"),
        " の任意の ",
        math(String.raw`z,w\in\mathbb Z`),
        " について",
      ]),
      displayMath(String.raw`\pi_L(z+w)=\pi_L(z)\oplus_L\pi_L(w)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        ref("def_cyclic_integer_remainder"),
        " により ",
        math(String.raw`z=\ell q+\pi_L(z)`),
        "、",
        math(String.raw`w=\ell t+\pi_L(w)`),
        " を満たす ",
        math(String.raw`q,t\in\mathbb Z`),
        " がある。従って",
      ]),
      displayMath(String.raw`\begin{aligned}
z+w
&=(\ell q+\pi_L(z))+(\ell t+\pi_L(w))
  \quad(\because\ \blkref{def_cyclic_integer_remainder})\\
&=\ell(q+t)+(\pi_L(z)+\pi_L(w))
  \quad(\because\ \mathbb Z\text{ の結合律と分配律}).
\end{aligned}`),
      paragraph([
        math(String.raw`\pi_L(z)+\pi_L(w)`),
        " をさらに ",
        math(String.raw`\ell`),
        " で割った余りが ",
        math(String.raw`\pi_L(z)\oplus_L\pi_L(w)`),
        " である（",
        ref("def_cyclic_stage_group_operations"),
        "）。上の表示と余りの一意性から主張を得る。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_claim_finite_cyclic_group",
    kind: "claim",
    title: { text: "各有限剰余舞台は明示した演算で有限巡回群になる" },
    labels: ["claim_cyclic_stage_is_finite_cyclic_group"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_cyclic_stage_group_operations"),
        " の組 ",
        math(String.raw`(C_L,\oplus_L,0_L,\ominus_L)`),
        " は元数 ",
        math(String.raw`L`),
        " の有限巡回群である。比較写像 ",
        math(String.raw`\pi_L:(\mathbb Z,+,0,-)\to(C_L,\oplus_L,0_L,\ominus_L)`),
        " は全射な群準同型である。",
      ]),
    ],
    proof: [
      paragraph([
        "任意の ",
        math(String.raw`a,b,c\in C_L`),
        " は余りの代表なので ",
        math(String.raw`\pi_L(a)=a`),
        "、",
        math(String.raw`\pi_L(b)=b`),
        "、",
        math(String.raw`\pi_L(c)=c`),
        " である（",
        ref("def_cyclic_integer_remainder"),
        "）。まず結合律は",
      ]),
      displayMath(String.raw`\begin{aligned}
(a\oplus_L b)\oplus_L c
&=\pi_L(a+b)\oplus_L\pi_L(c)
  \quad(\because\ \blkref{def_cyclic_stage_group_operations},\ \pi_L(c)=c)\\
&=\pi_L((a+b)+c)
  \quad(\because\ \blkref{claim_cyclic_stage_projection_preserves_addition})\\
&=\pi_L(a+(b+c))
  \quad(\because\ \mathbb Z\text{ の加法の結合律})\\
&=\pi_L(a)\oplus_L\pi_L(b+c)
  \quad(\because\ \blkref{claim_cyclic_stage_projection_preserves_addition})\\
&=a\oplus_L(b\oplus_L c)
  \quad(\because\ \blkref{def_cyclic_stage_group_operations},\ \pi_L(a)=a).
\end{aligned}`),
      paragraph(["単位元と逆元はそれぞれ"]),
      displayMath(String.raw`\begin{aligned}
0_L\oplus_L a
&=\pi_L(0+a)
  \quad(\because\ \blkref{def_cyclic_stage_group_operations},\ \blkref{claim_cyclic_stage_projection_preserves_addition})\\
&=a
  \quad(\because\ 0+a=a,\ \pi_L(a)=a),\\
a\oplus_L0_L
&=\pi_L(a+0)
  \quad(\because\ \blkref{def_cyclic_stage_group_operations},\ \blkref{claim_cyclic_stage_projection_preserves_addition})\\
&=a
  \quad(\because\ a+0=a,\ \pi_L(a)=a),\\
a\oplus_L(\ominus_La)
&=\pi_L(a+(-a))
  \quad(\because\ \blkref{def_cyclic_stage_group_operations},\ \blkref{claim_cyclic_stage_projection_preserves_addition})\\
&=0_L
  \quad(\because\ a+(-a)=0,\ \blkref{def_cyclic_stage_group_operations}),\\
(\ominus_La)\oplus_La
&=\pi_L((-a)+a)
  \quad(\because\ \blkref{def_cyclic_stage_group_operations},\ \blkref{claim_cyclic_stage_projection_preserves_addition})\\
&=0_L
  \quad(\because\ (-a)+a=0,\ \blkref{def_cyclic_stage_group_operations}).
\end{aligned}`),
      paragraph([
        "よって群である。各 ",
        math(String.raw`a\in C_L`),
        " について、",
        math(String.raw`\iota(m)=a`),
        " を満たす ",
        math(String.raw`m\in\mathbb N`),
        " がある。",
        math(String.raw`\pi_L`),
        " の加法保存を ",
        math(String.raw`m`),
        " について反復すると、",
        math(String.raw`a=\pi_L(\iota(m))`),
        " は ",
        math(String.raw`\pi_L(1)`),
        " を ",
        math(String.raw`m`),
        " 回加えた元である（",
        ref("claim_cyclic_stage_projection_preserves_addition"),
        "）。従って ",
        math(String.raw`\pi_L(1)`),
        " が全体を生成する。元数は ",
        ref("def_cyclic_integer_remainder"),
        " により ",
        math(String.raw`L`),
        " である。加法保存は前の主張、全射性は ",
        math(String.raw`a=\pi_L(a)`),
        " による。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_claim_eventual_exact_window_agreement",
    kind: "claim",
    title: { text: "有限巡回舞台の族は各有限窓で整数と完全に一致する" },
    labels: ["claim_cyclic_stages_eventually_match_integer_window"],
    habitat: "countable",
    statement: [
      paragraph([ref("def_cyclic_stage_window_equality_relations"), " の関係について、"]),
      displayMath(String.raw`\forall s\in\mathbb N\ \exists L_0\in\mathbb N_{>0}\ \forall L\in\mathbb N_{>0}:\quad
L_0\le L\Longrightarrow E_{L,s}=E_{\mathbb Z,s}.`),
      paragraph([
        "特に ",
        math(String.raw`L_0:=2s+1`),
        " と取れる。これは誤差を導入せず、有限関係の完全な一致だけで述べた局所的一致である。実数体・複素数体・全配位空間・量の極限は使わない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`s\in\mathbb N`),
        " を固定し、",
        math(String.raw`L_0:=2s+1`),
        " と置く。",
        math(String.raw`L\in\mathbb N_{>0}`),
        " が ",
        math(String.raw`L_0\le L`),
        " を満たすとする。",
        ref("claim_cyclic_offset_injective_boundary"),
        " を ",
        math(String.raw`r=s`),
        "、",
        math(String.raw`v=0`),
        " に適用すると、",
        math(String.raw`\pi_L|_{D_s}:D_s\to C_L`),
        " は単射である。従って任意の ",
        math(String.raw`j,k\in D_s`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(j,k)\in E_{L,s}
&\Longleftrightarrow \pi_L(j)=\pi_L(k)\quad(\because\ \blkref{def_cyclic_stage_window_equality_relations})\\
&\Longleftrightarrow j=k\quad(\because\ \pi_L|_{D_s}\text{ は単射})\\
&\Longleftrightarrow (j,k)\in E_{\mathbb Z,s}\quad(\because\ \blkref{def_cyclic_stage_window_equality_relations}).
\end{aligned}`),
      paragraph(["外延性により二つの有限関係は等しい。"]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_definition_local_convergence",
    kind: "definition",
    title: { text: "有限窓の等号関係による局所収束" },
    labels: ["def_cyclic_stage_local_convergence"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_cyclic_stage_window_equality_relations"),
        " の関係を用いる。有限巡回舞台と比較写像の族 ",
        math(String.raw`\mathcal C=((C_L,\pi_L))_{L\in\mathbb N_{>0}}`),
        " が整数の舞台へ局所収束するとは、",
      ]),
      displayMath(String.raw`\forall s\in\mathbb N\ \exists L_0\in\mathbb N_{>0}\ \forall L\in\mathbb N_{>0}:\quad
L_0\le L\Longrightarrow E_{L,s}=E_{\mathbb Z,s}`),
      paragraph([
        "が成り立つことと定める。各等号は有限集合 ",
        math(String.raw`D_s\times D_s`),
        " の二つの部分集合の完全一致であり、距離、誤差、実数体、複素数体を導入しない。量の列の収束はこの定義に含めない。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_claim_local_convergence",
    kind: "claim",
    title: { text: "有限巡回舞台の族は整数の舞台へ局所収束する" },
    labels: ["claim_cyclic_stage_family_locally_converges"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_cyclic_stage_family"),
        " の族 ",
        math(String.raw`\mathcal C`),
        " は、",
        ref("def_cyclic_stage_local_convergence"),
        " の意味で整数の舞台へ局所収束する。各 ",
        math(String.raw`s\in\mathbb N`),
        " に対する安定段階は ",
        math(String.raw`L_0=2s+1`),
        " で与えられる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_cyclic_stages_eventually_match_integer_window"),
        " は、任意の ",
        math(String.raw`s\in\mathbb N`),
        " に対して ",
        math(String.raw`L_0=2s+1`),
        " と取れば、全ての ",
        math(String.raw`L\ge L_0`),
        " で ",
        math(String.raw`E_{L,s}=E_{\mathbb Z,s}`),
        " が成り立つことを与える。これは ",
        ref("def_cyclic_stage_local_convergence"),
        " の量化された条件そのものである。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_definition_finite_observation_catalogue",
    kind: "definition",
    title: { text: "整数舞台上の有限局所観測の総体" },
    labels: ["def_integer_stage_finite_observation_catalogue"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_state_set"),
        " の二元集合 ",
        math(String.raw`A`),
        " と ",
        ref("def_integer_offset_interval"),
        " の有限窓を用い、",
      ]),
      displayMath(String.raw`\mathcal W_{\mathrm{fin}}:=
\{(s,u):s\in\mathbb N,\ u\in A^{D_s}\}`),
      paragraph([
        "を整数舞台上の有限局所観測の総体と定める。各元は自然数一つと有限個の状態値の表一つで尽くされる。無限舞台上の全配位はこの集合へ含めない。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_claim_finite_observation_catalogue_countable",
    kind: "claim",
    title: { text: "有限局所観測の総体は可算である" },
    labels: ["claim_integer_stage_finite_observation_catalogue_countable"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_integer_stage_finite_observation_catalogue"),
        " の集合 ",
        math(String.raw`\mathcal W_{\mathrm{fin}}`),
        " は高々可算である。",
      ]),
    ],
    proof: [
      paragraph([
        "固定した ",
        math(String.raw`s\in\mathbb N`),
        " について ",
        ref("def_integer_offset_interval"),
        " から ",
        math(String.raw`|D_s|=2s+1`),
        " であり、",
        ref("def_state_set"),
        " から ",
        math(String.raw`|A|=2`),
        " である。従って",
      ]),
      displayMath(String.raw`|A^{D_s}|=2^{2s+1}\in\mathbb N.`),
      paragraph([
        "よって各 ",
        math(String.raw`s`),
        " に属する局所観測は有限個である。",
        math(String.raw`\mathcal W_{\mathrm{fin}}`),
        " はこれらを ",
        math(String.raw`s\in\mathbb N`),
        " で添字づけた可算個の有限集合の非交和なので、高々可算である。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_definition_integer_stage_finite_support_configurations",
    kind: "definition",
    title: { text: "整数舞台上の有限台配位と全配位" },
    labels: ["def_integer_stage_finite_support_configurations"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_state_set"),
        " の二元集合 ",
        math(String.raw`A`),
        " に対し、整数舞台上の配位 ",
        math(String.raw`x\in A^{\mathbb Z}`),
        " の一状態台を",
      ]),
      displayMath(String.raw`\operatorname{supp}_1(x):=\{z\in\mathbb Z:x(z)=1\}`),
      paragraph(["と定める。有限台配位の集合と全配位の集合をそれぞれ"]),
      displayMath(String.raw`X_{\mathrm{fin}}:=
\{x\in A^{\mathbb Z}:\operatorname{supp}_1(x)\text{ は有限}\},
\qquad X_{\mathrm{all}}:=A^{\mathbb Z}`),
      paragraph([
        "と定める。包含写像 ",
        math(String.raw`\jmath:X_{\mathrm{fin}}\hookrightarrow X_{\mathrm{all}}`),
        " は各有限台配位を同じ写像へ送る。ここでは ",
        math(String.raw`\mathbb Z`),
        " と ",
        math(String.raw`\mathbb N`),
        " の通常の可算性だけを用い、実数体・複素数体・位相・測度・極限を使わない。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_claim_integer_stage_finite_support_configurations_countable",
    kind: "claim",
    title: { text: "整数舞台上の有限台配位は高々可算である" },
    labels: ["claim_integer_stage_finite_support_configurations_countable"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_integer_stage_finite_support_configurations"),
        " の集合 ",
        math(String.raw`X_{\mathrm{fin}}`),
        " は高々可算である。",
      ]),
    ],
    proof: [
      paragraph([
        "各 ",
        math(String.raw`k\in\mathbb N`),
        " に対し、有限整数窓 ",
        ref("def_integer_offset_interval"),
        " を用いて",
      ]),
      displayMath(String.raw`X_k:=\{x\in X_{\mathrm{fin}}:\operatorname{supp}_1(x)\subseteq D_k\}`),
      paragraph(["と置く。窓の外側の値は零に固定され、窓内の各セルには二状態を選べるので"]),
      displayMath(String.raw`|X_k|=2^{|D_k|}=2^{2k+1}\in\mathbb N
\quad(\because\ \blkref{def_state_set},\ \blkref{def_integer_offset_interval}).`),
      paragraph([
        "任意の ",
        math(String.raw`x\in X_{\mathrm{fin}}`),
        " について ",
        math(String.raw`\operatorname{supp}_1(x)`),
        " は有限であるため、ある ",
        math(String.raw`k\in\mathbb N`),
        " が存在して ",
        math(String.raw`\operatorname{supp}_1(x)\subseteq D_k`),
        " となる。従って",
      ]),
      displayMath(String.raw`X_{\mathrm{fin}}=\bigcup_{k\in\mathbb N}X_k
\quad(\because\ \blkref{def_integer_stage_finite_support_configurations}).`),
      paragraph(["右辺は可算個の有限集合の合併なので、高々可算である。"]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_claim_integer_stage_full_configurations_uncountable",
    kind: "claim",
    title: { text: "整数舞台上の全配位は非可算である" },
    labels: ["claim_integer_stage_full_configurations_uncountable"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_integer_stage_finite_support_configurations"),
        " の集合 ",
        math(String.raw`X_{\mathrm{all}}=A^{\mathbb Z}`),
        " は非可算である。従って包含写像 ",
        math(String.raw`\jmath:X_{\mathrm{fin}}\hookrightarrow X_{\mathrm{all}}`),
        " は全射でない。これは集合の濃度についての主張であり、実数体への写像、位相、測度、極限を使わない。",
      ]),
    ],
    proof: [
      paragraph([
        "任意の写像 ",
        math(String.raw`q:\mathbb N\to X_{\mathrm{all}}`),
        " を取る。自然数を同じ非負整数へ送る単射を ",
        math(String.raw`\iota:\mathbb N\to\mathbb Z`),
        " とする。",
        ref("def_negation_map"),
        " の入れ替え写像 ",
        math(String.raw`\nu:A\to A`),
        " を用い、対角配位 ",
        math(String.raw`d_q\in A^{\mathbb Z}`),
        " を",
      ]),
      displayMath(String.raw`d_q(z):=
\begin{cases}
  \nu\!\left(q(n)(\iota(n))\right),
    &z=\iota(n)\text{ となる }n\in\mathbb N\text{ が存在するとき},\\
  0,&z<0
\end{cases}`),
      paragraph([
        "と定める。",
        math(String.raw`\iota`),
        " は単射なので第一の場合の ",
        math(String.raw`n`),
        " は一意であり、この定義は値を一つに定める。任意の ",
        math(String.raw`n\in\mathbb N`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
d_q(\iota(n))
&=\nu\!\left(q(n)(\iota(n))\right)
  \quad(\because\ d_q\text{ の定義})\\
&\neq q(n)(\iota(n))
  \quad(\because\ \blkref{def_negation_map}).
\end{aligned}`),
      paragraph([
        "従って ",
        math(String.raw`d_q\neq q(n)`),
        " である。これは全ての ",
        math(String.raw`n\in\mathbb N`),
        " について成り立つので、",
        math(String.raw`d_q`),
        " は ",
        math(String.raw`q`),
        " の像に属さない。任意の ",
        math(String.raw`q:\mathbb N\to X_{\mathrm{all}}`),
        " が全射でないため、",
        math(String.raw`X_{\mathrm{all}}`),
        " は非可算である。前の主張により ",
        math(String.raw`X_{\mathrm{fin}}`),
        " は高々可算なので、包含写像 ",
        math(String.raw`\jmath`),
        " が全射なら ",
        math(String.raw`X_{\mathrm{all}}`),
        " も高々可算になって矛盾する。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_claim_no_global_injection",
    kind: "claim",
    title: { text: "有限段階の比較写像は整数全体を埋め込まない" },
    labels: ["claim_cyclic_stage_projection_not_globally_injective"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_cyclic_stage_family"),
        " の任意の ",
        math(String.raw`L\in\mathbb N_{>0}`),
        " について、比較写像 ",
        math(String.raw`\pi_L:\mathbb Z\to C_L`),
        " は単射でない。従って前の局所的一致を整数全体の埋め込みと同一視できない。無限舞台の全配位と有限段階の量の収束には別の定義と主張が必要であり、ここでは扱わない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_cyclic_integer_remainder"),
        " の ",
        math(String.raw`\ell=\iota(L)`),
        " は正の整数なので ",
        math(String.raw`0\ne\ell`),
        "。一方、余りの定義から",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi_L(0)&=0\quad(\because\ 0=\ell\cdot0+0)\\
&=\pi_L(\ell)\quad(\because\ \ell=\ell\cdot1+0).
\end{aligned}`),
      paragraph(["相異なる二整数が同じ値を持つので、単射ではない。"]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_definition_global_map_family",
    kind: "definition",
    title: { text: "一つの有限真理値表が有限巡回舞台の族に定める大域写像" },
    labels: ["def_cyclic_stage_global_map_family"],
    habitat: "countable",
    statement: [
      paragraph([
        math(String.raw`r\in\mathbb N`),
        " と局所真理値表 ",
        math(String.raw`g:A^{D_r}\to A`),
        " を固定する。各 ",
        math(String.raw`L\in\mathbb N_{>0}`),
        " に対して ",
        ref("def_cyclic_uniform_rule_map"),
        " が定める有限自己写像を並べた族を",
      ]),
      displayMath(String.raw`\mathcal F_{r,g}:=\bigl(F_{L,r,g}:A^{C_L}\to A^{C_L}\bigr)_{L\in\mathbb N_{>0}}`),
      paragraph([
        "と定める。各定義域 ",
        math(String.raw`A^{C_L}`),
        " は ",
        math(String.raw`2^L`),
        " 元の有限集合であり、族の添字集合だけが高々可算である。異なる ",
        math(String.raw`L`),
        " の配位集合を同一視する写像は定めない。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_definition_fixed_point_count_sequence",
    kind: "definition",
    title: { text: "有限巡回段階の反復不動点数の列" },
    labels: ["def_cyclic_stage_fixed_point_count_sequence"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_cyclic_stage_global_map_family"),
        " と ",
        math(String.raw`n\in\mathbb N_{>0}`),
        " に対し、自然数値の列を",
      ]),
      displayMath(String.raw`\mathbf Z_{r,g,n}:\mathbb N_{>0}\longrightarrow\mathbb N,\qquad
\mathbf Z_{r,g,n}(L):=Z_n(F_{L,r,g})`),
      paragraph([
        "と定める。各項は ",
        ref("def_fixed_points_of_iterate"),
        " の有限集合の元数であり、零も許す。これは各有限段階で定義された列であって、",
        math(String.raw`L`),
        " に関する極限または規格化を含まない。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_definition_positive_stage_domain",
    kind: "definition",
    title: { text: "正の不動点数を持つ有限巡回舞台サイズの集合" },
    labels: ["def_cyclic_stage_positive_count_domain"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_cyclic_stage_fixed_point_count_sequence"),
        " の列に対し、",
      ]),
      displayMath(String.raw`\mathsf{StagePos}_{r,g,n}:=
\{L\in\mathbb N_{>0}:\mathbf Z_{r,g,n}(L)>0\}\subseteq\mathbb N_{>0}`),
      paragraph([
        "と定める。これは高々可算な集合である。正でない項へ対数を適用するための既定値は置かない。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_definition_logarithmic_count_sequence",
    kind: "definition",
    title: { text: "正の有限巡回段階だけに定義する対数順序群値の列" },
    labels: ["def_cyclic_stage_logarithmic_count_sequence"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_cyclic_stage_positive_count_domain"),
        " の定義域から対数順序群への写像を",
      ]),
      displayMath(String.raw`\mathbf\Phi_{r,g,n}:\mathsf{StagePos}_{r,g,n}\longrightarrow\Lambda,\qquad
\mathbf\Phi_{r,g,n}(L):=
\log_\Lambda\!\left(\frac{\mathbf Z_{r,g,n}(L)}1\right)`),
      paragraph([
        "と定める。対数は ",
        ref("def_prime_logarithm"),
        " による。定義域では分子が正なので入力は ",
        math(String.raw`\mathbb Q_{>0}`),
        " に属する。各項は ",
        math(String.raw`Z_n(F_{L,r,g})`),
        " の素因数指数ベクトルである。実対数、除算による規格化、実数体への実現写像は使わない。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_remark_local_and_global_boundaries",
    kind: "remark",
    title: { text: "局所一致・全配位・量の極限は別の主張である" },
    labels: ["remark_cyclic_stage_local_global_limit_boundaries"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("claim_cyclic_stages_eventually_match_integer_window"),
        " が比較するのは、各固定有限窓 ",
        math(String.raw`D_s`),
        " 上の有限な等号関係だけである。",
        ref("def_cyclic_stage_global_map_family"),
        " の異なる配位集合 ",
        math(String.raw`A^{C_L}`),
        " の間には比較写像を定めていない。",
        ref("claim_integer_stage_full_configurations_uncountable"),
        " により、可算無限舞台の全配位集合 ",
        math(String.raw`A^{\mathbb Z}`),
        " は非可算である。従って局所一致から全配位の写像の一致は導かない。",
      ]),
      paragraph([
        ref("claim_cyclic_stage_family_locally_converges"),
        " が確定する局所収束と、",
        ref("claim_integer_stage_finite_observation_catalogue_countable"),
        " が数える有限局所観測は可算側で閉じる。一方、無限舞台上の全配位を一度に取る操作はこの可算な総体を越える。従って局所収束という名称だけから全配位の極限を補ってはならない。",
      ]),
      paragraph([
        ref("def_cyclic_stage_fixed_point_count_sequence"),
        " と ",
        ref("def_cyclic_stage_logarithmic_count_sequence"),
        " は有限段階の項だけを定義する。これらの極限または近似を主張するには、比較する終域、各項から終域への写像、規格化、収束概念を別に定義しなければならない。現段階ではそれらを定義していないため、極限値・誤差・収束を主張しない。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_definition_bare_stage_transport_counterexample",
    kind: "definition",
    title: { text: "セル間の近傍輸送を持たない有限舞台" },
    labels: ["def_bare_stage_transport_counterexample"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_finite_neighborhood_system"),
        " の有限舞台として、相異なる二元からなる集合 ",
        math(String.raw`V_{\lozenge}:=\{u,v\}`),
        " と近傍割り当て",
      ]),
      displayMath(String.raw`N_{\lozenge}(u):=\{u\},\qquad
N_{\lozenge}(v):=\{u,v\}`),
      paragraph([
        "を定める。また、二元を交換する全単射を ",
        math(String.raw`\sigma:V_{\lozenge}\to V_{\lozenge}`),
        "、",
        math(String.raw`\sigma(u):=v`),
        "、",
        math(String.raw`\sigma(v):=u`),
        " と定める。これらは有限集合と有限写像だけからなる。",
      ]),
    ],
  },
  {
    id: "cyclic_stage_local_agreement_claim_bare_stage_loses_uniform_transport",
    kind: "claim",
    title: { text: "一般の舞台から近傍の一様な輸送と平行移動不変性は導けない" },
    labels: ["claim_bare_stage_loses_uniform_transport"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_bare_stage_transport_counterexample"),
        " の舞台では、",
        math(String.raw`N_{\lozenge}(u)`),
        " と ",
        math(String.raw`N_{\lozenge}(v)`),
        " の間に全単射は存在せず、交換写像も近傍を保存しない。すなわち",
      ]),
      displayMath(String.raw`\sigma\bigl[N_{\lozenge}(u)\bigr]\neq
N_{\lozenge}\bigl(\sigma(u)\bigr).`),
      paragraph([
        ref("def_state_set"),
        " の二元状態集合 ",
        math(String.raw`A`),
        " に対して局所規則の二つの入力集合はそれぞれ二元と四元である。従って、一つの固定入力集合上の有限真理値表を、セル間の近傍の全単射で運んで共有することはできない。これは、",
        ref("claim_cyclic_stage_is_finite_cyclic_group"),
        " の有限巡回群構造を落としたとき、近傍の標準的なセル間輸送と平行移動不変性が舞台のデータからは得られなくなる有限反例である。個別の局所規則族を与えることはできるが、その一様性は一般の舞台からは導かれない。",
      ]),
    ],
    proof: [
      paragraph([ref("def_bare_stage_transport_counterexample"), " の定義から"]),
      displayMath(String.raw`\begin{aligned}
|N_{\lozenge}(u)|&=1\quad(\because\ N_{\lozenge}(u)=\{u\}),\\
|N_{\lozenge}(v)|&=2\quad(\because\ N_{\lozenge}(v)=\{u,v\},\ u\neq v).
\end{aligned}`),
      paragraph([
        "有限集合の間に全単射があれば元数は等しいが、",
        math(String.raw`1\neq2`),
        " なので、二つの近傍の間に全単射は存在しない。次に",
      ]),
      displayMath(String.raw`\begin{aligned}
\sigma\bigl[N_{\lozenge}(u)\bigr]
&=\{v\}\quad(\because\ N_{\lozenge}(u)=\{u\},\ \sigma(u)=v),\\
N_{\lozenge}\bigl(\sigma(u)\bigr)
&=\{u,v\}\quad(\because\ \sigma(u)=v,\ N_{\lozenge}(v)=\{u,v\}).
\end{aligned}`),
      paragraph([
        math(String.raw`u\in\{u,v\}`),
        " かつ ",
        math(String.raw`u\notin\{v\}`),
        " なので、二つの集合は等しくない。最後に ",
        ref("def_state_set"),
        " より ",
        math(String.raw`|A|=2`),
        " であるから",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl|A^{N_{\lozenge}(u)}\bigr|
&=2^1=2\quad(\because\ |N_{\lozenge}(u)|=1),\\
\bigl|A^{N_{\lozenge}(v)}\bigr|
&=2^2=4\quad(\because\ |N_{\lozenge}(v)|=2).
\end{aligned}`),
      paragraph([
        "入力集合どうしにも全単射はない。従って近傍の輸送による一つの真理値表の共有はこの舞台データから構成できず、交換写像も近傍割り当ての不変性を与えない。",
      ]),
    ],
  },
]);
