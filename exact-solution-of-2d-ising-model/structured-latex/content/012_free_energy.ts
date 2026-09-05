import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/012_free_energy.ts";

export default defineBlocks([
  {
    id: "heading_free_energy",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { text: "自由エネルギーと熱力学極限" },
    labels: [],
  },

  {
    id: "freeenergy_000_remark_escape_to_real_analysis",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
    title: { text: "実数解析へ移行するのはこの章のこの箇所だけである" },
    labels: ["remark_real_analysis_escape_point"],
    statement: [
      paragraph([
        "ここまでの章はすべて、複素数を成分とする有限サイズの行列の積・和・スカラー倍と、",
        "行列の指数関数（",
        ref("def_exp"),
        "：ノルムについて収束する級数）だけで書かれてきた。",
        "実数の極限は使ったが、積分は一度も使っていない。",
      ]),
      paragraph([
        "**この章の ",
        ref("riemann_sum_to_integral"),
        " が、自由エネルギーの表式（",
        ref("onsager_exact_solution"),
        "）を得るまでに実数解析（Riemann 積分）へ移行する唯一の箇所である。**",
        "そこで**積分について**外部から持ち込む事実は次の 2 つだけであり、",
        "この表式を得るまでの他の箇所では使わない。",
      ]),
      list([
        [
          "(R1) **Heine–Cantor**：有界閉区間 ",
          math(String.raw`[a,b] \subset \mathbb{R}`),
          " 上の連続関数は一様連続である。すなわち ",
          math(String.raw`\forall\epsilon>0\ \exists\delta>0`),
          " が存在して ",
          math(String.raw`|s-t|\leq\delta \Rightarrow |g(s)-g(t)|\leq\epsilon`),
          "。",
        ],
        [
          "(R2) **連続関数の Riemann 可積分性**：",
          math(String.raw`[a,b]`),
          " 上の連続関数 ",
          math(String.raw`g`),
          " は Riemann 積分可能で、積分は区間についての加法性 ",
          math(String.raw`\int_a^c = \int_a^b + \int_b^c`),
          " と評価 ",
          math(String.raw`\left|\int_a^b g\right| \leq (b-a)\sup_{[a,b]}|g|`),
          "、および定数の積分 ",
          math(String.raw`\int_a^b \lambda\,dt = \lambda(b-a)`),
          " を満たす。",
        ],
      ]),
      paragraph([
        "**積分とは別に、被積分関数の連続性を示すところでもう 1 種類の外部事実を使う。**",
        ref("gamma_is_continuous"),
        " の証明は、",
        math(String.raw`\gamma = \mathrm{arccosh}\circ\gamma_1`),
        " を初等関数の合成として書いて連続性を導くので、次を認める必要がある。",
      ]),
      list([
        [
          "(R0) **初等関数の連続性**：",
          math(String.raw`\cos : \mathbb{R}\to\mathbb{R}`),
          " は連続、",
          math(String.raw`\sqrt{\ \cdot\ } : \mathbb{R}_{\geq 0}\to\mathbb{R}`),
          " は連続、",
          math(String.raw`\log : \mathbb{R}_{>0}\to\mathbb{R}`),
          " は連続であり、連続関数の四則（分母が 0 にならない範囲）と合成は連続である。",
        ],
      ]),
      paragraph([
        "(R0) は Riemann 積分とは独立の事実であり、(R1)(R2) には含まれない。",
        "これも有限の代数計算では代用できないので、外部事実として明示的に数える。",
        "この章で持ち込む実数解析の事実は (R0)(R1)(R2) の 3 種類でちょうど尽きている。",
      ]),
      paragraph([
        "移行が必要になる理由も明示しておく。",
        ref("partition_function_sandwich"),
        " と ",
        ref("limit_of_log_Z_in_N_row"),
        " により、鎖の長さ ",
        math(String.raw`M`),
        " を固定したままの量 ",
        math(String.raw`\frac{1}{M}\log c(M)`),
        " までは有限の行列計算で到達する。",
        "しかし ",
        math(String.raw`M \to \infty`),
        " で現れるのは ",
        math(String.raw`\frac{1}{M}\sum_{\mu=1}^{M}\gamma(\theta_\mu)`),
        " という**点の個数が増えていく有限和**であり、その極限を閉じた式で書くには",
        "「等間隔の点での値の平均が積分に収束する」という実数解析の事実が要る。",
        "ここだけは有限の代数計算では代用できない。",
      ]),
      paragraph([
        "**表式を得た後の章 E（臨界点と比熱の対数発散）では、得られた積分を微分するために",
        "外部事実を追加で持ち込む。** 追加分は ",
        ref("remark_real_analysis_escape_chapter_E"),
        " に (R3)〜(R6) として列挙してあり、この章の (R0)(R1)(R2) とは独立に管理する。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "freeenergy_001_claim_gamma1_lower_bound_all_theta",
    kind: "claim",
    origin: { path: SRC, ordinal: 3 },
    title: { tex: String.raw`\gamma_1(\theta) \geq \cosh(2K_1 - 2K_2^*) \geq 1 \quad (\forall\theta\in\mathbb{R})` },
    labels: ["gamma1_lower_bound_all_theta"],
    statement: [
      paragraph([
        ref("def_A_theta"),
        " の ",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*\cos\theta`),
        " を**すべての実数** ",
        math(String.raw`\theta`),
        " について考える（",
        ref("gamma1_geq_1"),
        " は ",
        math(String.raw`\theta = \theta_\mu`),
        " の場合の主張だが、以下の評価は任意の実数 ",
        math(String.raw`\theta`),
        " で成り立つ）。このとき",
      ]),
      displayMath(
        String.raw`\gamma_1(\theta) \geq \cosh\left(2K_1 - 2K_2^*\right) \geq 1
\qquad (\forall \theta \in \mathbb{R})`,
      ),
      paragraph([
        "とくに ",
        math(String.raw`\gamma(\theta) := \mathrm{arccosh}\left(\gamma_1(\theta)\right) \in \mathbb{R}_{\geq 0}`),
        " が**すべての実数** ",
        math(String.raw`\theta`),
        " について定まる（",
        ref("def_gamma_theta_mu"),
        " の ",
        math(String.raw`\gamma(\theta_\mu)`),
        " の拡張）。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、",
        ref("def_transfer_matrix_symbols"),
        " より ",
        math(String.raw`K_1, K_2^* > 0`),
        " なので ",
        math(String.raw`s_1 = \sinh 2K_1 > 0`),
        "、",
        math(String.raw`s_2^* = \sinh 2K_2^* > 0`),
        "、したがって ",
        math(String.raw`s_1s_2^* > 0`),
        " である。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta)
&= c_1c_2^* - s_1s_2^*\cos\theta
&&(\because\ \gamma_1(\theta)\ \text{の定義})\\
&\geq c_1c_2^* - s_1s_2^*\cdot 1
&&(\because\ \cos\theta\leq 1\ \text{と}\ s_1s_2^*>0\text{。負号つきの項なので向きが変わる})\\
&= c_1c_2^* - s_1s_2^*
&&(\because\ \mathbb{R}\ \text{では}\ 1\ \text{は積の単位元})\\
&= \cosh\left(2K_1-2K_2^*\right)
&&(\because\ \text{加法定理}\ \cosh(x-y)=\cosh x\cosh y-\sinh x\sinh y\ \text{を}\ x=2K_1,\ y=2K_2^*\ \text{に適用})\\
&\geq 1
&&(\because\ \cosh\ \text{は実数で}\ 1\ \text{以上})
\end{aligned}`,
      ),
      paragraph([
        "である（引いたブロックは ",
        ref("def_A_theta"),
        "、",
        ref("def_transfer_matrix_symbols"),
        "、",
        ref("cosh_sinh_basic_properties"),
        "）。",
        math(String.raw`\mathrm{arccosh}`),
        " は ",
        math(String.raw`[1,\infty)`),
        " 上で定義された（",
        math(String.raw`\cosh|_{[0,\infty)}`),
        " の逆写像としての）実数値関数なので ",
        math(String.raw`\gamma(\theta)`),
        " が定まり、値は ",
        math(String.raw`\mathbb{R}_{\geq 0}`),
        " に属する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-18: 式変形の書き方を統一した。加法定理の適用と cosθ≤1 による評価が" +
          "散文で継がれた 2 つの表示に分かれていたのを、γ_1(θ) から 1 までの一続きの鎖にし、" +
          "根拠を行末の (∵ …) へ揃えた。引いていた根拠（加法定理・K_1,K_2^*>0・cosh≥1）は" +
          "すべて行末と直後の参照に残した。段は増えており、減った段は無い。",
      ],
    },
  },

  {
    id: "freeenergy_002_claim_gamma_is_continuous",
    kind: "claim",
    origin: { path: SRC, ordinal: 4 },
    title: { tex: String.raw`\gamma \text{ は } \mathbb{R} \text{ 上で連続}` },
    labels: ["gamma_is_continuous"],
    statement: [
      paragraph([
        ref("gamma1_lower_bound_all_theta"),
        " の ",
        math(String.raw`\gamma : \mathbb{R} \to \mathbb{R}_{\geq 0}`),
        " は連続であり、周期 ",
        math(String.raw`2\pi`),
        " をもつ：",
        math(String.raw`\gamma(\theta + 2\pi) = \gamma(\theta)`),
        "。",
      ]),
      paragraph([
        ref("riemann_sum_to_integral"),
        " を適用するために使うのは**連続性だけ**である。",
        "周期 ",
        math(String.raw`2\pi`),
        " をもつことは ",
        math(String.raw`\gamma`),
        " の性質として併せて述べておく（積分区間を ",
        math(String.raw`[0,2\pi]`),
        " に取れば十分であることの根拠にはなるが、",
        ref("riemann_sum_to_integral"),
        " の仮定には入っていない）。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`\gamma_1`),
        " の連続性と周期性）。",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*\cos\theta`),
        " は定数と ",
        math(String.raw`\cos`),
        " の 1 次式である。",
        math(String.raw`\cos`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " 上連続（",
        ref("remark_real_analysis_escape_point"),
        " の (R0)）で周期 ",
        math(String.raw`2\pi`),
        " をもつので、",
        math(String.raw`\gamma_1`),
        " も連続で周期 ",
        math(String.raw`2\pi`),
        " をもつ。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`\mathrm{arccosh}`),
        " の連続性）。",
        math(String.raw`y \geq 1`),
        " とし、準備として",
      ]),
      displayMath(
        String.raw`u:=\log\left(y+\sqrt{y^2-1}\right)`,
      ),
      paragraph([
        "とおく。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^u
&=y+\sqrt{y^2-1}
&&\left(\because\ \log\text{ と }\exp\text{ は正の実数上で互いに逆写像}\right),\\
e^{-u}
&=\frac{1}{e^u}
&&\left(\because\ \text{指数法則 }e^{-u}\cdot e^{u}=e^{0}=1\right)\\
&=\frac{1}{y+\sqrt{y^2-1}}
&&\left(\because\ \text{上の }e^u\text{ の表示}\right)\\
&=y-\sqrt{y^2-1}
&&\left(\because\ \text{分母の有理化と }y^2-(y^2-1)=1\right),\\
\cosh u
&=\frac{e^u+e^{-u}}{2}
&&\left(\because\ \cosh\text{ の定義}\right)\\
&=\frac{y+\sqrt{y^2-1}+y-\sqrt{y^2-1}}{2}
&&\left(\because\ \text{上の }e^u,e^{-u}\text{ の表示}\right)\\
&=y
&&\left(\because\ \mathbb{R}\text{ の四則}\right).
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
u
&=\log\left(y+\sqrt{y^2-1}\right)
&&\left(\because\ u\text{ の定義}\right)\\
&\geq\log 1
&&\left(\because\ y\geq1,\ \sqrt{y^2-1}\geq0,\ \log\text{ の単調性}\right)\\
&=0
&&\left(\because\ \log 1=0\right).
\end{aligned}`,
      ),
      paragraph(["したがって、"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{arccosh}(y)
&=u
&&\left(\because\ \mathrm{arccosh}\text{ は }\cosh|_{[0,\infty)}\text{ の逆写像}\right)\\
&=\log\left(y+\sqrt{y^2-1}\right)
&&\left(\because\ u\text{ の定義}\right).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`y \mapsto y^2-1`),
        " は連続で ",
        math(String.raw`[1,\infty)`),
        " 上非負、非負実数の平方根は連続、",
        math(String.raw`y+\sqrt{y^2-1} \geq 1 > 0`),
        " 上で ",
        math(String.raw`\log`),
        " は連続である（いずれも ",
        ref("remark_real_analysis_escape_point"),
        " の (R0)）。よって合成として ",
        math(String.raw`\mathrm{arccosh}`),
        " は ",
        math(String.raw`[1,\infty)`),
        " 上連続である。",
      ]),
      paragraph([
        "Step 3。",
        ref("gamma1_lower_bound_all_theta"),
        " より ",
        math(String.raw`\gamma_1(\mathbb{R}) \subseteq [1,\infty)`),
        " なので、連続写像の合成 ",
        math(String.raw`\gamma = \mathrm{arccosh}\circ\gamma_1`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " 上連続である。周期性は ",
        math(String.raw`\gamma_1`),
        " の周期性から従う。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-18: 式変形の書き方を統一した。arccosh の表示を確かめる e^u・e^{-u}・cosh u の計算が散文中に連結されていたのを、準備と一続きの式変形へ開き、根拠を各行末の (∵ …) へ移した。連続性・周期性の論法と参照は変更していない。",
      ],
    },
  },

  {
    id: "freeenergy_003_claim_limit_in_N_row",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { tex: String.raw`N_{\mathrm{row}} \to \infty \text{ の極限}` },
    labels: ["limit_of_log_Z_in_N_row"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " を固定する。",
        ref("partition_function_sandwich"),
        " の ",
        math(String.raw`c(M)`),
        " について、極限",
      ]),
      displayMath(
        String.raw`\lim_{N_{\mathrm{row}} \to \infty}
\frac{1}{M\,N_{\mathrm{row}}}\log Z(J,J')
= \frac{1}{M}\log c(M)`,
      ),
      paragraph([
        "が存在する。すなわち、行数 ",
        math(String.raw`N_{\mathrm{row}}`),
        " についての極限は ",
        math(String.raw`c(M)`),
        " だけで決まる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`Z := Z(J,J')`),
        "、",
        math(String.raw`c := c(M)`),
        "、",
        math(String.raw`N := N_{\mathrm{row}}`),
        " と略記する。",
        ref("def_partition_function_2d_ising"),
        " より ",
        math(String.raw`Z \in \mathbb{R}_{>0}`),
        "、",
        ref("def_rayleigh_sup"),
        " より ",
        math(String.raw`c > 0`),
        " なので、両者の ",
        math(String.raw`\log`),
        " が定まる。",
      ]),
      paragraph([
        ref("partition_function_sandwich"),
        " の挟み込みから始めて、一続きに変形する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&c^{N} \leq Z \leq 2^{M}c^{N}
&&\left(\because\ \text{分配関数の挟み込み}\right)\\
\Longrightarrow\ &\log(c^{N}) \leq \log Z \leq \log(2^{M}c^{N})
&&\left(\because\ \log\text{ は }\mathbb{R}_{>0}\text{ 上で狭義単調増加}\right)\\
\Longrightarrow\ &N\log c \leq \log Z \leq \log(2^{M}c^{N})
&&\left(\because\ \log(c^{N})=N\log c\right)\\
\Longrightarrow\ &N\log c \leq \log Z \leq \log(2^{M})+\log(c^{N})
&&\left(\because\ \log(ab)=\log a+\log b\right)\\
\Longrightarrow\ &N\log c \leq \log Z \leq M\log 2+\log(c^{N})
&&\left(\because\ \log(2^{M})=M\log 2\right)\\
\Longrightarrow\ &N\log c \leq \log Z \leq M\log 2+N\log c
&&\left(\because\ \log(c^{N})=N\log c\right)\\
\Longrightarrow\ &\frac{1}{M}\log c \leq \frac{1}{MN}\log Z \leq \frac{1}{M}\log c + \frac{\log 2}{N}
&&\left(\because\ \text{各辺を }MN>0\text{ で割る。正の数で割っても不等号は保たれる}\right)\\
\Longrightarrow\ &\left|\frac{1}{MN}\log Z - \frac{1}{M}\log c\right| \leq \frac{\log 2}{N}
&&\left(\because\ \text{上下の評価が中心 }\tfrac1M\log c\text{ からの差を }\tfrac{\log 2}{N}\text{ で挟む。}\mathbb{R}\text{ の四則}\right).
\end{aligned}`,
      ),
      paragraph([
        "右辺は ",
        math(String.raw`N \to \infty`),
        " で ",
        math(String.raw`0`),
        " に収束する（",
        math(String.raw`\log 2`),
        " は ",
        math(String.raw`N`),
        " に依らない定数）。よって主張の極限が存在して値は ",
        math(String.raw`\frac1M\log c(M)`),
        " である。",
      ]),
      paragraph([
        "**この段階では実数解析へ移行していない**：使ったのは有限個の実数の不等式、",
        math(String.raw`\log`),
        " の単調性と乗法から加法への変換、および実数列 ",
        math(String.raw`(\log 2)/N \to 0`),
        " だけである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-18: 式変形の書き方を統一した。挟み込みへの log の適用・MN による割り算・中心からの差の評価が散文で継がれた 3 つの表示に分かれていたのを、一続きの含意の鎖へまとめ、根拠を各行末の (∵ …) へ移した。極限の存在の論法と参照は変更していない。",
      ],
    },
  },

  {
    id: "freeenergy_004_theorem_riemann_sum_to_integral",
    kind: "theorem",
    origin: { path: SRC, ordinal: 6 },
    title: { text: "等間隔点の平均は積分に収束する" },
    labels: ["riemann_sum_to_integral"],
    statement: [
      paragraph(["以下では、有界閉区間上の連続実関数は一様連続であることを外部前提として用いる。"]),
      paragraph(["また、有界閉区間上の連続実関数のRiemann可積分性、積分の線型性と区間加法性、定数の積分、および積分の絶対値が区間の長さと関数の絶対値の上限の積以下であることを、積分の基本性質として用いる。"]),
      paragraph([
        math(String.raw`g : \mathbb{R} \to \mathbb{R}`),
        " を連続関数とし、",
        math(String.raw`\delta \in [0,1]`),
        " を固定する（**周期性は仮定しない**）。",
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " に対して",
      ]),
      displayMath(
        String.raw`t^{(M)}_\mu := \frac{2\pi(\mu-\delta)}{M} \qquad (\mu = 1,\dots,M)`,
      ),
      paragraph(["とおく。このとき"]),
      displayMath(
        String.raw`\lim_{M\to\infty} \frac{1}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right)
= \frac{1}{2\pi}\int_{0}^{2\pi} g(t)\,dt`,
      ),
      paragraph([
        "が成り立つ。より詳しく、",
        math(String.raw`g`),
        " の ",
        math(String.raw`[0,2\pi]`),
        " 上の連続度を",
      ]),
      displayMath(
        String.raw`\omega(h) := \sup\left\{\,|g(s)-g(t)| \ \middle|\ s,t \in [0,2\pi],\ |s-t| \leq h \,\right\}`,
      ),
      paragraph(["とおくと"]),
      displayMath(
        String.raw`\left|\frac{1}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right)
- \frac{1}{2\pi}\int_{0}^{2\pi} g(t)\,dt\right|
\ \leq\ \omega\!\left(\frac{2\pi}{M}\right)`,
      ),
      paragraph([
        "であり、一様連続性 より ",
        math(String.raw`\omega(h) \to 0\ (h \to +0)`),
        " なので右辺は ",
        math(String.raw`0`),
        " に収束する。",
      ]),
      paragraph([
        "とくに ",
        math(String.raw`\delta = 0`),
        "（整数点 ",
        math(String.raw`2\pi\mu/M`),
        "）と ",
        math(String.raw`\delta = 1/2`),
        "（半整数点 ",
        math(String.raw`2\pi(\mu-\tfrac12)/M`),
        "）のどちらでも、極限は同じ値である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0（設定）。",
        math(String.raw`g`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " 上連続なので、とくに有界閉区間 ",
        math(String.raw`[0,2\pi]`),
        " 上で連続であり、積分の基本性質 より ",
        math(String.raw`\int_0^{2\pi}g(t)\,dt`),
        " が定まる。",
        math(String.raw`M`),
        " を固定し",
      ]),
      displayMath(
        String.raw`I_\mu := \left[\frac{2\pi(\mu-1)}{M},\ \frac{2\pi\mu}{M}\right] \qquad (\mu = 1,\dots,M)`,
      ),
      paragraph([
        "とおく。これらは ",
        math(String.raw`[0,2\pi]`),
        " を長さ ",
        math(String.raw`2\pi/M`),
        " の ",
        math(String.raw`M`),
        " 個の区間に分割したものであり、積分の基本性質 の区間加法性より",
      ]),
      displayMath(
        String.raw`\int_0^{2\pi} g(t)\,dt = \sum_{\mu=1}^{M}\int_{I_\mu} g(t)\,dt`,
      ),
      paragraph([
        "Step 1（代表点が区間に入ること）。",
        math(String.raw`\delta \in [0,1]`),
        " より ",
        math(String.raw`0 \leq 1-\delta \leq 1`),
        " である。",
        math(String.raw`2\pi/M > 0`),
        " を用いると、準備として",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0&\leq\frac{2\pi}{M}(1-\delta)
&&\left(\because\ 0\leq1-\delta\text{ の両辺に正の }2\pi/M\text{ を掛ける}\right),\\
\frac{2\pi}{M}(1-\delta)&\leq\frac{2\pi}{M}
&&\left(\because\ 1-\delta\leq1\text{ の両辺に正の }2\pi/M\text{ を掛ける}\right)
\end{aligned}`,
      ),
      paragraph([
        "を得る。これらを使い、代表点の両側を一続きに評価する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{2\pi(\mu-1)}{M}
&=\frac{2\pi(\mu-1)}{M}+0
&&\left(\because\ \mathbb{R}\text{ の加法単位元}\right)\\
&\leq\frac{2\pi(\mu-1)}{M}+\frac{2\pi}{M}(1-\delta)
&&\left(\because\ \text{準備の第一の不等式の両辺に }2\pi(\mu-1)/M\text{ を足す}\right)\\
&=\frac{2\pi(\mu-\delta)}{M}
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&\leq\frac{2\pi(\mu-1)}{M}+\frac{2\pi}{M}
&&\left(\because\ \text{準備の第二の不等式の両辺に }2\pi(\mu-1)/M\text{ を足す}\right)\\
&=\frac{2\pi\mu}{M}
&&\left(\because\ \mathbb{R}\text{ の四則}\right).
\end{aligned}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`t^{(M)}_\mu \in I_\mu`),
        "。したがって ",
        math(String.raw`t \in I_\mu`),
        " なら ",
        math(String.raw`\left|t - t^{(M)}_\mu\right| \leq \dfrac{2\pi}{M}`),
        "（同じ長さ ",
        math(String.raw`2\pi/M`),
        " の区間に属する 2 点の距離）。",
      ]),
      paragraph([
        "Step 2（各区間での誤差）。",
        math(String.raw`\mu`),
        " を固定する。積分の基本性質 の定数の積分より ",
        math(String.raw`\int_{I_\mu} g\!\left(t^{(M)}_\mu\right)dt = \dfrac{2\pi}{M}\,g\!\left(t^{(M)}_\mu\right)`),
        " である。各区間での誤差を一続きに評価する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\left|\int_{I_\mu}g(t)\,dt-\frac{2\pi}{M}g\!\left(t^{(M)}_\mu\right)\right|\\
={}&\left|\int_{I_\mu}g(t)\,dt-\int_{I_\mu}g\!\left(t^{(M)}_\mu\right)dt\right|
&&\left(\because\ \text{積分の基本性質 の定数の積分}\right)\\
={}&\left|\int_{I_\mu}\left(g(t)-g\!\left(t^{(M)}_\mu\right)\right)dt\right|
&&\left(\because\ \text{積分の線型性}\right)\\
\leq{}&\frac{2\pi}{M}\sup_{t\in I_\mu}\left|g(t)-g\!\left(t^{(M)}_\mu\right)\right|
&&\left(\because\ \left|\int_Ih\right|\leq |I|\sup_I|h|\right)\\
\leq{}&\frac{2\pi}{M}\omega\!\left(\frac{2\pi}{M}\right)
&&\left(\because\ \text{Step 1 と }\omega\text{ の定義}\right).
\end{aligned}`,
      ),
      paragraph(["Step 3（総和）。全区間にわたる誤差を一続きに評価する。"]),
      displayMath(
        String.raw`\begin{aligned}
&\left|\int_0^{2\pi} g(t)\,dt - \frac{2\pi}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right)\right|\\
={}&\left|\sum_{\mu=1}^{M}\int_{I_\mu}g(t)\,dt - \sum_{\mu=1}^{M}\frac{2\pi}{M}\,g\!\left(t^{(M)}_\mu\right)\right|
&&\left(\because\ \text{Step 0 の区間加法性}\right)\\
={}&\left|\sum_{\mu=1}^{M}\left(\int_{I_\mu}g(t)\,dt - \frac{2\pi}{M}\,g\!\left(t^{(M)}_\mu\right)\right)\right|
&&\left(\because\ \text{和の差は差の和}\right)\\
\leq{}&\sum_{\mu=1}^{M}\left|\int_{I_\mu}g(t)\,dt - \frac{2\pi}{M}\,g\!\left(t^{(M)}_\mu\right)\right|
&&\left(\because\ \text{三角不等式}\right)\\
\leq{}&\sum_{\mu=1}^{M}\frac{2\pi}{M}\,\omega\!\left(\frac{2\pi}{M}\right)
&&\left(\because\ \text{Step 2 の評価}\right)\\
={}&2\pi\,\omega\!\left(\frac{2\pi}{M}\right)
&&\left(\because\ \mu\text{ に依らない同一の項の }M\text{ 個の和}\right).
\end{aligned}`,
      ),
      paragraph([
        "両辺を ",
        math(String.raw`2\pi > 0`),
        " で割ると statement の評価を得る。",
      ]),
      paragraph([
        "Step 4（収束）。一様連続性 を ",
        math(String.raw`[0,2\pi]`),
        " 上の連続関数 ",
        math(String.raw`g`),
        " に適用する。任意の ",
        math(String.raw`\epsilon > 0`),
        " に対して ",
        math(String.raw`\delta_0 > 0`),
        " が存在して、",
        math(String.raw`s,t \in [0,2\pi]`),
        "、",
        math(String.raw`|s-t| \leq \delta_0`),
        " なら ",
        math(String.raw`|g(s)-g(t)| \leq \epsilon`),
        " である。これは ",
        math(String.raw`h \leq \delta_0`),
        " なら ",
        math(String.raw`\omega(h) \leq \epsilon`),
        " を意味する。",
        math(String.raw`M > 2\pi/\delta_0`),
        " なら ",
        math(String.raw`2\pi/M < \delta_0`),
        " なので ",
        math(String.raw`\omega(2\pi/M) \leq \epsilon`),
        "。",
      ]),
      paragraph([
        "したがって Step 3 の評価より、",
        math(String.raw`M > 2\pi/\delta_0`),
        " なる ",
        math(String.raw`M`),
        " について",
      ]),
      displayMath(
        String.raw`\left|\frac{1}{M}\sum_{\mu=1}^{M} g\!\left(t^{(M)}_\mu\right)
- \frac{1}{2\pi}\int_{0}^{2\pi} g(t)\,dt\right| \leq \epsilon`,
      ),
      paragraph([
        math(String.raw`\epsilon > 0`),
        " は任意だったので、主張の極限が成り立つ。",
      ]),
      paragraph([
        "（証明で ",
        math(String.raw`g`),
        " について使ったのは、有界閉区間 ",
        math(String.raw`[0,2\pi]`),
        " 上の連続性だけである。",
        math(String.raw`\delta = 0`),
        " のとき代表点 ",
        math(String.raw`t^{(M)}_M = 2\pi`),
        " は区間 ",
        math(String.raw`I_M`),
        " の右端、",
        math(String.raw`\delta = 1`),
        " のとき ",
        math(String.raw`t^{(M)}_1 = 0`),
        " は ",
        math(String.raw`I_1`),
        " の左端であり、どちらも ",
        math(String.raw`[0,2\pi]`),
        " に属するので Step 2 の評価がそのまま通る。",
        math(String.raw`g(2\pi)`),
        " と ",
        math(String.raw`g(0)`),
        " を比べる必要はどこにも生じない。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "delta ∈ [0,1] を許すことで、整数点（delta = 0、V^{(-)} セクター）と半整数点（delta = 1/2、V^{(+)} セクター）の両方を 1 つの主張で扱える。どちらでも極限が同じであることが、熱力学極限でセクターの区別が消える理由である。",
        "収束の速さは γ の連続度に支配される。臨界点（sinh 2K_1 sinh 2K_2 = 1）では γ(θ) が θ = 0 の近くで |θ| のオーダーでしか小さくならず、連続度が Lipschitz より悪くなるため収束が遅い。数値でも臨界点だけ収束が遅いことを確認している（sagemath/check/045_claim_free_energy/check_02_riemann_sum.sage）。",
      ],
    },
  },

  {
    id: "freeenergy_005_theorem_onsager_expression",
    kind: "theorem",
    origin: { path: SRC, ordinal: 7 },
    title: { text: "Onsager の自由エネルギーの表式" },
    labels: ["onsager_free_energy_expression"],
    statement: [
      paragraph([
        math(String.raw`\delta \in [0,1)`),
        " を固定し、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " について",
      ]),
      displayMath(
        String.raw`\Theta_M^{(\delta)} := \left\{\, \frac{2\pi(\mu-\delta)}{M} \ \middle|\ \mu = 1,\dots,M \,\right\},
\qquad
\Lambda^{(\delta)}_M := (2\sinh 2K_2)^{M/2}
\exp\left(\frac{1}{2}\sum_{\theta \in \Theta_M^{(\delta)}} \gamma(\theta)\right)`,
      ),
      paragraph([
        "とおく（",
        ref("eigenvalues_of_V"),
        " の ",
        math(String.raw`\Lambda_{\max}`),
        " は ",
        math(String.raw`\delta = 0`),
        " の場合にあたる）。このとき",
      ]),
      displayMath(
        String.raw`\lim_{M\to\infty}\frac{1}{M}\log \Lambda^{(\delta)}_M
= \frac{1}{2}\log\left(2\sinh 2K_2\right)
+ \frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta`,
      ),
      paragraph([
        "が成り立つ。**右辺は ",
        math(String.raw`\delta`),
        " に依らない。** ここで",
      ]),
      displayMath(
        String.raw`\gamma(\theta) = \mathrm{arccosh}\left(\cosh 2K_1\cosh 2K_2^* - \sinh 2K_1 \sinh 2K_2^*\cos\theta\right)`,
      ),
      paragraph([
        "であり（",
        ref("def_A_theta"),
        "、",
        ref("gamma1_lower_bound_all_theta"),
        "）、これが Onsager の自由エネルギーの表式である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\Lambda := \Lambda^{(\delta)}_M`),
        " の ",
        math(String.raw`\log`),
        " を取る。",
        math(String.raw`2\sinh 2K_2 > 0`),
        "（",
        math(String.raw`K_2 > 0`),
        "）と ",
        math(String.raw`\exp`),
        " の正値性より ",
        math(String.raw`\Lambda > 0`),
        " なので ",
        math(String.raw`\log\Lambda`),
        " が定まり、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\log\Lambda^{(\delta)}_M
&=\log\left(\left(2\sinh 2K_2\right)^{M/2}
\exp\left(\frac{1}{2}\sum_{\theta\in\Theta_M^{(\delta)}}\gamma(\theta)\right)\right)
&&\left(\because\ \Lambda^{(\delta)}_M\text{ の定義}\right)\\
&=\log\left(\left(2\sinh 2K_2\right)^{M/2}\right)
+\log\left(\exp\left(\frac{1}{2}\sum_{\theta\in\Theta_M^{(\delta)}}\gamma(\theta)\right)\right)
&&\left(\because\ \text{積の対数 }\log(ab)=\log a+\log b\right)\\
&=\frac{M}{2}\log\left(2\sinh 2K_2\right)
+\log\left(\exp\left(\frac{1}{2}\sum_{\theta\in\Theta_M^{(\delta)}}\gamma(\theta)\right)\right)
&&\left(\because\ \text{冪の対数 }\log(x^{r})=r\log x\right)\\
&=\frac{M}{2}\log\left(2\sinh 2K_2\right)
+ \frac{1}{2}\sum_{\theta\in\Theta_M^{(\delta)}}\gamma(\theta)
&&\left(\because\ \log(e^{y})=y\right)
\end{aligned}`,
      ),
      paragraph(["を得る。"]),
      paragraph([
        "ここで集合 ",
        math(String.raw`\Theta_M^{(\delta)}`),
        " 上の和を添字 ",
        math(String.raw`\mu`),
        " についての和に書き換える。写像 ",
        math(String.raw`\mu \mapsto \dfrac{2\pi(\mu-\delta)}{M}`),
        " は ",
        math(String.raw`\{1,\dots,M\}`),
        " 上単射である。実際、",
        math(String.raw`\mu,\nu\in\{1,\dots,M\}`),
        " と ",
        math(String.raw`\mu \neq \nu`),
        " を仮定すると、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{2\pi(\mu-\delta)}{M}-\frac{2\pi(\nu-\delta)}{M}
&=\frac{2\pi(\mu-\nu)}{M}
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&\ne0
&&\left(\because\ \frac{2\pi}{M}>0\text{ かつ }\mu-\nu\ne0\right)
\end{aligned}`,
      ),
      paragraph([
        "を得る。よって ",
        math(String.raw`\Theta_M^{(\delta)}`),
        " はちょうど ",
        math(String.raw`M`),
        " 個の元をもち、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{\theta\in\Theta_M^{(\delta)}}\gamma(\theta)
&=\sum_{\mu=1}^{M}\gamma\!\left(\frac{2\pi(\mu-\delta)}{M}\right)
&&\left(\because\ \mu\mapsto\frac{2\pi(\mu-\delta)}{M}\text{ は }\{1,\dots,M\}\text{ から }\Theta_M^{(\delta)}\text{ への全単射}\right)
\end{aligned}`,
      ),
      paragraph([
        "を得る。また、",
        math(String.raw`M > 0`),
        " なので、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M}\log\Lambda^{(\delta)}_M
&=\frac{1}{M}\left(
  \frac{M}{2}\log\left(2\sinh 2K_2\right)
  +\frac{1}{2}\sum_{\theta\in\Theta_M^{(\delta)}}\gamma(\theta)
\right)
&&\left(\because\ \text{上で得た }\log\Lambda^{(\delta)}_M\text{ の表示を代入}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{2M}\sum_{\theta\in\Theta_M^{(\delta)}}\gamma(\theta)
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{2M}\sum_{\mu=1}^{M}\gamma\!\left(\frac{2\pi(\mu-\delta)}{M}\right)
&&\left(\because\ \text{上で得た添字の取り替え}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{2}\cdot\frac{1}{M}\sum_{\mu=1}^{M}\gamma\!\left(\frac{2\pi(\mu-\delta)}{M}\right)
&&\left(\because\ \mathbb{R}\text{ の四則}\right)
\end{aligned}`,
      ),
      paragraph([
        "第 1 項は ",
        math(String.raw`M`),
        " に依らない定数である。第 2 項について、",
        ref("gamma_is_continuous"),
        " より ",
        math(String.raw`\gamma`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " 上連続であり、",
        math(String.raw`\delta \in [0,1) \subset [0,1]`),
        " なので、",
        ref("riemann_sum_to_integral"),
        " を ",
        math(String.raw`g = \gamma`),
        " として適用でき",
      ]),
      displayMath(
        String.raw`\frac{1}{M}\sum_{\mu=1}^{M}\gamma\!\left(\frac{2\pi(\mu-\delta)}{M}\right)
\ \xrightarrow[M\to\infty]{}\ \frac{1}{2\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta`,
      ),
      paragraph([
        "を得る。よって、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\lim_{M\to\infty}\frac{1}{M}\log\Lambda^{(\delta)}_M
&=\lim_{M\to\infty}\left(
  \frac{1}{2}\log\left(2\sinh 2K_2\right)
  +\frac{1}{2}\cdot\frac{1}{M}\sum_{\mu=1}^{M}\gamma\!\left(\frac{2\pi(\mu-\delta)}{M}\right)
\right)
&&\left(\because\ \text{上で得た }\frac{1}{M}\log\Lambda^{(\delta)}_M\text{ の表示を代入}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\lim_{M\to\infty}\left(\frac{1}{2}\cdot\frac{1}{M}\sum_{\mu=1}^{M}\gamma\!\left(\frac{2\pi(\mu-\delta)}{M}\right)\right)
&&\left(\because\ \text{収束する実数列に定数を加えた列は収束し、極限に定数が加わる}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{2}\cdot\lim_{M\to\infty}\frac{1}{M}\sum_{\mu=1}^{M}\gamma\!\left(\frac{2\pi(\mu-\delta)}{M}\right)
&&\left(\because\ \text{収束する実数列の定数倍は収束し、極限が定数倍になる}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{2}\cdot\frac{1}{2\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta
&&\left(\because\ \text{上の収束（等間隔点の平均は積分に収束する）}\right)\\
&=\frac{1}{2}\log\left(2\sinh 2K_2\right)
+\frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta
&&\left(\because\ \mathbb{R}\text{ の四則 }\frac12\cdot\frac1{2\pi}=\frac1{4\pi}\right)
\end{aligned}`,
      ),
      paragraph([
        "が成り立ち、主張の式を得る（第 2 行・第 3 行の極限法則が適用できるのは、第 4 行で引いた ",
        ref("riemann_sum_to_integral"),
        " の収束が第 2 項の収束を与えるからである）。",
        ref("riemann_sum_to_integral"),
        " の極限が ",
        math(String.raw`\delta`),
        " に依らないので、右辺も ",
        math(String.raw`\delta`),
        " に依らない。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "freeenergy_006_remark_remaining_input",
    kind: "remark",
    origin: { path: SRC, ordinal: 8 },
    title: { text: "厳密解へ残っている入力：偶セクターの固有値" },
    labels: ["remark_remaining_input_even_sector"],
    statement: [
      paragraph([
        "ここまでで得られたものを並べると、分配関数から自由エネルギーまでの経路は次のようになっている。",
      ]),
      list([
        [
          ref("partition_function_in_pauli_form"),
          "：",
          math(String.raw`Z = \mathrm{tr}\!\left((V_1V_2)^{N_{\mathrm{row}}}\right)`),
        ],
        [
          ref("partition_function_sandwich"),
          "：",
          math(String.raw`c(M)^{N_{\mathrm{row}}} \leq Z \leq 2^{M}c(M)^{N_{\mathrm{row}}}`),
        ],
        [
          ref("limit_of_log_Z_in_N_row"),
          "：",
          math(String.raw`\dfrac{1}{MN_{\mathrm{row}}}\log Z \to \dfrac{1}{M}\log c(M)`),
        ],
        [
          ref("sector_decomposition_of_rayleigh_sup"),
          "：",
          math(String.raw`c(M) = \max\left(c_+(M),c_-(M)\right)`),
        ],
        [
          ref("onsager_free_energy_expression"),
          "：",
          math(String.raw`\dfrac{1}{M}\log\Lambda^{(\delta)}_M \to \dfrac12\log(2\sinh 2K_2) + \dfrac1{4\pi}\displaystyle\int_0^{2\pi}\gamma`),
          "（",
          math(String.raw`\delta`),
          " に依らない）",
        ],
      ]),
      paragraph([
        "**残っている入力は 1 つだけである**（",
        "これは 013 章から 018 章で証明され、",
        ref("c_plus_equals_Lambda_half_integer"),
        " で解消された。最終的な結論は ",
        ref("onsager_exact_solution"),
        "）：",
        math(String.raw`c_+(M)`),
        "（",
        math(String.raw`\varepsilon`),
        " の固有値 ",
        math(String.raw`+1`),
        " のセクターでの上限）が ",
        math(String.raw`\Lambda^{(1/2)}_M`),
        " に等しいこと、すなわち ",
        math(String.raw`V^{(+)}`),
        " の固有値が**半整数運動量** ",
        math(String.raw`2\pi(\mu-\tfrac12)/M`),
        " で与えられることである。",
      ]),
      paragraph([
        "本文にこれが無い理由は具体的である。",
        ref("def_hatZ_hatY"),
        " の ",
        math(String.raw`\hat{Z}_\mu^{(\pm)}`),
        " は第 1 項に符号 ",
        math(String.raw`\mp`),
        " を持つ。",
        ref("commutator_of_H_and_Z_Y"),
        " の (C) ",
        math(String.raw`[H_2, \hat{Z}_\mu^{(-)}] = -2\hat{Y}_\mu`),
        " は、",
        math(String.raw`[H_2, Z_j] = -2Y_j`),
        " を各項に適用して係数どうしを比べる形で示されるが、",
        math(String.raw`\hat{Z}_\mu^{(+)}`),
        " では第 1 項の符号だけが反転しているため右辺が ",
        math(String.raw`-2\hat{Y}_\mu`),
        " にならない。",
        "したがって 008 章以降の議論は ",
        math(String.raw`\hat{Z}_\mu^{(-)}`),
        "（整数運動量）に対してのみ成立しており、",
        math(String.raw`V^{(+)}`),
        " には適用できない。",
      ]),
      paragraph([
        "偶セクターを扱うには、符号を第 1 項に置く代わりに**位相に繰り込んだ**",
      ]),
      displayMath(
        String.raw`\check{Z}_\mu := \sum_{j=1}^{M} Z_j\,e^{-i j \tilde\theta_\mu},\qquad
\check{Y}_\mu := \sum_{j=1}^{M} Y_j\,e^{-i j \tilde\theta_\mu},\qquad
\tilde\theta_\mu := \frac{2\pi\left(\mu-\tfrac12\right)}{M}`,
      ),
      paragraph([
        "を用いればよい。この ",
        math(String.raw`\check{Z}, \check{Y}`),
        " については ",
        ref("commutator_of_H_and_Z_Y"),
        " の (A)〜(D) が ",
        math(String.raw`H_1^{(+)}, H_2`),
        " に対して成り立ち（",
        ref("commutator_of_H_and_check_Z_Y"),
        "）、反交換関係の対は ",
        math(String.raw`\nu = M+1-\mu`),
        " になる（",
        ref("anticommutator_of_check_Z_Y"),
        "）。",
        "**この道筋は 013 章から 018 章で本文として実行済みであり、以降の証明の根拠として使ってよい。**",
        "到達点は ",
        ref("c_plus_equals_Lambda_half_integer"),
        " の ",
        math(String.raw`c_+(M) = \Lambda^{(1/2)}_M`),
        " と ",
        ref("onsager_exact_solution"),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "V^{(+)} の固有値が半整数運動量で与えられることは M=2,3,4 で数値的に確認済み（相対誤差 1e-14 以下、整数運動量では 0.5〜2.4 の相対差で明確に不一致）。また最大固有値が (+) セクターで達成されることも M=2,3,4 で確認した（W の成分がすべて正なので Perron–Frobenius から期待される通り）。これらは sagemath/check/044_claim_max_eigenvalue/ と 045_claim_free_energy/ に記録した。",
      ],
    },
  },
]);
