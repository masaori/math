import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

/**
 * 部「固有値問題」の章「A(θ̃_μ) の対角化と V^{(+)} の指数表示」。章立て（`tools/chapter-plan.ts`）で
 * この章に割り当てた項を、章の中の依存順に並べる。章の最後は、この章のゴールの式を主張するブロックである。
 */

export default defineBlocks([
  {
    id: "heading_chapter_diagonalization_and_exponential_form",
    kind: "heading",
    level: 2,
    title: { tex: String.raw`A(\tilde\theta_\mu)\text{ の対角化と }V^{(+)}\text{ の指数表示}` },
    labels: [],
  },
  {
    id: "transfer_matrix_000h2_definition_arccosh",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "逆双曲線余弦" },
    labels: ["def_arccosh"],
    statement: [
      paragraph([
        math(String.raw`y \in \mathbb{R}`),
        " が ",
        math(String.raw`y \ge 1`),
        " を満たすとき、",
      ]),
      displayMath(
        String.raw`\mathrm{arccosh}(y) := \log\!\left(y + \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})}\right) \in \mathbb{R}`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`\sqrt{\cdot}^{(\mathbb{R}_{\ge 0})}`),
        " は ",
        ref("definition_of_sqrt_r_positive"),
        "、",
        math(String.raw`\log`),
        " は ",
        ref("def_real_logarithm_positive"),
        " である。右辺が定まることは次による。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
y \ge 1
&\Longrightarrow y^2 - 1 \ge 0
   &&(\because\ y \ge 1 > 0 \text{ より } y^2 \ge 1) \\
y \ge 1 \ \land\ \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})} \ge 0
&\Longrightarrow y + \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})} \ge 1 > 0
   &&(\because\ \text{実数の順序と加法})
\end{aligned}`,
      ),
      paragraph([
        "すなわち平方根の中身は非負であり、",
        math(String.raw`\log`),
        " の引数は正である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "それまで本文は arccosh を「cosh|_[0,∞) の逆写像」と呼ぶだけで定義を置いていなかった。逆写像として定義すると cosh|_[0,∞) が [1,∞) への全単射であることを先に示す必要があるので、log と非負平方根による式で定義し、逆写像であることを arccosh_properties で示す形にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_000h3_claim_arccosh_properties",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "逆双曲線余弦は非負側の双曲線余弦の逆" },
    labels: ["arccosh_properties"],
    statement: [
      paragraph([
        math(String.raw`y \in \mathbb{R}`),
        "、",
        math(String.raw`y \ge 1`),
        " とする。",
        ref("def_arccosh"),
        " の ",
        math(String.raw`\mathrm{arccosh}`),
        " と ",
        ref("def_cosh_sinh"),
        " の ",
        math(String.raw`\cosh`),
        " について次が成り立つ。",
      ]),
      list([
        ["(1) ", math(String.raw`\mathrm{arccosh}(y) \ge 0`), "。"],
        ["(2) ", math(String.raw`\cosh\!\left(\mathrm{arccosh}(y)\right) = y`), "。"],
        [
          "(3) ",
          math(String.raw`t \in \mathbb{R}`),
          " が ",
          math(String.raw`t \ge 0`),
          " かつ ",
          math(String.raw`\cosh t = y`),
          " を満たすなら ",
          math(String.raw`t = \mathrm{arccosh}(y)`),
          "。",
        ],
        ["(4) ", math(String.raw`\mathrm{arccosh}(1) = 0`), "。"],
      ]),
    ],
    proof: [
      paragraph([
        "準備。証明の中だけの記号として ",
        math(String.raw`r := \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})} \in \mathbb{R}`),
        "、",
        math(String.raw`u := \mathrm{arccosh}(y) \in \mathbb{R}`),
        " とおく（",
        math(String.raw`y^2 - 1 \ge 0`),
        " は ",
        ref("def_arccosh"),
        " で示した）。（実対数と平方根による ",
        math(String.raw`\mathbb R`),
        " 脱出）",
        math(String.raw`r`),
        " は ",
        ref("sqrt_nonnegative_existence_uniqueness"),
        " の存在（",
        math(String.raw`\mathbb{R}`),
        " の完備性）で定まる実数、",
        math(String.raw`u`),
        " と以下の ",
        math(String.raw`\exp`),
        "・",
        math(String.raw`\log`),
        "・",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値は実数の指数関数と実対数（",
        ref("def_real_logarithm_positive"),
        "）の値であり、",
        math(String.raw`\mathbb{Q}`),
        " には一般に収まらない（",
        math(String.raw`y`),
        " によっては収まる）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&r \ge 0 \ \land\ r^2 = y^2 - 1
   &&(\because\ \blkref{definition_of_sqrt_r_positive}) \\
&u = \log(y + r)
   &&(\because\ \blkref{def_arccosh}) \\
&y + r \ge 1
   &&(\because\ \blkref{def_arccosh})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\log 1
&= \log(\exp(0))
   &&(\because\ \blkref{scalar_exp_zero}) \\
&= 0
   &&(\because\ \blkref{def_real_logarithm_positive}\text{ の }\log(\exp x) = x)
\end{aligned}`,
      ),
      paragraph([
        "(1) の証明。",
        math(String.raw`y + r \ge 1`),
        " なので ",
        math(String.raw`y + r > 1`),
        " か ",
        math(String.raw`y + r = 1`),
        " である。",
        math(String.raw`y + r > 1`),
        " の場合。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{arccosh}(y)
&= \log(y + r)
   &&(\because\ \blkref{def_arccosh}) \\
&> \log 1
   &&(\because\ y + r > 1 \text{ と } \blkref{real_log_strictly_increasing}) \\
&= 0
   &&(\because\ \text{準備の }\log 1 = 0)
\end{aligned}`,
      ),
      paragraph([math(String.raw`y + r = 1`), " の場合。"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{arccosh}(y)
&= \log(y + r)
   &&(\because\ \blkref{def_arccosh}) \\
&= \log 1
   &&(\because\ y + r = 1) \\
&= 0
   &&(\because\ \text{準備の }\log 1 = 0)
\end{aligned}`,
      ),
      paragraph([
        "いずれの場合も ",
        math(String.raw`\mathrm{arccosh}(y) \ge 0`),
        " である。",
      ]),
      paragraph(["(2) の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
\exp(u)
&= \exp(\log(y + r))
   &&(\because\ u = \log(y + r)) \\
&= y + r
   &&(\because\ \blkref{def_real_logarithm_positive}\text{ の }\exp(\log z) = z)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
y^2 - r^2
&= y^2 - (y^2 - 1)
   &&(\because\ r^2 = y^2 - 1) \\
&= 1
   &&(\because\ \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\exp(-u)
&= \exp(-u)\,(y^2 - r^2)
   &&(\because\ y^2 - r^2 = 1) \\
&= \exp(-u)\,\bigl((y + r)(y - r)\bigr)
   &&(\because\ \text{和と差の積}) \\
&= \exp(-u)\,\bigl(\exp(u)\,(y - r)\bigr)
   &&(\because\ \exp(u) = y + r) \\
&= \bigl(\exp(-u)\exp(u)\bigr)\,(y - r)
   &&(\because\ \mathbb{R} \text{ の積の結合律}) \\
&= \exp(-u + u)\,(y - r)
   &&(\because\ \blkref{scalar_exp_product}) \\
&= \exp(0)\,(y - r)
   &&(\because\ -u + u = 0) \\
&= 1 \cdot (y - r)
   &&(\because\ \blkref{scalar_exp_zero}) \\
&= y - r
   &&(\because\ 1 \text{ は } \mathbb{R} \text{ の積の単位元})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\cosh\!\left(\mathrm{arccosh}(y)\right)
&= \cosh(u)
   &&(\because\ u \text{ の定め方}) \\
&= \frac{\exp(u) + \exp(-u)}{2}
   &&(\because\ \blkref{def_cosh_sinh}) \\
&= \frac{(y + r) + \exp(-u)}{2}
   &&(\because\ \exp(u) = y + r) \\
&= \frac{(y + r) + (y - r)}{2}
   &&(\because\ \exp(-u) = y - r) \\
&= \frac{2y}{2}
   &&(\because\ \mathbb{R} \text{ の加法}) \\
&= y
   &&(\because\ \text{約分})
\end{aligned}`,
      ),
      paragraph([
        "(3) の証明。",
        math(String.raw`t \in \mathbb{R}`),
        "、",
        math(String.raw`t \ge 0`),
        "、",
        math(String.raw`\cosh t = y`),
        " とする。まず ",
        math(String.raw`\sinh t \ge 0`),
        " を示す。",
        math(String.raw`t > 0`),
        " の場合。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\sinh t > 0
   &&(\because\ t > 0 \text{ と } \blkref{cosh_sinh_basic_properties}\text{ (3)})
\end{aligned}`,
      ),
      paragraph([math(String.raw`t = 0`), " の場合。"]),
      displayMath(
        String.raw`\begin{aligned}
\sinh 0
&= \frac{\exp(0) - \exp(-0)}{2}
   &&(\because\ \blkref{def_cosh_sinh}) \\
&= \frac{\exp(0) - \exp(0)}{2}
   &&(\because\ -0 = 0) \\
&= \frac{1 - 1}{2}
   &&(\because\ \blkref{scalar_exp_zero}) \\
&= 0
   &&(\because\ \mathbb{R} \text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "いずれの場合も ",
        math(String.raw`\sinh t \ge 0`),
        " である。次に",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\sinh t)^2
&= (\cosh t)^2 - 1
   &&(\because\ \blkref{cosh_sinh_basic_properties}\text{ (2) と移項}) \\
&= y^2 - 1
   &&(\because\ \cosh t = y)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sinh t
&= \sqrt{y^2-1}^{(\mathbb{R}_{\ge 0})}
   &&(\because\ \sinh t \ge 0\text{、}(\sinh t)^2 = y^2 - 1 \text{ と } \blkref{definition_of_sqrt_r_positive}\text{（}\blkref{sqrt_nonnegative_existence_uniqueness}\text{ の一意性）}) \\
&= r
   &&(\because\ r \text{ の定め方})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
t
&= \log(\exp(t))
   &&(\because\ \blkref{def_real_logarithm_positive}\text{ の }\log(\exp x) = x) \\
&= \log(\cosh t + \sinh t)
   &&(\because\ \blkref{cosh_sinh_basic_properties}\text{ (1)}) \\
&= \log(y + \sinh t)
   &&(\because\ \cosh t = y) \\
&= \log(y + r)
   &&(\because\ \sinh t = r) \\
&= \mathrm{arccosh}(y)
   &&(\because\ \blkref{def_arccosh})
\end{aligned}`,
      ),
      paragraph(["(4) の証明。"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{arccosh}(1)
&= \log\!\left(1 + \sqrt{1^2-1}^{(\mathbb{R}_{\ge 0})}\right)
   &&(\because\ \blkref{def_arccosh}) \\
&= \log\!\left(1 + \sqrt{1-1}^{(\mathbb{R}_{\ge 0})}\right)
   &&\bigl(\because\ \blkref{power_of_real_one_is_one}\ \text{の}\ m \to 2\bigr) \\
&= \log\!\left(1 + \sqrt{0}^{(\mathbb{R}_{\ge 0})}\right)
   &&\bigl(\because\ \mathbb{R}\ \text{で}\ a - a = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）の}\ a \to 1\bigr) \\
&= \log(1 + 0)
   &&\bigl(\because\ \blkref{sqrt_of_real_zero_is_zero}\bigr) \\
&= \log 1
   &&(\because\ 1 + 0 = 1) \\
&= 0
   &&(\because\ \text{準備の }\log 1 = 0)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: (4) の鎖の「1^2 − 1 = 0」1 行（1^2 = 1・1 − 1 = 0 の 2 事実）を power_of_real_one_is_one（m → 2）と ℝ で a − a = 0（a → 1）の 2 行に割り、次の行 √0 = 0（0 ≥ 0・0^2 = 0・一意性を 1 行で使っていた）を sqrt_of_real_zero_is_zero の参照にした（relation_of_gamma_2_theta_tilde の準備の第五の cos(π/2) の鎖と同じ書き方）。値と主張は不変。",
        "arccosh を式で定義したことに伴い、本文が使っている性質（非負・cosh との合成・非負側での一意性・arccosh(1)=0）を主張として置いた。",
        "2026-11-02: SageMath の検算（sagemath/check/arccosh_properties/）を付けるにあたり、証明を直した。log 1 = 0 を「def_real_logarithm_positive の証明で示した」と引いていたが、その定義に証明は無いので、scalar_exp_zero と log(exp x) = x からの鎖を準備に置いた。exp(-u)exp(u) = exp(0) の行を積の結合律・指数法則・-u+u=0 の三行に、cosh の鎖の「上の 2 式」を二行に、(3) の二つの代入と (4) の 1^2-1=0・√0=0 を一行ずつに分けた。(1) と (3) の sinh t ≥ 0 を場合分けの鎖に、√ の一意性を散文から (∵) 付きの式に移し、実対数と平方根による ℝ 脱出を準備に書いた。主張は変えていない。",
      ],
    },
  },
  {
    id: "transfer_matrix_015_claim_Z_Y_generate_algebra",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ", ordinal: 15 },
    title: {
      text: "Z, Y から和・スカラー倍・積だけで 2^M 次の複素行列がすべて得られる",
    },
    labels: ["Z_Y_generate_algebra"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        "（004 章冒頭の記号の定義）で定義された ",
        math(String.raw`Z_1,\dots,Z_{M_{\mathrm{col}}}, Y_1,\dots,Y_{M_{\mathrm{col}}} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について、集合 ",
        math(String.raw`S := \{Z_1,\dots,Z_{M_{\mathrm{col}}}, Y_1,\dots,Y_{M_{\mathrm{col}}}\}`),
        " を考える（",
        ref("def_kronecker"),
        " の同一視により ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}) = \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " であり、",
        math(String.raw`S`),
        " の元はいずれも ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 次の複素行列である）。",
      ]),
      paragraph([
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の部分集合 ",
        math(String.raw`T`),
        " が「閉じている」とは、次の 4 条件を満たすことをいう。",
      ]),
      list([
        [
          "(i) ",
          math(String.raw`S \subseteq T`),
          "、すなわち ",
          math(String.raw`Z_1,\dots,Z_{M_{\mathrm{col}}},Y_1,\dots,Y_{M_{\mathrm{col}}} \in T`),
          "。",
        ],
        [
          "(ii) ",
          math(String.raw`I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} \in T`),
          "（単位行列を含む）。",
        ],
        [
          "(iii) ",
          math(String.raw`A, B \in T`),
          " ならば ",
          math(String.raw`A + B \in T`),
          "、および ",
          math(String.raw`c \in \mathbb{C}`),
          " について ",
          math(String.raw`cA \in T`),
          "（和とスカラー倍で閉じる）。",
        ],
        [
          "(iv) ",
          math(String.raw`A, B \in T`),
          " ならば ",
          math(String.raw`AB \in T`),
          "（行列の積で閉じる）。",
        ],
      ]),
      paragraph([
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " 自身は閉じているからそのような ",
        math(String.raw`T`),
        " は少なくとも 1 つ存在し、閉じている部分集合すべての共通部分もまた (i)〜(iv) を満たす",
        "（共通部分の元は各 ",
        math(String.raw`T`),
        " に属するので、和・スカラー倍・積も各 ",
        math(String.raw`T`),
        " に属し、したがって共通部分に属する）。よって、閉じている部分集合のうち最小のものが存在する。それを ",
        math(String.raw`\mathcal{A}`),
        " とおく。",
      ]),
      paragraph([
        "このとき ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " である。すなわち、",
        math(String.raw`Z_1,\dots,Z_{M_{\mathrm{col}}},Y_1,\dots,Y_{M_{\mathrm{col}}}`),
        " と単位行列から出発して、和・スカラー倍・行列の積を有限回繰り返すだけで ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 次の複素行列がすべて得られる。",
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`\sigma^x, \sigma^y, \sigma^z \in \mathrm{Mat}(2,\mathbb{C})`),
        " を標準的な Pauli 行列 ",
        math(String.raw`\sigma^x=\begin{pmatrix}0&1\\1&0\end{pmatrix}`),
        "、",
        math(String.raw`\sigma^y=\begin{pmatrix}0&-i\\i&0\end{pmatrix}`),
        "、",
        math(String.raw`\sigma^z=\begin{pmatrix}1&0\\0&-1\end{pmatrix}`),
        " とする（",
        math(String.raw`i \in \mathbb{C}`),
        " は ",
        ref("def_imaginary_unit"),
        " の虚数単位）。",
        math(String.raw`\sigma_k^x, \sigma_k^y, \sigma_k^z`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " のとおり、第 ",
        math(String.raw`k`),
        " 番目の因子（サイト）のみが対応する Pauli 行列で、他の因子はすべて ",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " であるものとする。",
      ]),
      paragraph(["Step 1: 単一サイトの Pauli 行列の積公式。"]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^x
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix} \quad (\because \sigma^x \text{ の定義}) \\
&= \begin{pmatrix}1&0\\0&1\end{pmatrix} \quad (\because \text{行列の積の成分計算}) \\
&= I_{\mathrm{Mat}(2,\mathbb{C})} \quad (\because \text{単位行列の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^z
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix} \quad (\because \sigma^y,\ \sigma^z \text{ の定義}) \\
&= \begin{pmatrix}0&i\\i&0\end{pmatrix} \quad (\because \text{行列の積の成分計算}) \\
&= i\begin{pmatrix}0&1\\1&0\end{pmatrix} \quad (\because \text{スカラー倍の成分計算}) \\
&= i\,\sigma^x \quad (\because \sigma^x \text{ の定義})
\end{aligned}`,
      ),
      paragraph(["第 2 式から ", math(String.raw`\sigma^x`), " を書き直す。"]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x
&= 1\cdot\sigma^x \quad (\because 1 \text{ は積の単位元}) \\
&= ((-i)\,i)\,\sigma^x \quad (\because (-i)\,i = 1) \\
&= -i\,(i\,\sigma^x) \quad (\because \text{スカラー倍の結合則}) \\
&= -i\,\sigma^y\sigma^z \quad (\because \text{第 2 式 } \sigma^y\sigma^z = i\,\sigma^x)
\end{aligned}`,
      ),
      paragraph([
        "これらをクロネッカー積へ持ち上げる。",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の積は各因子ごとの積であり ",
        math(String.raw`(A_1\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}})(B_1\boxtimes\cdots\boxtimes B_{M_{\mathrm{col}}}) = (A_1 B_1)\boxtimes\cdots\boxtimes(A_{M_{\mathrm{col}}} B_{M_{\mathrm{col}}})`),
        "（",
        ref("kronecker_product_rule"),
        " (1)）。第 ",
        math(String.raw`k`),
        " 因子のみが非自明な ",
        math(String.raw`\sigma_k^a`),
        " どうしの積は（",
        math(String.raw`I:=I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_k^a \sigma_k^b
&= (I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes I)(I\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{k\text{th}}\boxtimes\cdots\boxtimes I) \quad (\because \sigma_k^a,\ \sigma_k^b \text{ の定義の代入}) \\
&= (II)\boxtimes\cdots\boxtimes\overbrace{(\sigma^a\sigma^b)}^{k\text{th}}\boxtimes\cdots\boxtimes(II) \quad (\because \text{クロネッカー積の積の規則}) \\
&= I\boxtimes\cdots\boxtimes\overbrace{(\sigma^a\sigma^b)}^{k\text{th}}\boxtimes\cdots\boxtimes I \quad (\because II=I)
\end{aligned}`,
      ),
      paragraph([
        "これより ",
        math(String.raw`\sigma_k^x\sigma_k^x = I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "、",
        math(String.raw`\sigma_k^x = -i\,\sigma_k^y\sigma_k^z`),
        " を得る。また異なるサイト ",
        math(String.raw`k\neq l`),
        " の ",
        math(String.raw`\sigma_k^a, \sigma_l^b`),
        " は可換である（",
        math(String.raw`k<l`),
        " として）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_k^a \sigma_l^b
&= (I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes I)(I\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{l\text{th}}\boxtimes\cdots\boxtimes I) \quad (\because \sigma_k^a,\ \sigma_l^b \text{ の定義の代入}) \\
&= I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{l\text{th}}\boxtimes\cdots\boxtimes I \quad (\because \text{クロネッカー積の積の規則}) \\
&= (I\boxtimes\cdots\boxtimes\overbrace{\sigma^b}^{l\text{th}}\boxtimes\cdots\boxtimes I)(I\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes I) \quad (\because \text{クロネッカー積の積の規則}) \\
&= \sigma_l^b \sigma_k^a \quad (\because \sigma_l^b, \sigma_k^a \text{ の定義（第 } l \text{ 因子・第 } k \text{ 因子のみが非自明）})
\end{aligned}`,
      ),
      paragraph([
        "Step 2: ",
        math(String.raw`\mathcal{A}`),
        " が各 ",
        math(String.raw`\sigma_k^x, \sigma_k^y, \sigma_k^z`),
        " を含むこと。各 ",
        math(String.raw`m`),
        " について「",
        math(String.raw`\sigma_1^x,\dots,\sigma_{m-1}^x \in \mathcal{A}`),
        "」を仮定とする ",
        math(String.raw`m`),
        " に関する帰納法で示す。",
        math(String.raw`m=1`),
        " のとき ",
        math(String.raw`\sigma_1^z=Z_1\in\mathcal{A}`),
        "、",
        math(String.raw`\sigma_1^y=Y_1\in\mathcal{A}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_1^x
&= -i\,\sigma_1^y\sigma_1^z \quad (\because \text{Step 1 の } \sigma_k^x = -i\,\sigma_k^y\sigma_k^z \text{ を } k=1 \text{ に取る}) \\
&= -i\,Y_1 Z_1 \quad (\because \sigma_1^y = Y_1, \ \sigma_1^z = Z_1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`Y_1, Z_1\in\mathcal{A}`),
        " かつ ",
        math(String.raw`\mathcal{A}`),
        " は積とスカラー倍について閉じるから ",
        math(String.raw`\sigma_1^x\in\mathcal{A}`),
        "。",
      ]),
      paragraph([
        math(String.raw`m\geq 2`),
        " とし ",
        math(String.raw`\sigma_1^x,\dots,\sigma_{m-1}^x\in\mathcal{A}`),
        " を仮定する。",
        math(String.raw`P_{m-1}:=\sigma_1^x\sigma_2^x\cdots\sigma_{m-1}^x`),
        " とおくと ",
        math(String.raw`P_{m-1}\in\mathcal{A}`),
        "（",
        math(String.raw`m=1`),
        " では空積 ",
        math(String.raw`P_0:=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "）。異サイトの可換性と ",
        math(String.raw`\sigma_k^x\sigma_k^x=I`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{m-1}P_{m-1}
&= (\sigma_1^x\cdots\sigma_{m-1}^x)(\sigma_1^x\cdots\sigma_{m-1}^x) \quad (\because P_{m-1} \text{ の定義}) \\
&= (\sigma_1^x\sigma_1^x)(\sigma_2^x\sigma_2^x)\cdots(\sigma_{m-1}^x\sigma_{m-1}^x) \quad (\because \text{異サイトの可換性}) \\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} \quad (\because \sigma_k^x\sigma_k^x=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})})
\end{aligned}`,
      ),
      paragraph([
        "ゆえに ",
        math(String.raw`P_{m-1}`),
        " は可逆で ",
        math(String.raw`P_{m-1}^{-1}=P_{m-1}\in\mathcal{A}`),
        "。定義より ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z = P_{m-1}\sigma_m^z`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{m-1}Z_m
&= P_{m-1}P_{m-1}\sigma_m^z \quad (\because Z_m = P_{m-1}\sigma_m^z) \\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\sigma_m^z \quad (\because P_{m-1}P_{m-1}=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}) \\
&= \sigma_m^z \quad (\because I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} \text{ は積の単位元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`P_{m-1}, Z_m\in\mathcal{A}`),
        " かつ ",
        math(String.raw`\mathcal{A}`),
        " は積について閉じるから ",
        math(String.raw`\sigma_m^z = P_{m-1}Z_m\in\mathcal{A}`),
        "。",
        math(String.raw`\sigma_m^y`),
        " についても同じ形の鎖が書ける。定義より ",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y = P_{m-1}\sigma_m^y`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{m-1}Y_m
&= P_{m-1}P_{m-1}\sigma_m^y \quad (\because Y_m = P_{m-1}\sigma_m^y) \\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\sigma_m^y \quad (\because P_{m-1}P_{m-1}=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}) \\
&= \sigma_m^y \quad (\because I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})} \text{ は積の単位元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`P_{m-1}, Y_m\in\mathcal{A}`),
        " かつ ",
        math(String.raw`\mathcal{A}`),
        " は積について閉じるから ",
        math(String.raw`\sigma_m^y = P_{m-1}Y_m\in\mathcal{A}`),
        "。さらに Step 1 より ",
        math(String.raw`\sigma_m^x = -i\,\sigma_m^y\sigma_m^z`),
        " であり、",
        math(String.raw`\mathcal{A}`),
        " は積とスカラー倍について閉じるから ",
        math(String.raw`\sigma_m^x\in\mathcal{A}`),
        "。よって ",
        math(String.raw`\sigma_m^x,\sigma_m^y,\sigma_m^z\in\mathcal{A}`),
        " が示され、帰納法により すべての ",
        math(String.raw`k\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について ",
        math(String.raw`\sigma_k^x,\sigma_k^y,\sigma_k^z\in\mathcal{A}`),
        "。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "。まず ",
        math(String.raw`\mathcal{B}:=\{I_{\mathrm{Mat}(2,\mathbb{C})}, \sigma^x, \sigma^y, \sigma^z\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " 上の基底である。実際、任意の ",
        math(String.raw`A=\begin{pmatrix}a_{11}&a_{12}\\a_{21}&a_{22}\end{pmatrix}`),
        " に対し",
      ]),
      displayMath(
        String.raw`A = \frac{a_{11}+a_{22}}{2}I_{\mathrm{Mat}(2,\mathbb{C})} + \frac{a_{12}+a_{21}}{2}\sigma^x + \frac{i(a_{12}-a_{21})}{2}\sigma^y + \frac{a_{11}-a_{22}}{2}\sigma^z \quad (\because \text{成分比較})`,
      ),
      paragraph([
        " が成り立つので ",
        math(String.raw`\mathcal{B}`),
        " は張り、",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2,\mathbb{C})=4=\#\mathcal{B}`),
        " より基底である。次に ",
        math(String.raw`\mathcal{B}^{\boxtimes M_{\mathrm{col}}}:=\{e_1\boxtimes\cdots\boxtimes e_{M_{\mathrm{col}}}: e_1,\dots,e_{M_{\mathrm{col}}}\in\mathcal{B}\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の基底である（",
        ref("tensor_basis"),
        " (2) を基底 ",
        math(String.raw`\mathcal{B}`),
        " に適用した）。一方、各 ",
        math(String.raw`e_1\boxtimes\cdots\boxtimes e_{M_{\mathrm{col}}}`),
        " について、各 ",
        math(String.raw`k`),
        " で ",
        math(String.raw`\sigma_k^{a_k}:=I\boxtimes\cdots\boxtimes\overbrace{e_k}^{k\text{th}}\boxtimes\cdots\boxtimes I`),
        " とおくと、Step 1 の異サイト積公式を繰り返して",
      ]),
      displayMath(
        String.raw`\sigma_1^{a_1}\sigma_2^{a_2}\cdots\sigma_{M_{\mathrm{col}}}^{a_{M_{\mathrm{col}}}} = e_1\boxtimes e_2\boxtimes\cdots\boxtimes e_{M_{\mathrm{col}}} \quad (\because \text{クロネッカー積の積の規則})`,
      ),
      paragraph([
        "Step 2 より各 ",
        math(String.raw`\sigma_k^{a_k}\in\mathcal{A}`),
        "（",
        math(String.raw`I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}\in\mathcal{A}`),
        " も含む）であり、",
        math(String.raw`\mathcal{A}`),
        " は積について閉じるから ",
        math(String.raw`e_1\boxtimes\cdots\boxtimes e_{M_{\mathrm{col}}} = \sigma_1^{a_1}\cdots\sigma_{M_{\mathrm{col}}}^{a_{M_{\mathrm{col}}}}\in\mathcal{A}`),
        "。よって ",
        math(String.raw`\mathcal{B}^{\boxtimes M_{\mathrm{col}}}\subseteq\mathcal{A}`),
        "。",
        math(String.raw`\mathcal{A}`),
        " は ",
        math(String.raw`\mathbb{C}`),
        "-線型結合について閉じ、",
        math(String.raw`\mathcal{B}^{\boxtimes M_{\mathrm{col}}}`),
        " は基底であるから",
      ]),
      displayMath(
        String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}) = \mathrm{span}_{\mathbb{C}}(\mathcal{B}^{\boxtimes M_{\mathrm{col}}}) \subseteq \mathcal{A} \quad (\because \mathcal{A} \text{ は } \mathbb{C}\text{-線型結合について閉じる})`,
      ),
      paragraph([
        "一方 ",
        math(String.raw`\mathcal{A}\subseteq\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " は定義より明らかであるから ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "タイトルと statement にあった多元環の一般論の語彙（「環として生成する」「C 上の単位的結合多元環」" +
          "「S を含む最小の C-部分多元環」）を、「和・スカラー倍・積で閉じた最小の集合」という具体的な" +
          "言い換えへ直した（goal-alignment-audit の A-6。README 2 節「環・体などの一般論に持ち上げた証明」" +
          "を避けるため）。主張の内容と証明は変えていない。あわせて、最小の集合が存在すること" +
          "（閉じている部分集合の共通部分もまた閉じている）を明示した。",
      ],
    },
  },
  {
    id: "evensector_003_definition_half_integer_modes",
    kind: "claim",
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 5 },
    title: { tex: String.raw`\tilde\theta_\mu \text{ の共役添字恒等式 } \tilde\theta_{1-\mu} = -\tilde\theta_\mu` },
    labels: ["def_half_integer_modes"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        "、",
        math(String.raw`\mu\in\mathbb Z`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        " について、旧複合主張の番号を保った次の恒等式が成り立つ。",
      ]),
      displayMath(String.raw`\text{(3) 共役添字：}\quad \tilde\theta_{1-\mu} = -\tilde\theta_\mu`),
    ],
    proof: [
      paragraph([
        "(3) 共役添字について示す。",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}`),
        " である。主張の左辺から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_{1-\mu}
&=\frac{2\pi\left((1-\mu)_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \tilde\theta\text{ の定義を }1-\mu\in\mathbb Z\text{ で。}\blkref{antiperiodic_exp_sum}\bigr)\\
&=\frac{2\pi\left((\iota_{\mathbb Z\to\mathbb R}(1)-\mu_{\mathbb R})-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は和と零を保つので差を保つ。}\blkref{antiperiodic_exp_sum}\bigr)\\
&=\frac{2\pi\left((1_{\mathbb R}-\mu_{\mathbb R})-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は単位元を保つ。}\blkref{antiperiodic_exp_sum}\bigr)\\
&=\frac{2\pi\left(\left(1_{\mathbb R}+(-\mu_{\mathbb R})\right)-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \blkref{def_real_difference}\bigr)\\
&=\frac{2\pi\left(\left(1_{\mathbb R}+(-\mu_{\mathbb R})\right)+\left(-\tfrac12\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \blkref{def_real_difference}\bigr)\\
&=\frac{2\pi\left(1_{\mathbb R}+\left((-\mu_{\mathbb R})+\left(-\tfrac12\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ の加法の結合律}\bigr)\\
&=\frac{2\pi\left(1_{\mathbb R}+\left(\left(-\tfrac12\right)+(-\mu_{\mathbb R})\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ の加法の交換律}\bigr)\\
&=\frac{2\pi\left(\left(1_{\mathbb R}+\left(-\tfrac12\right)\right)+(-\mu_{\mathbb R})\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ の加法の結合律を右辺から左辺へ}\bigr)\\
&=\frac{2\pi\left(\left(1_{\mathbb R}-\tfrac12\right)+(-\mu_{\mathbb R})\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \blkref{def_real_difference}\text{ を右辺から左辺へ}\bigr)\\
&=\frac{2\pi\left((1_{\mathbb R}-\tfrac12)-\mu_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \blkref{def_real_difference}\text{ を右辺から左辺へ}\bigr)\\
&=\frac{2\pi\left(\tfrac12-\mu_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ 1_{\mathbb R}-\tfrac12=\tfrac12\bigr)\\
&=\frac{2\pi\left(-\left(\mu_{\mathbb R}-\tfrac12\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ で }\tfrac12-\mu_{\mathbb R}=-\left(\mu_{\mathbb R}-\tfrac12\right)\bigr)\\
&=-\frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \mathbb R\text{ の積と }(M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}\text{ を分母とする分数から }-1\text{ をくくり出す}\bigr)\\
&=-\tilde\theta_\mu
&&\bigl(\because\ \tilde\theta_\mu\text{ の定義。}\blkref{antiperiodic_exp_sum}\bigr)
\end{aligned}`,
      ),
      paragraph(["となる。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "旧複合ラベルは、後続参照の意味を保つため、共役添字恒等式だけを述べる残余主張に残した。",
        "2026-11-03（全証明の SageMath 検算）: 鎖を antiperiodic_exp_sum の像の記号 μ_R・(M_col)_R で書き直し、整数から実数への包含が差と単位元を保つ行を分けた（主張は不変）。",
        "2026-11-10（Lean の通しの証明）: 1 行に 2 つの事実を当てていた「ℝ の加法の結合律と交換律」の行を、差の定義（def_real_difference）2 行・結合律・交換律・結合律（右辺から左辺へ）・差の定義（右辺から左辺へ）2 行の 7 行に割った（8 等号 → 14 等号）。主張の中身は不変。",
        "(3) により、整数運動量の場合に -μ が果たしていた「共役添字」の役割を、半整数運動量では 1-μ が果たす。反交換関係の対が μ+ν ≡ 1 (mod M) になるのはこのためである。",
      ],
    },
  },
  {
    id: "evensector_003b_claim_conjugate_index_of_check_Z_Y",
    kind: "claim",
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 7 },
    title: { tex: String.raw`\check{\mathcal{M}} \text{ の内側で共役添字を取る}` },
    labels: ["conjugate_index_of_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad \tilde\theta_{M_{\mathrm{col}}+1-\mu} = 2\pi - \tilde\theta_\mu`)],
        [
          math(
            String.raw`\text{(2)}\quad \exp(-i(j_{\mathbb R}\tilde\theta_{M_{\mathrm{col}}+1-\mu})_{\mathbb C}) = \exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
\qquad (j \in \mathbb{Z})`,
          ),
        ],
        [
          math(
            String.raw`\text{(3)}\quad \check{Z}_{M_{\mathrm{col}}+1-\mu} = \check{Z}_{1-\mu},
\qquad \check{Y}_{M_{\mathrm{col}}+1-\mu} = \check{Y}_{1-\mu}`,
          ),
        ],
      ]),
      paragraph([
        "が成り立つ。とくに (3) により、",
        ref("def_half_integer_modes"),
        " (3) の共役添字 ",
        math(String.raw`1-\mu`),
        "（これは ",
        math(String.raw`\mu \geq 2`),
        " では ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外に出る）を、つねに ",
        math(String.raw`\check{\mathcal{M}}`),
        " の元である ",
        math(String.raw`M_{\mathrm{col}}+1-\mu`),
        " で置き換えてよい。**以降つねにそうする。**",
      ]),
      paragraph([
        "ここで ",
        math(String.raw`j_{\mathbb R}`),
        " は ",
        ref("antiperiodic_exp_sum"),
        " の整数の実数への像、",
        math(String.raw`r_{\mathbb C}`),
        "（",
        math(String.raw`r\in\mathbb R`),
        "）は ",
        ref("inclusion_rr_to_cc"),
        " の像である。(2) の ",
        math(String.raw`-i(\cdot)_{\mathbb C}`),
        " は、",
        math(String.raw`-i := (-1_{\mathbb C})\,i`),
        "（",
        ref("multiply_by_minus_one"),
        "）を掛けた ",
        math(String.raw`(-i)\,(\cdot)_{\mathbb C}`),
        " の意味である。(2) の証明は全実数上の ",
        math(String.raw`\cos,\sin`),
        " の値 ",
        math(String.raw`\cos(2\pi n_{\mathbb R})=1_{\mathbb R}`),
        "、",
        math(String.raw`\sin(2\pi n_{\mathbb R})=0_{\mathbb R}`),
        "（",
        math(String.raw`n\in\mathbb Z`),
        "）を使う。全実数への拡張は ",
        ref("euler_formula_cos_sin"),
        " の前置きのとおり未整備なので、(2) はその拡張を前提とする。",
      ]),
      paragraph([
        "(2) は ",
        ref("def_half_integer_modes"),
        " (3) の ",
        math(String.raw`\tilde\theta_{1-\mu} = -\tilde\theta_\mu`),
        " が果たしていた役割を、",
        math(String.raw`\check{\mathcal{M}}`),
        " の内側で果たす（位相としては ",
        math(String.raw`\tilde\theta_{M_{\mathrm{col}}+1-\mu}`),
        " は ",
        math(String.raw`-\tilde\theta_\mu`),
        " と ",
        math(String.raw`2\pi`),
        " しか違わない）。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}`),
        " である。主張の左辺から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_{M_{\mathrm{col}}+1-\mu}
&= \frac{2\pi\left((M_{\mathrm{col}}+1-\mu)_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \tilde\theta\text{ の定義を }M_{\mathrm{col}}+1-\mu\in\mathbb Z\text{ で。}\blkref{antiperiodic_exp_sum}\bigr) \\
&= \frac{2\pi\left(\left(\iota_{\mathbb Z\to\mathbb R}(M_{\mathrm{col}}+1)-\mu_{\mathbb R}\right)-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は和と零を保つので差を保つ。}\blkref{antiperiodic_exp_sum}\bigr) \\
&= \frac{2\pi\left(\left(\left((M_{\mathrm{col}})_{\mathbb R}+\iota_{\mathbb Z\to\mathbb R}(1)\right)-\mu_{\mathbb R}\right)-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は和を保つ。}\blkref{antiperiodic_exp_sum}\bigr) \\
&= \frac{2\pi\left(\left(\left((M_{\mathrm{col}})_{\mathbb R}+1_{\mathbb R}\right)-\mu_{\mathbb R}\right)-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は単位元を保つ。}\blkref{antiperiodic_exp_sum}\bigr) \\
&= \frac{2\pi\left(\left(\left((M_{\mathrm{col}})_{\mathbb R}+1_{\mathbb R}\right)+(-\mu_{\mathbb R})\right)-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \blkref{def_real_difference}\bigr) \\
&= \frac{2\pi\left(\left(\left((M_{\mathrm{col}})_{\mathbb R}+1_{\mathbb R}\right)+(-\mu_{\mathbb R})\right)+\left(-\tfrac12\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \blkref{def_real_difference}\bigr) \\
&= \frac{2\pi\left(\left((M_{\mathrm{col}})_{\mathbb R}+1_{\mathbb R}\right)+\left((-\mu_{\mathbb R})+\left(-\tfrac12\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \mathbb R\text{ の加法の結合律}\bigr) \\
&= \frac{2\pi\left(\left((M_{\mathrm{col}})_{\mathbb R}+1_{\mathbb R}\right)+\left(\left(-\tfrac12\right)+(-\mu_{\mathbb R})\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \mathbb R\text{ の加法の交換律}\bigr) \\
&= \frac{2\pi\left(\left(\left((M_{\mathrm{col}})_{\mathbb R}+1_{\mathbb R}\right)+\left(-\tfrac12\right)\right)+(-\mu_{\mathbb R})\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \mathbb R\text{ の加法の結合律を右辺から左辺へ}\bigr) \\
&= \frac{2\pi\left(\left((M_{\mathrm{col}})_{\mathbb R}+\left(1_{\mathbb R}+\left(-\tfrac12\right)\right)\right)+(-\mu_{\mathbb R})\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \mathbb R\text{ の加法の結合律}\bigr) \\
&= \frac{2\pi\left(\left((M_{\mathrm{col}})_{\mathbb R}+\left(1_{\mathbb R}-\tfrac12\right)\right)+(-\mu_{\mathbb R})\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \blkref{def_real_difference}\text{ を右辺から左辺へ}\bigr) \\
&= \frac{2\pi\left(\left((M_{\mathrm{col}})_{\mathbb R}+\tfrac12\right)+(-\mu_{\mathbb R})\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ 1_{\mathbb R}-\tfrac12=\tfrac12\bigr) \\
&= \frac{2\pi\left((M_{\mathrm{col}})_{\mathbb R}+\left(\tfrac12+(-\mu_{\mathbb R})\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \mathbb R\text{ の加法の結合律}\bigr) \\
&= \frac{2\pi\left((M_{\mathrm{col}})_{\mathbb R}+\left(\tfrac12-\mu_{\mathbb R}\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \blkref{def_real_difference}\text{ を右辺から左辺へ}\bigr) \\
&= \frac{2\pi\left((M_{\mathrm{col}})_{\mathbb R}+\left(-\left(\mu_{\mathbb R}-\tfrac12\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \mathbb R\text{ で }\tfrac12-\mu_{\mathbb R}=-\left(\mu_{\mathbb R}-\tfrac12\right)\bigr) \\
&= \frac{2\pi\left((M_{\mathrm{col}})_{\mathbb R}-\left(\mu_{\mathbb R}-\tfrac12\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \blkref{def_real_difference}\text{ を右辺から左辺へ}\bigr) \\
&= \frac{2\pi(M_{\mathrm{col}})_{\mathbb R}-2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ \mathbb R\text{ の分配法則}\bigr) \\
&= \frac{2\pi(M_{\mathrm{col}})_{\mathbb R}}{(M_{\mathrm{col}})_{\mathbb R}}-\frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}\text{ を分母とする分数の差}\bigr) \\
&= 2\pi-\frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
   &&\bigl(\because\ (M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}\text{ による約分}\bigr) \\
&= 2\pi - \tilde\theta_\mu
   &&\bigl(\because\ \tilde\theta_\mu\text{ の定義。}\blkref{antiperiodic_exp_sum}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "(2) ",
        math(String.raw`j \in \mathbb{Z}`),
        " とする。準備として、指数の中の実数を (1) で書き直す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
j_{\mathbb R}\tilde\theta_{M_{\mathrm{col}}+1-\mu}
&= j_{\mathbb R}\left(2\pi - \tilde\theta_\mu\right)
   &&(\because\ \text{直前の (1)}) \\
&= j_{\mathbb R}\cdot2\pi - j_{\mathbb R}\tilde\theta_\mu
   &&(\because\ \mathbb R\text{ の分配法則}) \\
&= 2\pi j_{\mathbb R} - j_{\mathbb R}\tilde\theta_\mu
   &&(\because\ \mathbb R\text{ の積の交換律}) \\
&= 2\pi j_{\mathbb R} + \left(-(j_{\mathbb R}\tilde\theta_\mu)\right)
   &&(\because\ \mathbb R\text{ の差は加法の逆元の和})
\end{aligned}`,
      ),
      paragraph([
        "また、",
        math(String.raw`-i := (-1_{\mathbb C})\,i`),
        "（",
        ref("multiply_by_minus_one"),
        "）を ",
        math(String.raw`(-(j_{\mathbb R}\tilde\theta_\mu))_{\mathbb C}`),
        " に掛けたものを書き直す。主張の ",
        math(String.raw`-i(\cdot)_{\mathbb C}`),
        " は主張に書いたとおりこの ",
        math(String.raw`-i`),
        " を掛けたものである。一方 ",
        ref("exp_of_negative_i_real_as_cos_minus_i_sin"),
        " の ",
        math(String.raw`-i\theta_{\mathbb C}`),
        " は、",
        ref("euler_formula_cos_sin"),
        " の読みどおり ",
        math(String.raw`-(i\theta_{\mathbb C})`),
        " の意味なので、引く前に ",
        ref("negative_i_times_complex_is_negation_of_i_times"),
        " で書き換える。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(-i)\left(-(j_{\mathbb R}\tilde\theta_\mu)\right)_{\mathbb C}
&= (-i)\left((-1_{\mathbb R})(j_{\mathbb R}\tilde\theta_\mu)\right)_{\mathbb C}
   &&(\because\ \mathbb R\text{ で }-x=(-1_{\mathbb R})x) \\
&= (-i)\left((-1_{\mathbb R})_{\mathbb C}\,(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\right)
   &&(\because\ \blkref{real_inclusion_preserves_product}) \\
&= (-i)\left((-1_{\mathbb C})\,(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\right)
   &&\bigl(\because\ (-1_{\mathbb R})_{\mathbb C}=(-1_{\mathbb R},0_{\mathbb R})\text{ は }1_{\mathbb C}\text{ の加法の逆元 }-1_{\mathbb C}\ (\blkref{inclusion_rr_to_cc},\ \blkref{definition_of_cc}\text{ の和},\ \blkref{complex_numbers_form_a_field})\bigr) \\
&= \left((-1_{\mathbb C})\,i\right)\left((-1_{\mathbb C})\,(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\right)
   &&(\because\ \blkref{multiply_by_minus_one}) \\
&= \left((-1_{\mathbb C})(-1_{\mathbb C})\right)\left(i\,(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\right)
   &&(\because\ \mathbb C\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}) \\
&= 1_{\mathbb C}\left(i\,(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\right)
   &&(\because\ (-1_{\mathbb C})(-1_{\mathbb C})=1_{\mathbb C}\ (\blkref{complex_numbers_form_a_field})) \\
&= i\,(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}
   &&(\because\ 1_{\mathbb C}\text{ は積の単位元}\ (\blkref{complex_numbers_form_a_field}))
\end{aligned}`,
      ),
      paragraph(["これらを使って、主張の左辺から"]),
      displayMath(
        String.raw`\begin{aligned}
\exp(-i(j_{\mathbb R}\tilde\theta_{M_{\mathrm{col}}+1-\mu})_{\mathbb C})
&= \exp\!\left(-i\left(2\pi j_{\mathbb R} + \left(-(j_{\mathbb R}\tilde\theta_\mu)\right)\right)_{\mathbb C}\right)
   &&(\because\ \text{準備の第一の鎖}) \\
&= \exp\!\left(-i\left((2\pi j_{\mathbb R})_{\mathbb C} + \left(-(j_{\mathbb R}\tilde\theta_\mu)\right)_{\mathbb C}\right)\right)
   &&\bigl(\because\ \blkref{real_inclusion_preserves_finite_sum}\text{ を }m=2,\ r_1=2\pi j_{\mathbb R},\ r_2=-(j_{\mathbb R}\tilde\theta_\mu)\text{ で。二項の有限和は }\blkref{def_finite_sum_of_complex_numbers}\text{ と }\mathbb R\text{ の有限和の定義で }r_1+r_2\text{ の形に開く}\bigr) \\
&= \exp\!\left((-i)(2\pi j_{\mathbb R})_{\mathbb C} + (-i)\left(-(j_{\mathbb R}\tilde\theta_\mu)\right)_{\mathbb C}\right)
   &&(\because\ \mathbb C\text{ の分配法則。}\blkref{complex_numbers_form_a_field}) \\
&= \exp\!\left((-i)(2\pi j_{\mathbb R})_{\mathbb C} + i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C}\right)
   &&(\because\ \text{準備の第二の鎖}) \\
&= \exp((-i)(2\pi j_{\mathbb R})_{\mathbb C})\,\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ \blkref{scalar_exp_product}\text{ を }K=\mathbb C\text{ で}) \\
&= \exp\!\left(-\left(i(2\pi j_{\mathbb R})_{\mathbb C}\right)\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&\bigl(\because\ \blkref{negative_i_times_complex_is_negation_of_i_times}\ (z \to (2\pi j_{\mathbb R})_{\mathbb C})\bigr) \\
&= \left((\cos(2\pi j_{\mathbb R}))_{\mathbb C} - i(\sin(2\pi j_{\mathbb R}))_{\mathbb C}\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ \blkref{exp_of_negative_i_real_as_cos_minus_i_sin}\text{ を }\theta=2\pi j_{\mathbb R}\text{ で}) \\
&= \left((1_{\mathbb R})_{\mathbb C} - i(\sin(2\pi j_{\mathbb R}))_{\mathbb C}\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ j\in\mathbb Z\text{ と全実数上の }\cos(2\pi n_{\mathbb R})=1_{\mathbb R}) \\
&= \left((1_{\mathbb R})_{\mathbb C} - i(0_{\mathbb R})_{\mathbb C}\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ j\in\mathbb Z\text{ と全実数上の }\sin(2\pi n_{\mathbb R})=0_{\mathbb R}) \\
&= \left(1_{\mathbb C} - i\cdot0_{\mathbb C}\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&\bigl(\because\ (1_{\mathbb R})_{\mathbb C}=(1_{\mathbb R},0_{\mathbb R})=1_{\mathbb C},\ (0_{\mathbb R})_{\mathbb C}=(0_{\mathbb R},0_{\mathbb R})=0_{\mathbb C}\ (\blkref{inclusion_rr_to_cc},\ \blkref{complex_numbers_form_a_field}\text{ の単位元と零元})\bigr) \\
&= \left(1_{\mathbb C} - 0_{\mathbb C}\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ \blkref{complex_times_zero_is_zero}) \\
&= \left(1_{\mathbb C} + (-0_{\mathbb C})\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ \blkref{def_complex_difference}) \\
&= \left(1_{\mathbb C} + (-1_{\mathbb C})\,0_{\mathbb C}\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ \blkref{multiply_by_minus_one}) \\
&= \left(1_{\mathbb C} + 0_{\mathbb C}\right)\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ \blkref{complex_times_zero_is_zero}) \\
&= 1_{\mathbb C}\exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ 0_{\mathbb C}\text{ は和の単位元}\ (\blkref{complex_numbers_form_a_field})) \\
&= \exp(i(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C})
   &&(\because\ 1_{\mathbb C}\text{ は積の単位元}\ (\blkref{complex_numbers_form_a_field}))
\end{aligned}`,
      ),
      paragraph(["となる。"]),
      paragraph([
        "(3) ",
        ref("half_integer_checkZ_periodicity"),
        " と ",
        ref("half_integer_checkY_periodicity"),
        "（添字の周期性）を添字 ",
        math(String.raw`1-\mu \in \mathbb{Z}`),
        " に適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_{M_{\mathrm{col}}+1-\mu}
&=\check{Z}_{(1-\mu)+M_{\mathrm{col}}}
&&\bigl(\because (1-\mu)+M_{\mathrm{col}}=M_{\mathrm{col}}+1-\mu\bigr)\\
&=\check{Z}_{1-\mu}
&&\bigl(\because \blkref{half_integer_checkZ_periodicity}\bigr),\\[2pt]
\check{Y}_{M_{\mathrm{col}}+1-\mu}
&=\check{Y}_{(1-\mu)+M_{\mathrm{col}}}
&&\bigl(\because (1-\mu)+M_{\mathrm{col}}=M_{\mathrm{col}}+1-\mu\bigr)\\
&=\check{Y}_{1-\mu}
&&\bigl(\because \blkref{half_integer_checkY_periodicity}\bigr).
\end{aligned}`,
      ),
      paragraph([
        "この適用では、添字の周期性を ", math(String.raw`\check{\mathcal{M}}`),
        " の外の添字 ", math(String.raw`1-\mu`),
        " に用いている。添字の周期性を ", math(String.raw`\mu\in\mathbb Z`),
        " で述べたことが、この橋渡しを可能にする。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-01 の式変形統一で、二本の式変形鎖の行中にあった根拠 7 行を行末の根拠列（aligned の &&）へ揃え、添字の周期性の二本の等式を同じ形へ開いた。内容・式変形・根拠・ラベル参照は不変である。",
        "2026-11-03（全証明の SageMath 検算）: (2) の主張を像の記号 j_R・(·)_C で書き、全実数上の cos・sin の値を前提とすることを主張に書いた。(2) の証明は、主張と違う式を述べる euler_formula_cos_sin と行列の theorem_exp_product (n=1) を引いていたので、exp_of_negative_i_real_as_cos_minus_i_sin と scalar_exp_product に付け替え、包含の和・積の保存と符号の鎖を置いた。(1) の根拠「ℂ の四則」は実数の計算なので ℝ に直し、像の記号で書き直した。",
        "2026-11-09（Lean の通しの証明）: (2) の鎖は exp((-i)(2πj_R)_C) に exp_of_negative_i_real_as_cos_minus_i_sin を直接当てていたが、その主張の -iθ_C は euler_formula_cos_sin の読みどおり -(iθ_C) である。" +
          "準備の文の「exp_of_negative_i_real_as_cos_minus_i_sin の -iθ_C も (-i)θ_C の意味」を直し、negative_i_times_complex_is_negation_of_i_times で -(i(2πj_R)_C) へ書き換える 1 行を足した（15 等号 → 16 等号）。主張 (2) の -i(·)_C が (-i)(·)_C の意味であることは証明の準備の文にしか無かったので、主張に書いた。ほかの行は変えていない。",
        "2026-11-10（Lean の通しの証明）: (1) の鎖の、1 行に 2 つ以上の事実を当てていた行（「和と差を保つ」「ℝ の加法の結合律と交換律」「結合律（差は加法の逆元の和）」「½ - μ_R = -(μ_R - ½) と、差は加法の逆元の和」）を、差の定義（def_real_difference）・結合律・交換律を 1 行ずつ当てる形に割った（11 等号 → 20 等号）。主張の中身は不変。",
      ],
    },
  },
  {
    id: "evensector_005_claim_anticommutator_check_Z_Y",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 9 },
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ の反交換関係}` },
    labels: ["anticommutator_of_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        " とし、",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb N}\in\mathbb N_{\geq2}`),
        " と像の記号 ",
        math(String.raw`a_{\mathbb R}, a_{\mathbb C}`),
        "、",
        ref("def_half_integer_checkZ"),
        " の ",
        math(String.raw`\check Z_\mu`),
        "、",
        ref("def_half_integer_checkY"),
        " の ",
        math(String.raw`\check Y_\mu`),
        " を用いる。",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`\left[\check{Z}_\mu, \check{Z}_\nu\right]_+ = 2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I,
\qquad
\left[\check{Z}_\mu, \check{Y}_\nu\right]_+ = 0,
\qquad
\left[\check{Y}_\mu, \check{Y}_\nu\right]_+ = 2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I`,
      ),
      paragraph([
        "が成り立つ。反交換子は ",
        ref("def_matrix_anticommutator"),
        " のもの、",
        math(String.raw`I := I_{\mathrm{Mat}(2^{(M_{\mathrm{col}})_{\mathbb N}},\mathbb{C})}`),
        " は単位行列である。",
        ref("def_check_index_set"),
        " (2) により ",
        math(String.raw`\nu,\ M_{\mathrm{col}}+1-\mu \in \check{\mathcal M} = \{1,\dots,M_{\mathrm{col}}\}`),
        " なので、",
        math(String.raw`\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\in\mathbb C`),
        " は ",
        ref("def_kronecker_delta"),
        " のクロネッカーのデルタ（",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " のとき ",
        math(String.raw`1_{\mathbb C}`),
        "、そうでないとき ",
        math(String.raw`0_{\mathbb C}`),
        "）である。",
        math(String.raw`2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I`),
        " は、",
        math(String.raw`2_{\mathbb C} := (2_{\mathbb R})_{\mathbb C}`),
        " と ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb C}`),
        " による複素数 ",
        math(String.raw`(2_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C})\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}`),
        " による ",
        math(String.raw`I`),
        " のスカラー倍（",
        ref("def_matrix_scalar_multiple"),
        "）を表し、",
        math(String.raw`0`),
        " は零行列 ",
        math(String.raw`O \in \mathrm{Mat}(2^{(M_{\mathrm{col}})_{\mathbb N}},\mathbb{C})`),
        "（",
        ref("def_zero_matrix"),
        "）を表す。",
      ]),
      paragraph([
        "**対になる添字に合同式が現れない**のは、添字の範囲を ",
        math(String.raw`\check{\mathcal{M}}`),
        " に絞ったからである：",
        ref("def_check_index_set"),
        " (5) により ",
        math(String.raw`\mu,\nu \in \check{\mathcal{M}}`),
        " では ",
        math(String.raw`\mu+\nu \equiv 1 \pmod M_{\mathrm{col}}`),
        " と ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " が同値である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`N := (M_{\mathrm{col}})_{\mathbb N}`),
        " と置き、",
        math(String.raw`j \in \{1,\dots,N\}`),
        "、",
        math(String.raw`\lambda \in \mathbb Z`),
        " について ",
        math(String.raw`e_{j,\lambda} := \exp(-i(j_{\mathbb R}\tilde\theta_\lambda)_{\mathbb C}) \in \mathbb C`),
        " と置く（",
        ref("def_half_integer_checkZ"),
        " の仮定により ",
        math(String.raw`\mathbb C`),
        " の元）。",
        math(String.raw`-i := (-1_{\mathbb C})\,i`),
        "（",
        ref("multiply_by_minus_one"),
        "）であり、",
        math(String.raw`-i(x)_{\mathbb C}`),
        " は積 ",
        math(String.raw`(-i)(x)_{\mathbb C}`),
        " を表す。周期デルタ ",
        math(String.raw`\delta^{(M_{\mathrm{col}})}`),
        "（",
        ref("def_delta_M"),
        "）の法は ",
        math(String.raw`N`),
        " である（",
        ref("antiperiodic_exp_sum"),
        "）。",
      ]),
      paragraph([
        "準備 1（添字の対角）。",
        math(String.raw`j, k \in \{1,\dots,N\}`),
        " なら ",
        math(String.raw`j_{\mathbb Z}, k_{\mathbb Z} \in \{1,\dots,M_{\mathrm{col}}\}`),
        " である。",
        math(String.raw`j = k`),
        " なら ",
        math(String.raw`j_{\mathbb Z} - k_{\mathbb Z} = 0 = 0\cdot M_{\mathrm{col}}`),
        " なので ",
        math(String.raw`\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})} = 1_{\mathbb C}`),
        "。",
        math(String.raw`j \neq k`),
        " なら、標準包含 ",
        math(String.raw`\iota_{\mathbb N\to\mathbb Z}`),
        " は単射なので ",
        math(String.raw`j_{\mathbb Z} \neq k_{\mathbb Z}`),
        "、さらに ",
        math(String.raw`0 < |j_{\mathbb Z} - k_{\mathbb Z}| \leq M_{\mathrm{col}} - 1 < M_{\mathrm{col}}`),
        " なので ",
        math(String.raw`M_{\mathrm{col}}`),
        " は ",
        math(String.raw`j_{\mathbb Z} - k_{\mathbb Z}`),
        " を割り切らず、",
        math(String.raw`\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})} = 0_{\mathbb C}`),
        "（",
        ref("def_delta_M"),
        "）。したがって ",
        math(String.raw`\lambda, \lambda' \in \mathbb Z`),
        "、",
        math(String.raw`j \neq k`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(e_{j,\lambda}e_{k,\lambda'})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}
&= (e_{j,\lambda}e_{k,\lambda'})\,0_{\mathbb C}
&&(\because\ \text{準備 1}) \\
&= 0_{\mathbb C}
&&(\because\ \blkref{complex_times_zero_is_zero})
\end{aligned}`,
      ),
      paragraph([
        "準備 2（指数）。",
        math(String.raw`\kappa := -(\mu+\nu-1) \in \mathbb Z`),
        " と置く。",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}`),
        " である。",
        math(String.raw`j \in \{1,\dots,N\}`),
        " について、実数の側で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
j_{\mathbb R}\tilde\theta_\mu + j_{\mathbb R}\tilde\theta_\nu
&= j_{\mathbb R}\left(\tilde\theta_\mu + \tilde\theta_\nu\right)
&&(\because\ \mathbb R\text{ の分配法則}) \\
&= j_{\mathbb R}\left(\frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}} + \frac{2\pi\left(\nu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}\right)
&&\bigl(\because\ \tilde\theta\text{ の定義を 2 箇所へ同時適用。}\blkref{antiperiodic_exp_sum}\bigr) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right) + 2\pi\left(\nu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ (M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}\text{ を分母とする分数の和}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\left(\mu_{\mathbb R}-\tfrac12\right) + \left(\nu_{\mathbb R}-\tfrac12\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の分配法則}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\left(\mu_{\mathbb R}+\left(-\tfrac12\right)\right)+\left(\nu_{\mathbb R}+\left(-\tfrac12\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の差は加法の逆元の和を 2 箇所へ同時適用}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\mu_{\mathbb R}+\left(\left(-\tfrac12\right)+\left(\nu_{\mathbb R}+\left(-\tfrac12\right)\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の加法の結合律}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\mu_{\mathbb R}+\left(\left(\nu_{\mathbb R}+\left(-\tfrac12\right)\right)+\left(-\tfrac12\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の加法の交換律}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\mu_{\mathbb R}+\left(\nu_{\mathbb R}+\left(\left(-\tfrac12\right)+\left(-\tfrac12\right)\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の加法の結合律}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\left(\mu_{\mathbb R}+\nu_{\mathbb R}\right)+\left(\left(-\tfrac12\right)+\left(-\tfrac12\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の加法の結合律}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\left(\mu_{\mathbb R}+\nu_{\mathbb R}\right)+\left(-\left(\tfrac12+\tfrac12\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ で }(-a)+(-b)=-(a+b)) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\left(\mu_{\mathbb R}+\nu_{\mathbb R}\right)+\left(-1_{\mathbb R}\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \tfrac12+\tfrac12=1_{\mathbb R}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(\mu_{\mathbb R}+\nu_{\mathbb R}-1_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の差は加法の逆元の和}) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(-\left(-\left(\mu_{\mathbb R}+\nu_{\mathbb R}-1_{\mathbb R}\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ で }-(-x)=x) \\
&= j_{\mathbb R}\cdot\frac{2\pi\left(-\kappa_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は和・零・単位元を保つので差と加法の逆元を保ち、}\kappa_{\mathbb R}=-\left(\mu_{\mathbb R}+\nu_{\mathbb R}-1_{\mathbb R}\right)\text{。}\blkref{antiperiodic_exp_sum}\bigr) \\
&= \frac{j_{\mathbb R}\left(2\pi\left(-\kappa_{\mathbb R}\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ で }a\cdot\tfrac{b}{c}=\tfrac{ab}{c}) \\
&= \frac{j_{\mathbb R}\left(-\left(2\pi\kappa_{\mathbb R}\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ で }a(-b)=-(ab)) \\
&= \frac{-\left(j_{\mathbb R}\left(2\pi\kappa_{\mathbb R}\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ で }a(-b)=-(ab)) \\
&= \frac{-\left(\left(j_{\mathbb R}\,2\pi\right)\kappa_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の積の結合律}) \\
&= \frac{-\left(\left(2\pi j_{\mathbb R}\right)\kappa_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ の積の交換律}) \\
&= -\frac{2\pi j_{\mathbb R}\kappa_{\mathbb R}}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb R\text{ で }\tfrac{-a}{c}=-\tfrac{a}{c}\text{。}2\pi j_{\mathbb R}\kappa_{\mathbb R}:=\left(2\pi j_{\mathbb R}\right)\kappa_{\mathbb R})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`y_j := \frac{2\pi j_{\mathbb R}\kappa_{\mathbb R}}{(M_{\mathrm{col}})_{\mathbb R}} \in \mathbb R`),
        " と置くと、複素数の側で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(-i)(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C} + (-i)(j_{\mathbb R}\tilde\theta_\nu)_{\mathbb C}
&= (-i)\left((j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C} + (j_{\mathbb R}\tilde\theta_\nu)_{\mathbb C}\right)
&&(\because\ \mathbb C\text{ の分配法則。}\blkref{complex_numbers_form_a_field}) \\
&= (-i)\left(j_{\mathbb R}\tilde\theta_\mu + j_{\mathbb R}\tilde\theta_\nu\right)_{\mathbb C}
&&\bigl(\because\ \blkref{real_inclusion_preserves_finite_sum}\text{ を }m=2\text{ で。二項の有限和は }\blkref{def_finite_sum_of_complex_numbers}\text{ と }\mathbb R\text{ の有限和の定義で二項の和の形に開く}\bigr) \\
&= (-i)\left(-y_j\right)_{\mathbb C}
&&(\because\ \text{直前の実数の鎖}) \\
&= -\left(i\left(-y_j\right)_{\mathbb C}\right)
&&\bigl(\because\ \blkref{negative_i_times_complex_is_negation_of_i_times}\ (z \to (-y_j)_{\mathbb C})\bigr) \\
&= i\,(y_j)_{\mathbb C}
&&\bigl(\because\ \blkref{negation_of_i_times_negated_real_is_i_times}\ (\theta \to y_j)\bigr)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("exp_sum"),
        " は包含の像を書いていないが、その ",
        math(String.raw`M_{\mathrm{col}}\in\mathbb N_{\geq1}`),
        " を ",
        math(String.raw`N`),
        "、",
        math(String.raw`k\in\mathbb Z`),
        " を ",
        math(String.raw`\kappa`),
        " に取ったとき、左辺の指数 ",
        math(String.raw`\frac{2\pi i j \kappa}{N}`),
        " は ",
        math(String.raw`i\,(y_j)_{\mathbb C}`),
        "、右辺の係数 ",
        math(String.raw`N`),
        " は ",
        math(String.raw`N_{\mathbb C} = (M_{\mathrm{col}})_{\mathbb C}`),
        "（",
        math(String.raw`(N)_{\mathbb Z} = M_{\mathrm{col}}`),
        "。",
        ref("antiperiodic_exp_sum"),
        "）であり、右辺の積は ",
        math(String.raw`\mathbb C`),
        " の積である。",
      ]),
      paragraph([
        "第 1 式。主張の左辺から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Z}_\mu, \check{Z}_\nu\right]_+
&= \left[\sum_{j=1}^{N} e_{j,\mu}Z_{j_{\mathbb Z}},\ \sum_{k=1}^{N} e_{k,\nu}Z_{k_{\mathbb Z}}\right]_+
   &&\bigl(\because \blkref{def_half_integer_checkZ}\text{ を 2 箇所へ同時適用}\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N} (e_{j,\mu}e_{k,\nu})\left[Z_{j_{\mathbb Z}}, Z_{k_{\mathbb Z}}\right]_+
   &&\bigl(\because \blkref{anticommutator_of_finite_sums_of_scalar_multiples}\ (n = 2^{N},\ r = s = N)\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N} (e_{j,\mu}e_{k,\nu})\left(\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\left(2_{\mathbb C}I\right)\right)
   &&\bigl(\because \blkref{anticommutator_of_Z_and_Y}\text{ を }N^2\text{ 個の項へ同時適用。右辺の }2I\delta\text{ を、}2_{\mathbb C}I\text{ の }\delta\text{ 倍と書いた}\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N} \left((e_{j,\mu}e_{k,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{scalar_multiple_is_associative}\text{ を }N^2\text{ 個の項へ同時適用}\bigr) \\
&= \sum_{j=1}^{N}\left(\left(\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)\right)
   &&\bigl(\because \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\text{ を各 }j\text{ へ同時適用}\bigr) \\
&= \left(\sum_{j=1}^{N}\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\bigr) \\
&= \left(\sum_{j=1}^{N}(e_{j,\mu}e_{j,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},j_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{finite_sum_with_single_nonzero_term}\text{ を各 }j\text{ へ }n = j\text{ で同時適用。}k\neq j\text{ の項は準備 1 の鎖で }0_{\mathbb C}\bigr) \\
&= \left(\sum_{j=1}^{N}(e_{j,\mu}e_{j,\nu})\,1_{\mathbb C}\right)\left(2_{\mathbb C}I\right)
   &&(\because \text{準備 1 を各 }j\text{ へ同時適用}) \\
&= \left(\sum_{j=1}^{N}e_{j,\mu}e_{j,\nu}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because 1_{\mathbb C}\text{ は積の単位元}\ (\blkref{complex_numbers_form_a_field})\bigr) \\
&= \left(\sum_{j=1}^{N}\exp\!\left((-i)(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C} + (-i)(j_{\mathbb R}\tilde\theta_\nu)_{\mathbb C}\right)\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{scalar_exp_product}\text{ を }K=\mathbb C\text{ で各 }j\text{ へ同時適用}\bigr) \\
&= \left(\sum_{j=1}^{N}\exp\!\left(i\,(y_j)_{\mathbb C}\right)\right)\left(2_{\mathbb C}I\right)
   &&(\because \text{準備 2 の複素数の鎖を各 }j\text{ へ同時適用}) \\
&= \left((M_{\mathrm{col}})_{\mathbb C}\,\delta^{(M_{\mathrm{col}})}_{(\kappa,\,0)}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{exp_sum}\text{ を }N\text{ と }\kappa\text{ で。準備 2 の読み}\bigr) \\
&= \left((M_{\mathrm{col}})_{\mathbb C}\,\delta^{(M_{\mathrm{col}})}_{(\mu+\nu,\,1)}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \kappa - 0 = -\left((\mu+\nu)-1\right)\text{ なので }\kappa\equiv0 \iff \mu+\nu\equiv1 \pmod{M_{\mathrm{col}}}\text{。}\blkref{def_delta_M}\bigr) \\
&= \left((M_{\mathrm{col}})_{\mathbb C}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{def_check_index_set}\ (5)\ (\mu,\nu \in \check{\mathcal{M}})\bigr) \\
&= \left(\left((M_{\mathrm{col}})_{\mathbb C}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\right)2_{\mathbb C}\right)I
   &&\bigl(\because \blkref{scalar_multiple_is_associative}\bigr) \\
&= \left(\left(2_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C}\right)\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\right)I
   &&\bigl(\because \mathbb C\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "となり、最後の行は主張の右辺 ",
        math(String.raw`2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I`),
        " である。",
      ]),
      paragraph(["第 2 式。主張の左辺から"]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Z}_\mu,\check{Y}_\nu\right]_+
&= \left[\sum_{j=1}^{N} e_{j,\mu}Z_{j_{\mathbb Z}},\ \sum_{k=1}^{N} e_{k,\nu}Y_{k_{\mathbb Z}}\right]_+
   &&\bigl(\because \blkref{def_half_integer_checkZ},\ \blkref{def_half_integer_checkY}\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\left[Z_{j_{\mathbb Z}},Y_{k_{\mathbb Z}}\right]_+
   &&\bigl(\because \blkref{anticommutator_of_finite_sums_of_scalar_multiples}\ (n = 2^{N},\ r = s = N)\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\,O
   &&\bigl(\because \blkref{anticommutator_of_Z_and_Y}\text{ を }N^2\text{ 個の項へ同時適用。右辺の }0\text{ は零行列 }O\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N}O
   &&\bigl(\because \blkref{scalar_multiple_of_zero_matrix}\text{ を }N^2\text{ 個の項へ同時適用}\bigr) \\
&= \sum_{j=1}^{N}O
   &&\bigl(\because \blkref{finite_sum_of_zero_matrices}\text{ を各 }j\text{ へ同時適用}\bigr) \\
&= O
   &&\bigl(\because \blkref{finite_sum_of_zero_matrices}\bigr)
\end{aligned}`,
      ),
      paragraph(["第 3 式。主張の左辺から"]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Y}_\mu,\check{Y}_\nu\right]_+
&= \left[\sum_{j=1}^{N} e_{j,\mu}Y_{j_{\mathbb Z}},\ \sum_{k=1}^{N} e_{k,\nu}Y_{k_{\mathbb Z}}\right]_+
   &&\bigl(\because \blkref{def_half_integer_checkY}\text{ を 2 箇所へ同時適用}\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\left[Y_{j_{\mathbb Z}},Y_{k_{\mathbb Z}}\right]_+
   &&\bigl(\because \blkref{anticommutator_of_finite_sums_of_scalar_multiples}\ (n = 2^{N},\ r = s = N)\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\left(\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\left(2_{\mathbb C}I\right)\right)
   &&\bigl(\because \blkref{anticommutator_of_Z_and_Y}\text{ を }N^2\text{ 個の項へ同時適用。右辺の }2I\delta\text{ を、}2_{\mathbb C}I\text{ の }\delta\text{ 倍と書いた}\bigr) \\
&= \sum_{j=1}^{N}\sum_{k=1}^{N} \left((e_{j,\mu}e_{k,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{scalar_multiple_is_associative}\text{ を }N^2\text{ 個の項へ同時適用}\bigr) \\
&= \sum_{j=1}^{N}\left(\left(\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)\right)
   &&\bigl(\because \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\text{ を各 }j\text{ へ同時適用}\bigr) \\
&= \left(\sum_{j=1}^{N}\sum_{k=1}^{N}(e_{j,\mu}e_{k,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},k_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\bigr) \\
&= \left(\sum_{j=1}^{N}(e_{j,\mu}e_{j,\nu})\,\delta^{(M_{\mathrm{col}})}_{(j_{\mathbb Z},j_{\mathbb Z})}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{finite_sum_with_single_nonzero_term}\text{ を各 }j\text{ へ }n = j\text{ で同時適用。}k\neq j\text{ の項は準備 1 の鎖で }0_{\mathbb C}\bigr) \\
&= \left(\sum_{j=1}^{N}(e_{j,\mu}e_{j,\nu})\,1_{\mathbb C}\right)\left(2_{\mathbb C}I\right)
   &&(\because \text{準備 1 を各 }j\text{ へ同時適用}) \\
&= \left(\sum_{j=1}^{N}e_{j,\mu}e_{j,\nu}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because 1_{\mathbb C}\text{ は積の単位元}\ (\blkref{complex_numbers_form_a_field})\bigr) \\
&= \left(\sum_{j=1}^{N}\exp\!\left((-i)(j_{\mathbb R}\tilde\theta_\mu)_{\mathbb C} + (-i)(j_{\mathbb R}\tilde\theta_\nu)_{\mathbb C}\right)\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{scalar_exp_product}\text{ を }K=\mathbb C\text{ で各 }j\text{ へ同時適用}\bigr) \\
&= \left(\sum_{j=1}^{N}\exp\!\left(i\,(y_j)_{\mathbb C}\right)\right)\left(2_{\mathbb C}I\right)
   &&(\because \text{準備 2 の複素数の鎖を各 }j\text{ へ同時適用}) \\
&= \left((M_{\mathrm{col}})_{\mathbb C}\,\delta^{(M_{\mathrm{col}})}_{(\kappa,\,0)}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{exp_sum}\text{ を }N\text{ と }\kappa\text{ で。準備 2 の読み}\bigr) \\
&= \left((M_{\mathrm{col}})_{\mathbb C}\,\delta^{(M_{\mathrm{col}})}_{(\mu+\nu,\,1)}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \kappa - 0 = -\left((\mu+\nu)-1\right)\text{ なので }\kappa\equiv0 \iff \mu+\nu\equiv1 \pmod{M_{\mathrm{col}}}\text{。}\blkref{def_delta_M}\bigr) \\
&= \left((M_{\mathrm{col}})_{\mathbb C}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\right)\left(2_{\mathbb C}I\right)
   &&\bigl(\because \blkref{def_check_index_set}\ (5)\ (\mu,\nu \in \check{\mathcal{M}})\bigr) \\
&= \left(\left((M_{\mathrm{col}})_{\mathbb C}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\right)2_{\mathbb C}\right)I
   &&\bigl(\because \blkref{scalar_multiple_is_associative}\bigr) \\
&= \left(\left(2_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C}\right)\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\right)I
   &&\bigl(\because \mathbb C\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "となり、最後の行は主張の右辺 ",
        math(String.raw`2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-03（全証明の SageMath 検算）: 主張に像の記号と、2M_col δ I・0 が何の元かを書いた（中身は不変）。証明は、名前だけの根拠「反交換子の ℂ 双線型性」を新しい主張 anticommutator_of_finite_sums_of_scalar_multiples・finite_sum_of_scalar_multiples_of_one_matrix への参照に、行列の theorem_exp_product (n=1) を scalar_exp_product に付け替え、二重和から j = k の項を残す段を準備 1 と finite_sum_with_single_nonzero_term に、θ̃_μ + θ̃_ν の書き換えと exp_sum の指数への読み替えを準備 2 の鎖に分け、第 3 式を省略せずに書いた。",
        "2026-11-10（Lean の通しの証明）: 準備 2 の複素数の鎖の (-i)(-y_j)_C から i(y_j)_C までの 11 行（-y_j を (-1_R)y_j に開き、-1_C と i の積を結合律・交換律で並べ替える鎖）を、主張 negative_i_times_complex_is_negation_of_i_times（z → (-y_j)_C）と negation_of_i_times_negated_real_is_i_times（θ → y_j）の 2 行に替えた。鎖の両端は変えていない。",
      ],
    },
  },
  {
    id: "evensector_006_claim_recover_Z_Y",
    kind: "claim",
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 10 },
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ から } Z_j, Y_j \text{ を復元する}` },
    labels: ["recover_Z_Y_from_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        " とし、",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`N := (M_{\mathrm{col}})_{\mathbb N}\in\mathbb N_{\geq2}`),
        "、像の記号 ",
        math(String.raw`n_{\mathbb Z}, n_{\mathbb R}, a_{\mathbb R}, a_{\mathbb C}`),
        " と ",
        math(String.raw`\tilde\theta_\mu\in\mathbb R`),
        "、",
        ref("def_half_integer_checkZ"),
        " の ",
        math(String.raw`\check Z_\mu`),
        "、",
        ref("def_half_integer_checkY"),
        " の ",
        math(String.raw`\check Y_\mu`),
        " を用いる。",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}`),
        " なので ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb C}=((M_{\mathrm{col}})_{\mathbb R},0_{\mathbb R})\neq(0_{\mathbb R},0_{\mathbb R})=0_{\mathbb C}`),
        "（",
        ref("inclusion_rr_to_cc"),
        "）であり、その逆元 ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb C}^{-1}\in\mathbb C`),
        " がある（",
        ref("complex_numbers_form_a_field"),
        "）。",
        math(String.raw`j \in \{1,\dots,N\}`),
        " について",
      ]),
      displayMath(
        String.raw`(M_{\mathrm{col}})_{\mathbb C}^{-1}\sum_{\mu=1}^{N} \exp\!\left(i\,(j_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\check{Z}_{\mu_{\mathbb Z}} = Z_{j_{\mathbb Z}},
\qquad
(M_{\mathrm{col}})_{\mathbb C}^{-1}\sum_{\mu=1}^{N} \exp\!\left(i\,(j_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\check{Y}_{\mu_{\mathbb Z}} = Y_{j_{\mathbb Z}}`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`\exp`),
        " は ",
        ref("def_scalar_exp"),
        " の ",
        math(String.raw`K=\mathbb C`),
        " のもの、",
        math(String.raw`i\,(x)_{\mathbb C}`),
        " は ",
        math(String.raw`\mathbb C`),
        " の積、スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、行列の有限和は ",
        ref("def_finite_sum_of_matrices"),
        " のものであり、両辺は ",
        math(String.raw`\mathrm{Mat}(2^{N},\mathbb{C})`),
        " の元である。",
      ]),
      paragraph([
        "とくに、",
        math(String.raw`\mathrm{Mat}(2^{N},\mathbb{C})`),
        " の部分集合 ",
        math(String.raw`T`),
        " が、すべての ",
        math(String.raw`\mu \in \{1,\dots,N\}`),
        " について ",
        math(String.raw`\check{Z}_{\mu_{\mathbb Z}}, \check{Y}_{\mu_{\mathbb Z}} \in T`),
        " を満たし、",
        ref("Z_Y_generate_algebra"),
        " の (ii)〜(iv)（単位行列を含み、和・スカラー倍・行列の積で閉じる）を満たすならば、",
        math(String.raw`T = \mathrm{Mat}(2^{N},\mathbb{C})`),
        " である。すなわち ",
        math(String.raw`\check{Z}_{1_{\mathbb Z}},\dots,\check{Z}_{N_{\mathbb Z}},\check{Y}_{1_{\mathbb Z}},\dots,\check{Y}_{N_{\mathbb Z}}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2^{N},\mathbb{C})`),
        " を単位的 ",
        math(String.raw`\mathbb{C}`),
        " 代数として生成する（",
        ref("Z_Y_generate_algebra"),
        " の ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " はこの ",
        math(String.raw`\mathrm{Mat}(2^{N},\mathbb{C})`),
        " である）。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`j, k, \mu \in \{1,\dots,N\}`),
        " について ",
        math(String.raw`f_{j,\mu} := \exp(i\,(j_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}) \in \mathbb C`),
        "、",
        math(String.raw`e_{k,\mu} := \exp(-i(k_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}) \in \mathbb C`),
        "（",
        ref("def_scalar_exp"),
        "）と置き、",
        math(String.raw`c := (M_{\mathrm{col}})_{\mathbb C}^{-1} \in \mathbb C`),
        " と置く。",
        math(String.raw`-i := (-1_{\mathbb C})\,i`),
        "（",
        ref("multiply_by_minus_one"),
        "）であり、",
        math(String.raw`-i(x)_{\mathbb C}`),
        " は積 ",
        math(String.raw`(-i)(x)_{\mathbb C}`),
        " を表す。",
        ref("def_half_integer_checkZ"),
        "・",
        ref("def_half_integer_checkY"),
        " を ",
        math(String.raw`\mu_{\mathbb Z}\in\mathbb Z`),
        " で読むと、",
        math(String.raw`\check{Z}_{\mu_{\mathbb Z}} = \sum_{k=1}^{N} e_{k,\mu}Z_{k_{\mathbb Z}}`),
        "、",
        math(String.raw`\check{Y}_{\mu_{\mathbb Z}} = \sum_{k=1}^{N} e_{k,\mu}Y_{k_{\mathbb Z}}`),
        " である。",
      ]),
      paragraph([
        "準備 1（",
        math(String.raw`k \neq j`),
        " の項）。",
        math(String.raw`j, k \in \{1,\dots,N\}`),
        " なら ",
        math(String.raw`j_{\mathbb Z}, k_{\mathbb Z} \in \{1,\dots,M_{\mathrm{col}}\}`),
        " である。",
        math(String.raw`k \neq j`),
        " なら、標準包含 ",
        math(String.raw`\iota_{\mathbb N\to\mathbb Z}`),
        " は単射なので ",
        math(String.raw`j_{\mathbb Z} - k_{\mathbb Z} \neq 0`),
        "、さらに ",
        math(String.raw`|j_{\mathbb Z} - k_{\mathbb Z}| \leq M_{\mathrm{col}} - 1 < M_{\mathrm{col}}`),
        " である。したがって ",
        math(String.raw`A \in \mathrm{Mat}(2^{N},\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sum_{\mu=1}^{N}\exp\!\left(i\,((j_{\mathbb Z}-k_{\mathbb Z})_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)A
&= 0_{\mathbb C}\,A
&&\bigl(\because\ \blkref{antiperiodic_exp_sum}\text{ の「とくに」を }0<|j_{\mathbb Z}-k_{\mathbb Z}|<M_{\mathrm{col}}\text{ の整数 }j_{\mathbb Z}-k_{\mathbb Z}\text{ で}\bigr) \\
&= O
&&\bigl(\because\ \blkref{zero_scalar_multiple_is_zero_matrix}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "である（",
        math(String.raw`O`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列）。",
      ]),
      paragraph([
        "準備 2（指数）。",
        math(String.raw`j, k, \mu \in \{1,\dots,N\}`),
        " について ",
        math(String.raw`x := \tilde\theta_{\mu_{\mathbb Z}} \in \mathbb R`),
        " と置く。実数の側で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
j_{\mathbb R}x + \left(-(k_{\mathbb R}x)\right)
&= j_{\mathbb R}x + \left(-k_{\mathbb R}\right)x
&&(\because\ \mathbb R\text{ で }-(ab)=(-a)b\ (a \to k_{\mathbb R},\ b \to x)) \\
&= \left(j_{\mathbb R} + \left(-k_{\mathbb R}\right)\right)x
&&(\because\ \mathbb R\text{ の分配法則}) \\
&= \left(j_{\mathbb R} - k_{\mathbb R}\right)x
&&(\because\ \mathbb R\text{ の差は加法の逆元の和}) \\
&= (j_{\mathbb Z} - k_{\mathbb Z})_{\mathbb R}\,x
&&\bigl(\because\ \iota_{\mathbb Z\to\mathbb R}\text{ は和と零を保つので差を保つ。}j_{\mathbb R}=(j_{\mathbb Z})_{\mathbb R},\ k_{\mathbb R}=(k_{\mathbb Z})_{\mathbb R}\ (\blkref{antiperiodic_exp_sum})\bigr)
\end{aligned}`,
      ),
      paragraph(["であり、複素数の側で"]),
      displayMath(
        String.raw`\begin{aligned}
i\,(j_{\mathbb R}x)_{\mathbb C} + (-i)(k_{\mathbb R}x)_{\mathbb C}
&= i\,(j_{\mathbb R}x)_{\mathbb C} + \left(-\left(i\,(k_{\mathbb R}x)_{\mathbb C}\right)\right)
&&\bigl(\because\ \blkref{negative_i_times_complex_is_negation_of_i_times}\ (z \to (k_{\mathbb R}x)_{\mathbb C})\bigr) \\
&= i\,(j_{\mathbb R}x)_{\mathbb C} + i\left(-(k_{\mathbb R}x)\right)_{\mathbb C}
&&\bigl(\because\ \blkref{i_times_negated_real_is_negation_of_i_times}\ (\theta \to k_{\mathbb R}x)\text{ を右辺から左辺へ}\bigr) \\
&= i\left((j_{\mathbb R}x)_{\mathbb C} + \left(-(k_{\mathbb R}x)\right)_{\mathbb C}\right)
&&(\because\ \mathbb C\text{ の分配法則。}\blkref{complex_numbers_form_a_field}) \\
&= i\left(j_{\mathbb R}x + \left(-(k_{\mathbb R}x)\right)\right)_{\mathbb C}
&&\bigl(\because\ \blkref{real_inclusion_preserves_sum}\ (a \to j_{\mathbb R}x,\ b \to -(k_{\mathbb R}x))\bigr) \\
&= i\left((j_{\mathbb Z} - k_{\mathbb Z})_{\mathbb R}\,x\right)_{\mathbb C}
&&(\because\ \text{直前の実数の鎖})
\end{aligned}`,
      ),
      paragraph(["である。"]),
      paragraph(["第 1 式。主張の左辺から"]),
      displayMath(
        String.raw`\begin{aligned}
c\sum_{\mu=1}^{N} f_{j,\mu}\check{Z}_{\mu_{\mathbb Z}}
&= c\sum_{\mu=1}^{N} f_{j,\mu}\left(\sum_{k=1}^{N} e_{k,\mu}Z_{k_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{def_half_integer_checkZ}\text{ を }N\text{ 個の項へ同時適用}\bigr) \\
&= c\sum_{\mu=1}^{N}\sum_{k=1}^{N} f_{j,\mu}\left(e_{k,\mu}Z_{k_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{finite_sum_of_scalar_multiples}\text{ を右辺から左辺へ、各 }\mu\text{ へ同時適用}\bigr) \\
&= c\sum_{\mu=1}^{N}\sum_{k=1}^{N} \left(f_{j,\mu}e_{k,\mu}\right)Z_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\text{ を }N^2\text{ 個の項へ同時適用}\bigr) \\
&= c\sum_{k=1}^{N}\sum_{\mu=1}^{N} \left(f_{j,\mu}e_{k,\mu}\right)Z_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{finite_double_sum_of_matrices_interchange}\ (r=s=N)\bigr) \\
&= c\sum_{k=1}^{N}\left(\sum_{\mu=1}^{N} f_{j,\mu}e_{k,\mu}\right)Z_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\text{ を各 }k\text{ へ同時適用}\bigr) \\
&= c\sum_{k=1}^{N}\left(\sum_{\mu=1}^{N} \exp\!\left(i\,(j_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C} + (-i)(k_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Z_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_exp_product}\text{ を }K=\mathbb C\text{ で }N^2\text{ 個の項へ同時適用}\bigr) \\
&= c\sum_{k=1}^{N}\left(\sum_{\mu=1}^{N} \exp\!\left(i\,((j_{\mathbb Z}-k_{\mathbb Z})_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Z_{k_{\mathbb Z}}
&&(\because\ \text{準備 2 の複素数の鎖を全ての }(k,\mu)\text{ へ同時適用}) \\
&= c\left(\left(\sum_{\mu=1}^{N} \exp\!\left(i\,((j_{\mathbb Z}-j_{\mathbb Z})_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Z_{j_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_with_single_nonzero_term}\ (q=j)\text{。}k\neq j\text{ の項は準備 1 の鎖（}A=Z_{k_{\mathbb Z}}\text{）で }O\bigr) \\
&= c\left(\left(\sum_{\mu=1}^{N} \exp\!\left(i\,((0)_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Z_{j_{\mathbb Z}}\right)
&&(\because\ \mathbb Z\text{ で }j_{\mathbb Z}-j_{\mathbb Z}=0) \\
&= c\left((M_{\mathrm{col}})_{\mathbb C}\,Z_{j_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{antiperiodic_exp_sum}\text{ の「とくに」を整数 }0\text{ で}\bigr) \\
&= \left(c\,(M_{\mathrm{col}})_{\mathbb C}\right)Z_{j_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr) \\
&= 1_{\mathbb C}\,Z_{j_{\mathbb Z}}
&&\bigl(\because\ c\text{ は }(M_{\mathrm{col}})_{\mathbb C}\text{ の逆元。}\blkref{complex_numbers_form_a_field}\bigr) \\
&= Z_{j_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)
\end{aligned}`,
      ),
      paragraph(["第 2 式。主張の左辺から"]),
      displayMath(
        String.raw`\begin{aligned}
c\sum_{\mu=1}^{N} f_{j,\mu}\check{Y}_{\mu_{\mathbb Z}}
&= c\sum_{\mu=1}^{N} f_{j,\mu}\left(\sum_{k=1}^{N} e_{k,\mu}Y_{k_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{def_half_integer_checkY}\text{ を }N\text{ 個の項へ同時適用}\bigr) \\
&= c\sum_{\mu=1}^{N}\sum_{k=1}^{N} f_{j,\mu}\left(e_{k,\mu}Y_{k_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{finite_sum_of_scalar_multiples}\text{ を右辺から左辺へ、各 }\mu\text{ へ同時適用}\bigr) \\
&= c\sum_{\mu=1}^{N}\sum_{k=1}^{N} \left(f_{j,\mu}e_{k,\mu}\right)Y_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\text{ を }N^2\text{ 個の項へ同時適用}\bigr) \\
&= c\sum_{k=1}^{N}\sum_{\mu=1}^{N} \left(f_{j,\mu}e_{k,\mu}\right)Y_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{finite_double_sum_of_matrices_interchange}\ (r=s=N)\bigr) \\
&= c\sum_{k=1}^{N}\left(\sum_{\mu=1}^{N} f_{j,\mu}e_{k,\mu}\right)Y_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\text{ を各 }k\text{ へ同時適用}\bigr) \\
&= c\sum_{k=1}^{N}\left(\sum_{\mu=1}^{N} \exp\!\left(i\,(j_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C} + (-i)(k_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Y_{k_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_exp_product}\text{ を }K=\mathbb C\text{ で }N^2\text{ 個の項へ同時適用}\bigr) \\
&= c\sum_{k=1}^{N}\left(\sum_{\mu=1}^{N} \exp\!\left(i\,((j_{\mathbb Z}-k_{\mathbb Z})_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Y_{k_{\mathbb Z}}
&&(\because\ \text{準備 2 の複素数の鎖を全ての }(k,\mu)\text{ へ同時適用}) \\
&= c\left(\left(\sum_{\mu=1}^{N} \exp\!\left(i\,((j_{\mathbb Z}-j_{\mathbb Z})_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Y_{j_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_with_single_nonzero_term}\ (q=j)\text{。}k\neq j\text{ の項は準備 1 の鎖（}A=Y_{k_{\mathbb Z}}\text{）で }O\bigr) \\
&= c\left(\left(\sum_{\mu=1}^{N} \exp\!\left(i\,((0)_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right)\right)Y_{j_{\mathbb Z}}\right)
&&(\because\ \mathbb Z\text{ で }j_{\mathbb Z}-j_{\mathbb Z}=0) \\
&= c\left((M_{\mathrm{col}})_{\mathbb C}\,Y_{j_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{antiperiodic_exp_sum}\text{ の「とくに」を整数 }0\text{ で}\bigr) \\
&= \left(c\,(M_{\mathrm{col}})_{\mathbb C}\right)Y_{j_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr) \\
&= 1_{\mathbb C}\,Y_{j_{\mathbb Z}}
&&\bigl(\because\ c\text{ は }(M_{\mathrm{col}})_{\mathbb C}\text{ の逆元。}\blkref{complex_numbers_form_a_field}\bigr) \\
&= Y_{j_{\mathbb Z}}
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "生成について。",
        math(String.raw`T`),
        " を主張の部分集合とし、",
        math(String.raw`j \in \{1,\dots,N\}`),
        " を取る。",
        ref("Z_Y_generate_algebra"),
        " の (iii) のスカラー倍により ",
        math(String.raw`f_{j,\mu}\check{Z}_{\mu_{\mathbb Z}} \in T`),
        "、(iii) の和を ",
        ref("def_finite_sum_of_matrices"),
        " の帰納法の各段へ適用して ",
        math(String.raw`\sum_{\mu=1}^{N} f_{j,\mu}\check{Z}_{\mu_{\mathbb Z}} \in T`),
        "、もう一度 (iii) のスカラー倍により ",
        math(String.raw`c\sum_{\mu=1}^{N} f_{j,\mu}\check{Z}_{\mu_{\mathbb Z}} \in T`),
        " であり、第 1 式によりこれは ",
        math(String.raw`Z_{j_{\mathbb Z}}`),
        " である。同じく第 2 式により ",
        math(String.raw`Y_{j_{\mathbb Z}} \in T`),
        " である。",
        math(String.raw`1 \leq l \leq M_{\mathrm{col}}`),
        " の整数 ",
        math(String.raw`l`),
        " は ",
        math(String.raw`l = j_{\mathbb Z}`),
        " となる ",
        math(String.raw`j \in \{1,\dots,N\}`),
        " を持つ（",
        math(String.raw`N_{\mathbb Z} = M_{\mathrm{col}}`),
        "）ので、",
        ref("Z_Y_generate_algebra"),
        " の ",
        math(String.raw`S`),
        " について ",
        math(String.raw`S \subseteq T`),
        "、すなわち ",
        math(String.raw`T`),
        " は (i) も満たして閉じている。",
        ref("Z_Y_generate_algebra"),
        " の ",
        math(String.raw`\mathcal{A}`),
        " は閉じている部分集合のうち最小なので ",
        math(String.raw`\mathcal{A} \subseteq T`),
        " であり、",
        ref("Z_Y_generate_algebra"),
        " より ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2^{N},\mathbb{C})`),
        " であるから ",
        math(String.raw`\mathrm{Mat}(2^{N},\mathbb{C}) = \mathcal{A} \subseteq T \subseteq \mathrm{Mat}(2^{N},\mathbb{C})`),
        "、すなわち ",
        math(String.raw`T = \mathrm{Mat}(2^{N},\mathbb{C})`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-15 の式変形統一で、復元式の鎖の最終行へスカラー 1/M と M の相殺という行末根拠を補った。内容は変えていない。",
        "2026-08-19 の式変形統一で、二つの displayMath と間の散文に分かれていた復元式の導出を、準備の指数和等式と一続き六段の鎖へまとめ、「Y_j についても同じ計算」と畳まれていた第 2 式を同じ形の鎖へ開いた。内容・参照は変えていない。",
        "2026-08-31 の式変形統一で、準備の散文に埋まっていた j-k=0=0M を、整数の減法と乗法を一つずつ適用する二段の鎖へ開いた。内容・参照は変えていない。",
        "2026-08-31 の式変形統一で、三本の鎖に行中の \\quad(\\because …) で置かれていた根拠 14 行を、他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・参照は変えていない。",
        "2026-11-03（全証明の SageMath 検算）: 主張に像の記号（j_Z・j_R・μ_Z）と (M_col)_C^{-1} の存在、exp・積・和の出所を書き、定義どおりスカラーを左に置いて主張の左辺から鎖を始める形にした（中身は不変）。生成の主張を Z_Y_generate_algebra の (i)〜(iv) で述べ直した。証明は、行列の theorem_exp_product (n=1) を scalar_exp_product に、名前だけの「有限和への分配」「有限和の順序交換」「k = j の項だけが残る」を finite_sum_of_scalar_multiples・新しい主張 finite_double_sum_of_matrices_interchange・finite_sum_of_matrices_with_single_nonzero_term に付け替え、指数の和を i((j_Z − k_Z)_R θ̃)_C へ書き換える準備 2 の鎖と、k ≠ j の項が O になる準備 1 の鎖を置いた。",
        "2026-11-10（Lean の通しの証明）: 準備 2 の複素数の鎖が -i の積（multiply_by_minus_one・交換律・結合律）と (-1_R)_C = -1_C をその場で開いていた 4 行を、negative_i_times_complex_is_negation_of_i_times（z → (k_R x)_C）と i_times_negated_real_is_negation_of_i_times（θ → k_R x）の参照 2 行に替えた。二項の和の像は real_inclusion_preserves_finite_sum の m = 2 から real_inclusion_preserves_sum にした（8 等号から 5 等号）。実数の鎖は左辺を j_R x + (-(k_R x)) にし、(-1_R)(k_R x) を開く 2 行を ℝ の -(yx) = (-y)x の 1 行にした（5 等号から 4 等号）。両端と第 1・2 式は不変。",
      ],
    },
  },
  {
    id: "Athetatilde_000_remark_overview",
    kind: "remark",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 2 },
    title: { tex: String.raw`A(\tilde\theta_\mu) \text{ を対角化する道筋}` },
    labels: [],
    statement: [
      paragraph([
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi(\mu-\frac12)}{M_{\mathrm{col}}}`),
        " における ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\tilde\theta_\mu)`),
        " を対角化する。",
      ]),
      paragraph([
        "議論を支えるのは、すべての ",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " とすべての ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "（臨界点 ",
        math(String.raw`\sinh 2K_1 \sinh 2K_2 = 1`),
        " を含む）について ",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " が成り立つこと（",
        ref("gamma_2_theta_tilde_nonzero"),
        "）である。したがって以下の主張はすべて**場合分けなし**で述べられる。",
      ]),
      paragraph([
        "さらに、固有値に現れる根号 ",
        math(String.raw`\sqrt{-\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)}`),
        " は正の実数 ",
        math(String.raw`\left|\gamma_2(\tilde\theta_\mu)\right|`),
        " に確定する（",
        ref("relation_of_gamma_2_theta_tilde"),
        "）。このため複素平方根の分枝を論じる必要がなく、固有値・固有ベクトルは代入して確かめるだけで得られる。",
        "また ",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " の帰結として ",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        " が常に成り立ち、2 つの固有値は必ず分離する（",
        ref("lambda_eq_exp_gamma_theta_tilde"),
        "）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-10-31: 章立ての組み直しで、旧い章「A(θ̃_μ) の対角化」の案内文をこの章の対角化の前へ移した。題を式で指すものにし、「この章」を「以下」に直し、「半整数運動量」の語と、ψ̌ の導入へ進まないとする段落（組み直した章では ψ̌ の導入まで続くので事実に合わない）を外した。",
      ],
    },
  },
  {
    id: "Athetatilde_001_definition_gamma1_gamma2",
    kind: "definition",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 3 },
    title: { tex: String.raw`\gamma_1(\theta), \gamma_2(\theta)\ (\theta \in \mathbb{R})` },
    labels: ["def_gamma1_gamma2_of_theta"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とし、",
        math(String.raw`\theta \in \mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`\gamma_1(\theta) := c_1 c_2^* - s_1 s_2^*\cos\theta \in \mathbb{R},
\qquad
\gamma_2(\theta) := i\,\exp(i\theta) s_2^*\bigl(c_1\cos\theta - i\sin\theta - s_1 c_2\bigr) \in \mathbb{C}`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`\gamma_1(\theta)`),
        " の定義式は ",
        math(String.raw`\mathbb{R}`),
        " の式で、",
        ref("def_A_theta"),
        " の ",
        math(String.raw`(1,1)`),
        " 成分の実数と同じく読む（",
        math(String.raw`\mathbb{R}`),
        " の積は左から括った ",
        math(String.raw`(c_1 c_2^*) - \bigl((s_1 s_2^*)\cos\theta\bigr)`),
        " で、差は ",
        ref("def_real_difference"),
        " の差である）。",
        math(String.raw`\gamma_2(\theta)`),
        " の定義式は ",
        math(String.raw`\mathbb{C}`),
        " の式で、",
        ref("def_A_theta"),
        " の ",
        math(String.raw`(1,2)`),
        " 成分の式と同じく、その定義に書いた読みのすべてに従って読む（たとえば実数 ",
        math(String.raw`\theta, c_1, s_1, c_2, s_2^*, \cos\theta, \sin\theta`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の像として読んで像の記号を省き、四つの因子の積と第四の因子の差は同じく括る）。このとき ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " は",
      ]),
      displayMath(
        String.raw`A(\theta) = \begin{pmatrix}
\gamma_1(\theta) & \gamma_2(\theta) \\
-\gamma_2(-\theta) & \gamma_1(\theta)
\end{pmatrix}`,
      ),
      paragraph([
        "と書ける。右辺は ",
        math(String.raw`2`),
        " 行 ",
        math(String.raw`2`),
        " 列の複素行列で、",
        math(String.raw`(1,1)`),
        " 成分と ",
        math(String.raw`(2,2)`),
        " 成分は、",
        ref("def_A_theta"),
        " の ",
        math(String.raw`(1,1)`),
        " 成分と ",
        math(String.raw`(2,2)`),
        " 成分の読みと同じく、実数 ",
        math(String.raw`\gamma_1(\theta) \in \mathbb{R}`),
        " の ",
        ref("inclusion_rr_to_cc"),
        " による像 ",
        math(String.raw`\bigl(\gamma_1(\theta)\bigr)_{\mathbb{C}}`),
        " である（像の記号を省く）。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_A_theta"),
        " の ",
        math(String.raw`(1,1)`),
        " 成分と ",
        math(String.raw`(2,2)`),
        " 成分は、",
        ref("def_A_theta"),
        " の読みのとおり実数 ",
        math(String.raw`c_1c_2^* - s_1s_2^*\cos\theta \in \mathbb{R}`),
        " の ",
        ref("inclusion_rr_to_cc"),
        " による像であり、この実数は本ブロックの定義により ",
        math(String.raw`\gamma_1(\theta)`),
        " なので、像は ",
        math(String.raw`\bigl(\gamma_1(\theta)\bigr)_{\mathbb{C}}`),
        " である。",
        math(String.raw`(1,2)`),
        " 成分は ",
        math(String.raw`i\exp(i\theta)s_2^*(c_1\cos\theta - i\sin\theta - s_1c_2) = \gamma_2(\theta)`),
        " である（両辺は同じ読みの ",
        math(String.raw`\mathbb{C}`),
        " の式である）。どちらも定義そのものである。",
      ]),
      paragraph([
        math(String.raw`(2,1)`),
        " 成分を示す。実数 ",
        math(String.raw`\theta, -\theta, c_1, s_1, c_2, s_2^*, \cos\theta, \sin\theta, \cos(-\theta), \sin(-\theta)`),
        " が ",
        math(String.raw`\mathbb{C}`),
        " の式に現れるときは ",
        ref("inclusion_rr_to_cc"),
        " の像として読み、像の記号を省く（",
        math(String.raw`i(-\theta)`),
        " は ",
        math(String.raw`i(-\theta)_{\mathbb{C}}`),
        "、",
        math(String.raw`\cos(-\theta)`),
        " は ",
        math(String.raw`(\cos(-\theta))_{\mathbb{C}}`),
        " である）。",
        math(String.raw`-\theta \in \mathbb{R}`),
        " なので本ブロックの ",
        math(String.raw`\gamma_2`),
        " の定義式を ",
        math(String.raw`-\theta`),
        " にも適用できる。",
        math(String.raw`\exp(-i\theta)`),
        " の ",
        math(String.raw`-i\theta`),
        " は ",
        ref("euler_formula_cos_sin"),
        " の読みのとおり ",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-(i\theta)`),
        " である。",
        ref("def_A_theta"),
        " の ",
        math(String.raw`(2,1)`),
        " 成分は、その定義に書いた読みのとおり、先頭の ",
        math(String.raw`-i`),
        " を ",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-i`),
        " とし、四つの因子の積を左から順に括ったものである。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(-\theta)
&= i\,\exp(i(-\theta))s_2^*\bigl(c_1\cos(-\theta) - i\sin(-\theta) - s_1c_2\bigr)
   &&(\because \text{本ブロックの } \gamma_2 \text{ の定義式を } -\theta \text{ に適用}) \\
&= i\,\exp(-i\theta)s_2^*\bigl(c_1\cos(-\theta) - i\sin(-\theta) - s_1c_2\bigr)
   &&(\because \blkref{i_times_negated_real_is_negation_of_i_times}) \\
&= i\,\exp(-i\theta)s_2^*\bigl(c_1\cos\theta - i\sin(-\theta) - s_1c_2\bigr)
   &&(\because \blkref{cos_of_negated_real}) \\
&= i\,\exp(-i\theta)s_2^*\bigl(c_1\cos\theta - i(-\sin\theta) - s_1c_2\bigr)
   &&(\because \blkref{sin_of_negated_real}) \\
&= i\,\exp(-i\theta)s_2^*\Bigl(c_1\cos\theta - \bigl(-(i\sin\theta)\bigr) - s_1c_2\Bigr)
   &&\bigl(\because\ \mathbb{C}\ \text{で}\ x(-y) = -(xy)\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ x \to i,\ y \to \sin\theta\bigr) \\
&= i\,\exp(-i\theta)s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)
   &&\bigl(\because\ \mathbb{C}\ \text{で}\ a - (-b) = a + b\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ a \to c_1\cos\theta,\ b \to i\sin\theta\bigr)
\end{aligned}`,
      ),
      paragraph([
        "これを使って、",
        ref("def_A_theta"),
        " の ",
        math(String.raw`(2,1)`),
        " 成分は次のとおり。",
        math(String.raw`P := c_1\cos\theta + i\sin\theta - s_1c_2 \in \mathbb{C}`),
        " と略記する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A(\theta)_{2,1}
&= \Bigl(\bigl((-i)\exp(-i\theta)\bigr)s_2^*\Bigr)P
   &&(\because \blkref{def_A_theta}) \\
&= \Bigl(\bigl(-(i\exp(-i\theta))\bigr)s_2^*\Bigr)P
   &&\bigl(\because \blkref{negative_i_times_complex_is_negation_of_i_times}\ (z \to \exp(-i\theta))\bigr) \\
&= \Bigl(-\bigl((i\exp(-i\theta))s_2^*\bigr)\Bigr)P
   &&\bigl(\because\ \mathbb{C}\ \text{で}\ (-x)y = -(xy)\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ x \to i\exp(-i\theta),\ y \to s_2^*\bigr) \\
&= -\Bigl(\bigl((i\exp(-i\theta))s_2^*\bigr)P\Bigr)
   &&\bigl(\because\ \mathbb{C}\ \text{で}\ (-x)y = -(xy)\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ x \to (i\exp(-i\theta))s_2^*,\ y \to P\bigr) \\
&= -\gamma_2(-\theta)
   &&(\because \text{上の } \gamma_2(-\theta) \text{ の鎖を右辺から左辺へ})
\end{aligned}`,
      ),
      paragraph(["となる。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の TV1_hatZ_hatY_020_definition_gamma1_gamma2 が同じ 2 つの量を θ_μ（整数運動量）に限って導入しているが、" +
          "そのブロックにはラベルが無く参照できない。半整数運動量 θ~_μ でも同じ式を使うので、ここで θ ∈ R の関数として" +
          "ラベル付きで定義し直した（式は 008 章のものと文字どおり同一。A(θ) 自体は def_A_theta を再定義していない）。",
        "2026-11-09（Lean の通しの証明）: (2,1) 成分の鎖が、後ろのブロック relation_of_gamma_2_theta_tilde の証明の中で作る i(-θ) = -iθ・cos(-θ) = cos θ・sin(-θ) = -sin θ を参照なしに根拠にし、" +
          "sin(-θ) の行が x(-y) = -(xy) と a - (-b) = a + b の 2 段をまとめていた。3 つの等式を主張 i_times_negated_real_is_negation_of_i_times・cos_of_negated_real・sin_of_negated_real として前へ出して引き、" +
          "まとめていた行を 3 行に割った。A(θ)_{2,1} の鎖は、def_A_theta の先頭の -i を multiply_by_minus_one の -i と読み、積を左から括ることを書いて、" +
          "negative_i_times_complex_is_negation_of_i_times と (-x)y = -(xy) の 2 回で -γ_2(-θ) へ着く 5 行にした（以前は「直前の式」の 1 行）。主張は変えていない。",
        "2026-11-09（Lean の通しの証明）: def_A_theta の (2,1) 成分の先頭の -i の読みと積の括り方を def_A_theta の定義に移し、この証明ではその読みを引くだけにした。鎖は変えていない。",
        "2026-11-10（Lean の通しの証明）: 主張の行列の (1,1)・(2,2) 成分を実数 γ_1(θ) のまま書いていたので、def_A_theta の読みと同じく γ_1(θ) の inclusion_rr_to_cc による像であることを主張に書き、γ_1・γ_2 の定義式の読みを def_A_theta の (1,1) 成分の実数・(1,2) 成分の式の読みへの参照にした。証明の 1 段落目も同じ読みで書いた。主張は変えていない。",
      ],
    },
  },
  {
    id: "freeenergy_001_claim_gamma1_lower_bound_all_theta",
    kind: "claim",
    origin: { path: "structured-latex/content/012_free_energy.ts", ordinal: 3 },
    title: { tex: String.raw`\gamma_1(\theta) \geq \cosh(2K_1 - 2K_2^*) \geq 1 \quad (\forall\theta\in\mathbb{R})` },
    labels: ["gamma1_lower_bound_all_theta"],
    statement: [
      paragraph([
        ref("def_gamma1_gamma2_of_theta"),
        " の ",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*\cos\theta`),
        " を**すべての実数** ",
        math(String.raw`\theta`),
        " について考える。このとき",
      ]),
      displayMath(
        String.raw`\gamma_1(\theta) \geq \cosh\left(2K_1 - 2K_2^*\right) \geq 1
\qquad (\forall \theta \in \mathbb{R})`,
      ),
      paragraph([
        "が成り立つ。証明は全実数上の ",
        math(String.raw`\cos`),
        " の性質 ",
        math(String.raw`\cos\theta \leq 1\ (\theta \in \mathbb{R})`),
        " を前提とする（本文の ",
        ref("cosine_at_most_one"),
        " は ",
        math(String.raw`\theta \in [-\pi/2, \pi/2]`),
        " に限る）。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        ref("def_gamma1_gamma2_of_theta"),
        " より ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " である。",
        ref("def_first_dual_coupling_constant"),
        "・",
        ref("def_second_dual_coupling_constant"),
        " より ",
        math(String.raw`K_1^*, K_2^* \in \mathbb{R}_{>0}`),
        " である。したがって ",
        ref("indexed_hyperbolic_abbreviations_positive"),
        " より ",
        math(String.raw`c_1, s_1, c_2^*, s_2^* \in \mathbb{R}`),
        "、",
        math(String.raw`s_1 > 0`),
        "、",
        math(String.raw`s_2^* > 0`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_1s_2^* &> 0\cdot s_2^*
&&(\because\ s_1>0\ \text{の両辺に}\ s_2^*>0\ \text{を掛ける})\\
&= 0
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{との積は}\ 0)
\end{aligned}`,
      ),
      paragraph([
        "である。さらに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\cos\theta \leq 1
&\Longrightarrow s_1s_2^*\cos\theta \leq s_1s_2^*\cdot 1
&&(\because\ \text{両辺に}\ s_1s_2^*>0\ \text{を掛ける})\\
&\Longrightarrow -s_1s_2^*\cdot 1 \leq -s_1s_2^*\cos\theta
&&(\because\ \text{両辺に}\ -1<0\ \text{を掛ける。向きが変わる})
\end{aligned}`,
      ),
      paragraph([
        "であり、左端の ",
        math(String.raw`\cos\theta \leq 1`),
        " は主張の前提である。以下で ",
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\cosh`),
        "・",
        math(String.raw`\sinh`),
        " の値が実数の exp の値、すなわち部分和の極限だからであり、",
        math(String.raw`\cos\theta`),
        " が全実数上の実数値関数の値だからである。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_1(\theta)
&= c_1c_2^* - s_1s_2^*\cos\theta
&&(\because\ \blkref{def_gamma1_gamma2_of_theta})\\
&\geq c_1c_2^* - s_1s_2^*\cdot 1
&&(\because\ \text{準備の}\ -s_1s_2^*\cdot 1 \leq -s_1s_2^*\cos\theta\ \text{の両辺に}\ c_1c_2^*\ \text{を加える})\\
&= c_1c_2^* - s_1s_2^*
&&(\because\ \mathbb{R}\ \text{では}\ 1\ \text{は積の単位元})\\
&= \cosh 2K_1\cosh 2K_2^* - \sinh 2K_1\sinh 2K_2^*
&&(\because\ \blkref{def_indexed_hyperbolic_abbreviations})\\
&= \cosh\left(2K_1-2K_2^*\right)
&&(\because\ \blkref{cosh_addition_formula}\ \text{の複号}\ -\ \text{を}\ x=2K_1,\ y=2K_2^*\ \text{に適用})\\
&\geq 1
&&(\because\ \blkref{cosh_at_least_one}\ \text{を}\ x=2K_1-2K_2^*\ \text{に適用})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-18: 式変形の書き方を統一した。加法定理の適用と cosθ≤1 による評価が" +
          "散文で継がれた 2 つの表示に分かれていたのを、γ_1(θ) から 1 までの一続きの鎖にし、" +
          "根拠を行末の (∵ …) へ揃えた。引いていた根拠（加法定理・K_1,K_2^*>0・cosh≥1）は" +
          "すべて行末と直後の参照に残した。段は増えており、減った段は無い。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-10-31: statement の中で定めていた γ(θ) := arccosh(γ_1(θ))（θ∈ℝ）と、証明の末尾のその well-defined 性の文を、" +
          "独立した定義 def_gamma_theta へ移した（1 ブロック 1 主張）。不等式の主張と証明は変えていない。" +
          "γ_1 の出典を、γ_1 を定めていない def_A_theta から def_gamma1_gamma2_of_theta に直し、そのためにこのブロックを def_gamma1_gamma2_of_theta の直後へ移した。",
        "2026-11-03: SageMath の検算（sagemath/check/gamma1_lower_bound_all_theta/）に合わせて根拠を各行から引く形にした。" +
          "s_1, s_2^* > 0 の出典を双対結合定数の正値性と indexed_hyperbolic_abbreviations_positive に、s_1s_2^* > 0 を鎖に、" +
          "略記を双曲線関数へ戻す行を def_indexed_hyperbolic_abbreviations で足し、名前だけの「加法定理」「cosh は 1 以上」を " +
          "cosh_addition_formula・cosh_at_least_one への参照にし、末尾の参照の一覧を外した。cos θ ≤ 1 による評価を準備の一操作ずつの含意に分け、" +
          "全実数上の cos の性質 cos θ ≤ 1 を前提とすることを主張に書いた（不等式の中身は変えていない）。",
      ],
    },
  },
  {
    id: "Athetatilde_001b_definition_gamma_theta",
    kind: "definition",
    origin: { path: "structured-latex/content/012_free_energy.ts", ordinal: 3 },
    title: { tex: String.raw`\gamma(\theta)\ (\theta \in \mathbb{R}) \text{ の定義}` },
    labels: ["def_gamma_theta"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とし、",
        math(String.raw`\theta \in \mathbb{R}`),
        " について ",
        ref("def_gamma1_gamma2_of_theta"),
        " の ",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*\cos\theta \in \mathbb{R}`),
        " を考える。",
        ref("gamma1_lower_bound_all_theta"),
        " より ",
        math(String.raw`\gamma_1(\theta) \geq 1`),
        " であり、",
      ]),
      displayMath(
        String.raw`\gamma(\theta) := \mathrm{arccosh}\left(\gamma_1(\theta)\right) \in \mathbb{R}_{\geq 0}`,
      ),
      paragraph([
        "と定める。ここで ",
        math(String.raw`\mathrm{arccosh}(y)`),
        "（",
        math(String.raw`y \geq 1`),
        "）は ",
        math(String.raw`\cosh t = y`),
        " を満たす唯一の ",
        math(String.raw`t \in \mathbb{R}_{\geq 0}`),
        " である（",
        ref("def_arccosh"),
        "、",
        ref("arccosh_properties"),
        " (1)–(3)）。とくに ",
        math(String.raw`\cosh\gamma(\theta) = \gamma_1(\theta)`),
        " である（",
        ref("arccosh_properties"),
        " (2)）。",
      ]),
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について ",
        math(String.raw`\tilde\theta_\mu \in \mathbb{R}`),
        "（",
        ref("antiperiodic_exp_sum"),
        "）であり、",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        " はこの ",
        math(String.raw`\gamma`),
        " の ",
        math(String.raw`\theta = \tilde\theta_\mu`),
        " での値を表す。",
      ]),
    ],
    proof: [],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: gamma1_lower_bound_all_theta の statement の中で定めていた γ(θ) := arccosh(γ_1(θ))（θ∈ℝ）と、" +
          "旧ラベル def_gamma_theta_tilde_mu の γ(θ~_μ) := arccosh(γ_1(θ~_μ)) を、この一つの定義へまとめた（1 ブロック 1 主張）。" +
          "そのブロックには γ(θ~_μ) > 0 の主張だけを残し、ラベルを gamma_theta_tilde_mu_positive に改めた。式は両者のものと文字どおり同一である。",
      ],
    },
  },
  {
    id: "Athetatilde_002_claim_gamma2_nonzero",
    kind: "claim",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 4 },
    title: { tex: String.raw`\gamma_2(\tilde\theta_\mu) \neq 0 \text{（例外なし）}` },
    labels: ["gamma_2_theta_tilde_nonzero"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi(\mu-\frac12)}{M_{\mathrm{col}}}`),
        " について、**すべての ",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " と、すべての ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "（臨界点 ",
        math(String.raw`\sinh 2K_1 \sinh 2K_2 = 1`),
        " を含む）について**",
      ]),
      displayMath(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0_{\mathbb{C}}`),
      paragraph(["が成り立つ。", math(String.raw`\gamma_2(-\tilde\theta_\mu)`), " の非零性は、後で共役関係から導く。"]),
    ],
    proof: [
      paragraph([
        "Step 0（正値性）。",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " から、",
        ref("def_first_dual_coupling_constant"),
        "・",
        ref("def_second_dual_coupling_constant"),
        "・",
        ref("indexed_hyperbolic_abbreviations_positive"),
        " により次が従う。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&K_1^* \in \mathbb{R}_{>0}
   \quad (\because\ \blkref{def_first_dual_coupling_constant}\text{ と }K_1 \in \mathbb{R}_{>0}) \\
&K_2^* \in \mathbb{R}_{>0}
   \quad (\because\ \blkref{def_second_dual_coupling_constant}\text{ と }K_2 \in \mathbb{R}_{>0}) \\
&c_1 > 0
   \quad (\because\ \blkref{indexed_hyperbolic_abbreviations_positive}\text{ を }i=1\text{ に適用。}K_1 \in \mathbb{R}_{>0}) \\
&s_1 > 0
   \quad (\because\ \blkref{indexed_hyperbolic_abbreviations_positive}\text{ を }i=1\text{ に適用。}K_1 \in \mathbb{R}_{>0}) \\
&c_2 > 0
   \quad (\because\ \blkref{indexed_hyperbolic_abbreviations_positive}\text{ を }i=2\text{ に適用。}K_2 \in \mathbb{R}_{>0}) \\
&s_2^* > 0
   \quad (\because\ \blkref{indexed_hyperbolic_abbreviations_positive}\text{ を }i=2\text{ に適用。}K_2^* \in \mathbb{R}_{>0})
\end{aligned}`,
      ),
      paragraph([
        "Step 1（零点の必要条件）。",
        math(String.raw`\theta \in \mathbb{R}`),
        " について、",
        ref("def_gamma1_gamma2_of_theta"),
        " の定義式の実数 ",
        math(String.raw`c_1, s_1, c_2, s_2^*, \cos\theta, \sin\theta`),
        " を ",
        ref("inclusion_rr_to_cc"),
        " の像として読み、次の三つの複素数を置く。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a(\theta) &:= i\,\exp(i\theta)\,(s_2^*)_{\mathbb{C}} \in \mathbb{C}, \\
b(\theta) &:= (-i)\,\exp(-i\theta)\,\bigl((s_2^*)^{-1}\bigr)_{\mathbb{C}} \in \mathbb{C}, \\
w(\theta) &:= (c_1)_{\mathbb{C}}(\cos\theta)_{\mathbb{C}} - i\,(\sin\theta)_{\mathbb{C}} - (s_1)_{\mathbb{C}}(c_2)_{\mathbb{C}} \in \mathbb{C}
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`(s_2^*)^{-1} \in \mathbb{R}`),
        " は Step 0 の ",
        math(String.raw`s_2^* > 0`),
        " から定まる。）まず ",
        math(String.raw`w(\theta)`),
        " の成分を求めておく。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
w(\theta)
&= (c_1,0)(\cos\theta,0) + (-1,0)\bigl((0,1)(\sin\theta,0)\bigr) + (-1,0)\bigl((s_1,0)(c_2,0)\bigr)
   \quad (\because w(\theta)\text{ の定義、}\blkref{inclusion_rr_to_cc}\text{、}\blkref{def_imaginary_unit}\ (i = (0,1))\text{、}\blkref{def_complex_difference}\text{、}\blkref{multiply_by_minus_one}) \\
&= (c_1\cos\theta, 0) + (-1,0)(0, \sin\theta) + (-1,0)(s_1c_2, 0)
   \quad (\because \blkref{definition_of_cc}\text{ の積を三か所に}) \\
&= (c_1\cos\theta, 0) + (0, -\sin\theta) + (-s_1c_2, 0)
   \quad (\because \blkref{definition_of_cc}\text{ の積を二か所に}) \\
&= (c_1\cos\theta - s_1c_2,\ -\sin\theta)
   \quad (\because \blkref{definition_of_cc}\text{ の和})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`b(\theta)`),
        " は ",
        math(String.raw`a(\theta)`),
        " の逆元である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a(\theta)\,b(\theta)
&= \bigl(i\,\exp(i\theta)\,(s_2^*)_{\mathbb{C}}\bigr)\bigl((-i)\,\exp(-i\theta)\,((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because a(\theta), b(\theta) \text{ の定義}) \\
&= \bigl(i(-i)\bigr)\bigl(\exp(i\theta)\exp(-i\theta)\bigr)\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because \mathbb{C} \text{ の積の結合律と可換律。}\blkref{complex_numbers_form_a_field}) \\
&= \bigl(i\,((-1_{\mathbb{C}})\,i)\bigr)\bigl(\exp(i\theta)\exp(-i\theta)\bigr)\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because \blkref{multiply_by_minus_one}\text{ の } -i := (-1_{\mathbb{C}})\,i) \\
&= \bigl((-1_{\mathbb{C}})(i\,i)\bigr)\bigl(\exp(i\theta)\exp(-i\theta)\bigr)\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because \mathbb{C} \text{ の積の結合律と可換律。}\blkref{complex_numbers_form_a_field}) \\
&= \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)\bigl(\exp(i\theta)\exp(-i\theta)\bigr)\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because \blkref{definition_of_cc}\text{ の積で } (0,1)(0,1) = (-1,0)) \\
&= 1_{\mathbb{C}}\bigl(\exp(i\theta)\exp(-i\theta)\bigr)\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because \blkref{definition_of_cc}\text{ の積で } (-1,0)(-1,0) = (1,0)) \\
&= 1_{\mathbb{C}}\exp\bigl(i\theta + (-i\theta)\bigr)\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because \blkref{scalar_exp_product}\text{ を }K = \mathbb{C}\text{ で}) \\
&= 1_{\mathbb{C}}\exp(0_{\mathbb{C}})\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because i\theta + (-i\theta) = 0_{\mathbb{C}}) \\
&= 1_{\mathbb{C}}1_{\mathbb{C}}\bigl((s_2^*)_{\mathbb{C}}((s_2^*)^{-1})_{\mathbb{C}}\bigr)
   \quad (\because \blkref{scalar_exp_zero}\text{ を }K = \mathbb{C}\text{ で}) \\
&= 1_{\mathbb{C}}1_{\mathbb{C}}\bigl(s_2^*(s_2^*)^{-1}\bigr)_{\mathbb{C}}
   \quad (\because \blkref{real_inclusion_preserves_product}) \\
&= 1_{\mathbb{C}}1_{\mathbb{C}}(1)_{\mathbb{C}}
   \quad (\because s_2^*(s_2^*)^{-1} = 1) \\
&= 1_{\mathbb{C}}1_{\mathbb{C}}1_{\mathbb{C}}
   \quad (\because \blkref{inclusion_rr_to_cc}\text{ の略記 } 1_{\mathbb{C}} = (1)_{\mathbb{C}}) \\
&= 1_{\mathbb{C}}
   \quad (\because 1_{\mathbb{C}} \text{ は積の単位元。}\blkref{complex_numbers_form_a_field})
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`a(\theta) \neq 0_{\mathbb{C}}`),
        " である。実際 ",
        math(String.raw`a(\theta) = 0_{\mathbb{C}}`),
        " と仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
1_{\mathbb{C}}
&= a(\theta)\,b(\theta)
   \quad (\because \text{直前の鎖}) \\
&= 0_{\mathbb{C}}\,b(\theta)
   \quad (\because \text{仮定 } a(\theta) = 0_{\mathbb{C}}) \\
&= 0_{\mathbb{C}}
   \quad (\because \blkref{complex_zero_times_is_zero})
\end{aligned}`,
      ),
      paragraph([
        "となり、",
        math(String.raw`1_{\mathbb{C}} \neq 0_{\mathbb{C}}`),
        "（",
        ref("complex_numbers_form_a_field"),
        "）に反する。",
        math(String.raw`a(\theta)\,w(\theta) = 0_{\mathbb{C}}`),
        " と ",
        math(String.raw`w(\theta) = 0_{\mathbb{C}}`),
        " は同値である。前者を仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
w(\theta)
&= 1_{\mathbb{C}}\,w(\theta)
   \quad (\because 1_{\mathbb{C}} \text{ は積の単位元。}\blkref{complex_numbers_form_a_field}) \\
&= \bigl(b(\theta)\,a(\theta)\bigr)\,w(\theta)
   \quad (\because \text{逆元の鎖と積の可換律。}\blkref{complex_numbers_form_a_field}) \\
&= b(\theta)\,\bigl(a(\theta)\,w(\theta)\bigr)
   \quad (\because \text{積の結合律。}\blkref{complex_numbers_form_a_field}) \\
&= b(\theta)\,0_{\mathbb{C}}
   \quad (\because \text{仮定 } a(\theta)\,w(\theta) = 0_{\mathbb{C}}) \\
&= 0_{\mathbb{C}}\,b(\theta)
   \quad (\because \text{積の可換律。}\blkref{complex_numbers_form_a_field}) \\
&= 0_{\mathbb{C}}
   \quad (\because \blkref{complex_zero_times_is_zero})
\end{aligned}`,
      ),
      paragraph(["であり、後者を仮定すると"]),
      displayMath(
        String.raw`\begin{aligned}
a(\theta)\,w(\theta)
&= a(\theta)\,0_{\mathbb{C}}
   \quad (\because \text{仮定 } w(\theta) = 0_{\mathbb{C}}) \\
&= 0_{\mathbb{C}}\,a(\theta)
   \quad (\because \text{積の可換律。}\blkref{complex_numbers_form_a_field}) \\
&= 0_{\mathbb{C}}
   \quad (\because \blkref{complex_zero_times_is_zero})
\end{aligned}`,
      ),
      paragraph(["である。したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\gamma_2(\theta) = 0_{\mathbb{C}}
&\iff a(\theta)\,w(\theta) = 0_{\mathbb{C}}
   \quad (\because \blkref{def_gamma1_gamma2_of_theta}\text{ の定義式を積の結合律で括り直す}) \\
&\iff w(\theta) = 0_{\mathbb{C}}
   \quad (\because \text{直前の二つの鎖}) \\
&\iff \bigl(c_1\cos\theta - s_1c_2,\ -\sin\theta\bigr) = (0, 0)
   \quad (\because \text{準備の } w(\theta) \text{ の成分の鎖と、}\blkref{inclusion_rr_to_cc}\text{ の } 0_{\mathbb{C}} = (0,0)) \\
&\iff \begin{cases} c_1\cos\theta - s_1c_2 = 0 \\ -\sin\theta = 0 \end{cases}
   \quad (\because \mathbf{R}^2 \text{ の元の相等は成分ごと}) \\
&\iff \begin{cases} c_1\cos\theta = s_1c_2 \\ -\sin\theta = 0 \end{cases}
   \quad (\because \text{第 1 式の両辺に } s_1c_2 \text{ を加える}) \\
&\iff \begin{cases} c_1\cos\theta = s_1c_2 \\ \sin\theta = 0 \end{cases}
   \quad (\because \text{第 2 式の両辺を } -1 \text{ 倍する})
\end{aligned}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`\sin\tilde\theta_\mu = 0`),
        " が要求すること）。",
        math(String.raw`\theta = \tilde\theta_\mu`),
        " とする。実数 ",
        math(String.raw`t`),
        " に対する ",
        math(String.raw`\sin t = 0 \iff \exists k\in\mathbb{Z}: t = k\pi`),
        " と ",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi(\mu-\frac12)}{M_{\mathrm{col}}}`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sin\tilde\theta_\mu = 0
&\iff \exists k \in \mathbb{Z}:\ \tilde\theta_\mu = k\pi
   \quad (\because \sin t = 0 \iff \exists k \in \mathbb{Z}:\ t = k\pi) \\
&\iff \exists k \in \mathbb{Z}:\ \frac{2\pi\left(\mu-\frac12\right)}{M_{\mathrm{col}}} = k\pi
   \quad (\because \blkref{antiperiodic_exp_sum}\text{ の定義}) \\
&\iff \exists k \in \mathbb{Z}:\ \frac{2\left(\mu-\frac12\right)}{M_{\mathrm{col}}} = k
   \quad (\because \text{両辺を } \pi > 0\ (\blkref{pi_is_positive}) \text{ で割る}) \\
&\iff \exists k \in \mathbb{Z}:\ 2\left(\mu - \tfrac12\right) = kM_{\mathrm{col}}
   \quad (\because \text{両辺を } M_{\mathrm{col}} \neq 0 \text{ 倍する}) \\
&\iff \exists k \in \mathbb{Z}:\ 2\mu - 1 = kM_{\mathrm{col}}
   \quad (\because \text{分配則 } 2\left(\mu-\tfrac12\right) = 2\mu - 1)
\end{aligned}`,
      ),
      paragraph([
        "このとき ",
        math(String.raw`k`),
        " は奇数である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&2\mu - 1 = kM_{\mathrm{col}} \\
&\Longrightarrow kM_{\mathrm{col}} = 2(\mu-1) + 1
   \quad (\because 2\mu - 1 = 2(\mu-1) + 1,\ \mu - 1 \in \mathbb{Z}) \\
&\Longrightarrow kM_{\mathrm{col}} \text{ は奇数}
   \quad (\because \text{奇数の定義}) \\
&\Longrightarrow k \text{ は奇数}
   \quad (\because \text{整数は偶数か奇数のどちらか一方で、} k = 2l\ (l \in \mathbb{Z}) \text{ なら } kM_{\mathrm{col}} = 2(lM_{\mathrm{col}}) \text{ は偶数})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（そのとき ",
        math(String.raw`\cos\tilde\theta_\mu = -1`),
        "）。Step 2 の ",
        math(String.raw`\tilde\theta_\mu = k\pi`),
        " と ",
        math(String.raw`k`),
        " が奇数であることから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\cos\tilde\theta_\mu
&= \cos(k\pi)
   \quad (\because \text{Step 2 の } \tilde\theta_\mu = k\pi) \\
&= (-1)^{k}
   \quad (\because k \in \mathbb{Z} \text{ に対し } \cos(k\pi) = (-1)^k) \\
&= -1
   \quad (\because \text{Step 2 より } k \text{ は奇数})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（矛盾）。Step 1 の連立条件の第 1 式に Step 3 を代入すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_1c_2
&= c_1\cos\tilde\theta_\mu
   \quad (\because \text{Step 1 の連立条件の第 1 式}) \\
&= c_1\cdot(-1)
   \quad (\because \text{Step 3 の } \cos\tilde\theta_\mu = -1) \\
&= -c_1
   \quad (\because \mathbb{R} \text{ の積の符号規則 } a\cdot(-1) = -a)
\end{aligned}`,
      ),
      paragraph([
        "が要求される。これは Step 0 に反する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&< s_1c_2
   \quad (\because \text{Step 0 の } s_1 > 0,\ c_2 > 0 \text{ と正数の積}) \\
&= -c_1
   \quad (\because \text{直前の鎖}) \\
&< 0
   \quad (\because \text{Step 0 の } c_1 > 0)
\end{aligned}`,
      ),
      paragraph([
        "は ",
        math(String.raw`0 < 0`),
        " を導き、矛盾である。よって Step 1 の連立条件は ",
        math(String.raw`\theta = \tilde\theta_\mu`),
        " で成り立たず、",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0_{\mathbb{C}}`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-09（Lean の通しの証明のゴールラインの確認）: 鎖の「両辺を π > 0 で割る」の π > 0 を pi_is_positive の参照にした。値と主張は不変。",
        "M = 2..8 の全 μ、および厳密な臨界点 sinh 2K_1 sinh 2K_2 = 1 とその近傍を含む 16 組の (K_1,K_2) で数値確認済み。" +
          "半整数運動量側の |γ_2(θ~_μ)| の最小値は 1.6e-1 で 0 から離れている一方、同じ K で整数運動量 θ = 2π では " +
          "臨界点ちょうどのとき |γ_2| ~ 1e-16（＝0）になる（sagemath/check/048_claim_A_theta_tilde/check_01）。",
        "sin θ~_μ = 0 となる (M, μ) は M が奇数のときの (2μ−1)/M が奇数の場合に限られ（μ ∈ {1,…,M} では k = 1 のみ）、" +
          "そこでは常に cos θ~_μ = −1 であることも M ≤ 40 の全探索で確認した（同 check_01 の (c)）。",
        "2026-08-19 の式変形統一で、Step 1・Step 2 の鎖の行末根拠をラベル識別子の生文字列から人間可読な名前へ直し、" +
          "Step 2 の「両辺を π で割って M 倍する」を一操作ずつの二行に分け、最終行（2(μ−1/2) = 2μ−1）に" +
          "行末根拠を補って鎖の後の重複した散文根拠を外した。内容・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。" +
          "Step 0 の正値性は第一・第二の双対結合定数の定義と添字つき略記の正値性から直接導く形に改めた。",
      ],
    },
  },
  {
    id: "Athetatilde_003_claim_relation_of_gamma2",
    kind: "claim",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 5 },
    title: {
      tex: String.raw`\gamma_2(-\tilde\theta_\mu) = -\overline{\gamma_2(\tilde\theta_\mu)} \text{ とその帰結}`,
    },
    labels: ["relation_of_gamma_2_theta_tilde"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " について、",
      ]),
      displayMath(
        String.raw`\text{(1)}\quad \gamma_2(-\tilde\theta_\mu) = -\overline{\gamma_2(\tilde\theta_\mu)},
\qquad
\text{(2)}\quad \gamma_2(\tilde\theta_\mu)\,\gamma_2(-\tilde\theta_\mu)
= \left(-\left|\gamma_2(\tilde\theta_\mu)\right|^2\right)_{\mathbb{C}},
\quad -\left|\gamma_2(\tilde\theta_\mu)\right|^2 < 0`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\left|\gamma_2(\tilde\theta_\mu)\right| \in \mathbb{R}_{\geq 0}`),
        " は ",
        ref("def_abs_arg"),
        " の絶対値、二乗 ",
        math(String.raw`\left|\gamma_2(\tilde\theta_\mu)\right|^2`),
        " は ",
        ref("def_power_of_real_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "）、",
        math(String.raw`-\left|\gamma_2(\tilde\theta_\mu)\right|^2 \in \mathbb{R}`),
        "、",
        math(String.raw`r \in \mathbb{R}`),
        " に対し ",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の像、",
        math(String.raw`< 0`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の順序である",
        "）。とくに ",
        math(String.raw`\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)`),
        " は**負の実数** ",
        math(String.raw`-\left|\gamma_2(\tilde\theta_\mu)\right|^2`),
        " の ",
        ref("inclusion_rr_to_cc"),
        " による像であり、",
      ]),
      displayMath(
        String.raw`\text{(3)}\quad \arg^{[0,2\pi)}\!\left(\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)\right) = \pi,
\qquad
\text{(4)}\quad \sqrt{-\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)}
= \left|\gamma_2(\tilde\theta_\mu)\right| > 0`,
      ),
      displayMath(
        String.raw`\text{(5)}\quad \sqrt{\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)}
= i\left|\gamma_2(\tilde\theta_\mu)\right|`,
      ),
      paragraph([
        "も成り立つ（",
        math(String.raw`\sqrt{\ }`),
        " は ",
        ref("def_sqrt_cc"),
        " の、偏角を ",
        math(String.raw`[0,2\pi)`),
        " で取る一価の写像）。また ",
        math(String.raw`\gamma_2(-\tilde\theta_\mu) \neq 0`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`\theta := \tilde\theta_\mu`),
        " と略記する。",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`\theta \in \mathbb{R}`),
        " であり、以下の共役の計算はこの実数性を使う。",
        math(String.raw`c_1, c_2, s_1, s_2^* \in \mathbb{R}`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        "、",
        math(String.raw`\cos\theta, \sin\theta, \cos(-\theta), \sin(-\theta) \in \mathbb{R}`),
        " は ",
        ref("euler_formula_cos_sin"),
        " の前置きのとおり全実数上の ",
        math(String.raw`\cos, \sin`),
        " の値である（全実数上への拡張は未整備）。これらの実数が ",
        math(String.raw`\mathbb{C}`),
        " の式に現れるときは、",
        ref("def_gamma1_gamma2_of_theta"),
        " の書き方に従い ",
        ref("inclusion_rr_to_cc"),
        " の像 ",
        math(String.raw`r_{\mathbb{C}}`),
        " として読み、像の記号を省く。",
        math(String.raw`r, r' \in \mathbb{R}`),
        " について ",
        math(String.raw`r_{\mathbb{C}}r'_{\mathbb{C}} = (rr')_{\mathbb{C}}`),
        "（",
        ref("real_inclusion_preserves_product"),
        "）なので、",
        math(String.raw`c_1\cos\theta`),
        "・",
        math(String.raw`s_1c_2`),
        " も実数の像である。複素共役は ",
        ref("def_complex_conjugate"),
        "、",
        math(String.raw`-z`),
        " は ",
        ref("multiply_by_minus_one"),
        "、差は ",
        ref("def_complex_difference"),
        " のものとする。",
      ]),
      paragraph([
        "第一に、",
        math(String.raw`\exp(i\theta)`),
        " を ",
        math(String.raw`\cos\theta`),
        "・",
        math(String.raw`\sin\theta`),
        " で書く。",
        math(String.raw`-i\theta`),
        " は ",
        ref("euler_formula_cos_sin"),
        " の読みのとおり ",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-(i\theta)`),
        " である。以下の分母の ",
        math(String.raw`2`), " は ", math(String.raw`2_{\mathbb{C}}`),
        " で、",
        ref("exp_of_negative_i_real_as_cos_minus_i_sin"),
        " の証明の前置きのとおり ",
        ref("complex_numbers_form_a_field"),
        " の体で ",
        math(String.raw`2_{\mathbb{C}} \neq 0_{\mathbb{C}}`), "、",
        math(String.raw`i \neq 0_{\mathbb{C}}`), "、",
        math(String.raw`2_{\mathbb{C}}i \neq 0_{\mathbb{C}}`),
        " なので、分数は定まる。",
        math(String.raw`\theta`),
        " を ",
        math(String.raw`-\theta`),
        " に替えた値 ",
        math(String.raw`i(-\theta) = -i\theta`),
        "・",
        math(String.raw`\cos(-\theta) = \cos\theta`),
        "・",
        math(String.raw`\sin(-\theta) = -\sin\theta`),
        " は、主張 ",
        ref("i_times_negated_real_is_negation_of_i_times"),
        "・",
        ref("cos_of_negated_real"),
        "・",
        ref("sin_of_negated_real"),
        " を第三で引く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\cos\theta + i\sin\theta
&= \frac{\exp(i\theta) + \exp(-i\theta)}{2} + i\,\frac{\exp(i\theta) - \exp(-i\theta)}{2i}
&&(\because\ \blkref{euler_formula_cos_sin})\\
&= \frac{\exp(i\theta) + \exp(-i\theta)}{2} + \frac{i\bigl(\exp(i\theta) - \exp(-i\theta)\bigr)}{2i}
&&\bigl(\because\ \mathbb{C}\ \text{で}\ x\tfrac{y}{z} = \tfrac{xy}{z}\ (z \neq 0_{\mathbb{C}})\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ x \to i,\ y \to \exp(i\theta) - \exp(-i\theta),\ z \to 2i\bigr)\\
&= \frac{\exp(i\theta) + \exp(-i\theta)}{2} + \frac{\bigl(\exp(i\theta) - \exp(-i\theta)\bigr)i}{2i}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&= \frac{\exp(i\theta) + \exp(-i\theta)}{2} + \frac{\exp(i\theta) - \exp(-i\theta)}{2}
&&\bigl(\because\ \mathbb{C}\ \text{で}\ \tfrac{xa}{ya} = \tfrac{x}{y}\ (a \neq 0_{\mathbb{C}},\ y \neq 0_{\mathbb{C}})\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ x \to \exp(i\theta) - \exp(-i\theta),\ y \to 2,\ a \to i\bigr)\\
&= \frac{\bigl(\exp(i\theta) + \exp(-i\theta)\bigr) + \bigl(\exp(i\theta) - \exp(-i\theta)\bigr)}{2}
&&\bigl(\because\ \mathbb{C}\ \text{で}\ \tfrac{x}{z} + \tfrac{y}{z} = \tfrac{x + y}{z}\ (z \neq 0_{\mathbb{C}})\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ x \to \exp(i\theta) + \exp(-i\theta),\ y \to \exp(i\theta) - \exp(-i\theta),\ z \to 2\bigr)\\
&= \frac{\bigl(\exp(i\theta) + \exp(-i\theta)\bigr) + \bigl(\exp(i\theta) + (-\exp(-i\theta))\bigr)}{2}
&&(\because\ \blkref{def_complex_difference})\\
&= \frac{\exp(i\theta) + \Bigl(\exp(-i\theta) + \bigl(\exp(i\theta) + (-\exp(-i\theta))\bigr)\Bigr)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律})\\
&= \frac{\exp(i\theta) + \Bigl(\bigl(\exp(-i\theta) + \exp(i\theta)\bigr) + (-\exp(-i\theta))\Bigr)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律})\\
&= \frac{\exp(i\theta) + \Bigl(\bigl(\exp(i\theta) + \exp(-i\theta)\bigr) + (-\exp(-i\theta))\Bigr)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の可換律})\\
&= \frac{\exp(i\theta) + \Bigl(\exp(i\theta) + \bigl(\exp(-i\theta) + (-\exp(-i\theta))\bigr)\Bigr)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律})\\
&= \frac{\exp(i\theta) + \bigl(\exp(i\theta) + 0_{\mathbb{C}}\bigr)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法逆元})\\
&= \frac{\exp(i\theta) + \exp(i\theta)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零元})\\
&= \frac{1_{\mathbb{C}}\exp(i\theta) + 1_{\mathbb{C}}\exp(i\theta)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元を 2 箇所へ右辺から左辺へ})\\
&= \frac{\bigl(1_{\mathbb{C}} + 1_{\mathbb{C}}\bigr)\exp(i\theta)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を右辺から左辺へ})\\
&= \frac{(1 + 1)_{\mathbb{C}}\,\exp(i\theta)}{2}
&&\bigl(\because\ \blkref{real_inclusion_preserves_sum}\ (a \to 1,\ b \to 1)\bigr)\\
&= \frac{2\exp(i\theta)}{2}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 1 + 1 = 2\bigr)\\
&= \exp(i\theta)
&&\bigl(\because\ \mathbb{C}\ \text{で}\ \tfrac{2a}{2} = a\ (2 \neq 0_{\mathbb{C}})\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ a \to \exp(i\theta)\bigr)
\end{aligned}`),
      paragraph([
        "第二に、",
        math(String.raw`i = (0,1)`),
        "（",
        ref("def_imaginary_unit"),
        "）の複素共役と、",
        math(String.raw`\exp(i\theta)`),
        " の複素共役を求める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bar i
&= \overline{(0,1)}
&&(\because\ \blkref{def_imaginary_unit})\\
&= (0,-1)
&&(\because\ \blkref{def_complex_conjugate})\\
&= (-1,0)(0,1)
&&(\because\ \blkref{definition_of_cc}\ \text{の積}\ ((-1)\cdot 0 - 0\cdot 1,\ (-1)\cdot 1 + 0\cdot 0))\\
&= (-1_{\mathbb{C}})(0,1)
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の}\ (-1)_{\mathbb{C}} = (-1,0))\\
&= (-1_{\mathbb{C}})\,i
&&(\because\ \blkref{def_imaginary_unit})\\
&= -i
&&(\because\ \blkref{multiply_by_minus_one})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\overline{\exp(i\theta)}
&= \overline{\cos\theta + i\sin\theta}
&&(\because\ \text{上の}\ \exp(i\theta)\ \text{の表示})\\
&= \overline{\cos\theta} + \overline{i\sin\theta}
&&(\because\ \blkref{complex_conjugate_of_sum}\ \text{を}\ m = 2\ \text{で})\\
&= \overline{\cos\theta} + \bar i\;\overline{\sin\theta}
&&(\because\ \blkref{complex_conjugate_of_product})\\
&= \cos\theta + \bar i\sin\theta
&&(\because\ \blkref{complex_conjugate_of_real_inclusion}\ \text{を 2 箇所へ})\\
&= \cos\theta + (-i)\sin\theta
&&(\because\ \text{上の}\ \bar i = -i)\\
&= \cos\theta + \bigl(-(i\sin\theta)\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{で}\ (-x)y = -(xy)\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ x \to i,\ y \to \sin\theta\bigr)\\
&= \cos\theta - i\sin\theta
&&(\because\ \blkref{def_complex_difference}\ \text{を右辺から左辺へ})\\
&= \exp(-i\theta)
&&(\because\ \blkref{exp_of_negative_i_real_as_cos_minus_i_sin})
\end{aligned}`),
      paragraph([
        "第三に、",
        math(String.raw`\gamma_2(-\theta)`),
        " を ",
        math(String.raw`\theta`),
        " の量で書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(-\theta)
&= i\,\exp(i(-\theta))\,s_2^*\bigl(c_1\cos(-\theta) - i\sin(-\theta) - s_1c_2\bigr)
&&(\because\ \blkref{def_gamma1_gamma2_of_theta}\ \text{を}\ -\theta \in \mathbb{R}\ \text{に適用})\\
&= i\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos(-\theta) - i\sin(-\theta) - s_1c_2\bigr)
&&(\because\ \blkref{i_times_negated_real_is_negation_of_i_times})\\
&= i\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta - i\sin(-\theta) - s_1c_2\bigr)
&&(\because\ \blkref{cos_of_negated_real})\\
&= i\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta - i(-\sin\theta) - s_1c_2\bigr)
&&(\because\ \blkref{sin_of_negated_real})\\
&= i\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta - \bigl(-(i\sin\theta)\bigr) - s_1c_2\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{で}\ x(-y) = -(xy)\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ x \to i,\ y \to \sin\theta\bigr)\\
&= i\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{で}\ a - (-b) = a + b\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ a \to c_1\cos\theta,\ b \to i\sin\theta\bigr)
\end{aligned}`),
      paragraph([
        "第四に、",
        math(String.raw`\overline{\gamma_2(\theta)}`),
        " を 1 段ずつ計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{\gamma_2(\theta)}
&= \overline{i\,\exp(i\theta)\,s_2^*\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
&&(\because\ \blkref{def_gamma1_gamma2_of_theta})\\
&= \overline{i\,\exp(i\theta)\,s_2^*}\;\overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
&&(\because\ \blkref{complex_conjugate_of_product})\\
&= \overline{i\,\exp(i\theta)}\;\overline{s_2^*}\;\overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
&&(\because\ \blkref{complex_conjugate_of_product})\\
&= \bar i\;\overline{\exp(i\theta)}\;\overline{s_2^*}\;\overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
&&(\because\ \blkref{complex_conjugate_of_product})\\
&= (-i)\;\overline{\exp(i\theta)}\;\overline{s_2^*}\;\overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
&&(\because\ \text{上の}\ \bar i = -i)\\
&= (-i)\,\exp(-i\theta)\;\overline{s_2^*}\;\overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
&&(\because\ \text{上の}\ \overline{\exp(i\theta)} = \exp(-i\theta))\\
&= (-i)\,\exp(-i\theta)\,s_2^*\;\overline{\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)}
&&(\because\ \blkref{complex_conjugate_of_real_inclusion})\\
&= (-i)\,\exp(-i\theta)\,s_2^*\bigl(\overline{c_1\cos\theta - i\sin\theta} - \overline{s_1c_2}\bigr)
&&(\because\ \blkref{complex_conjugate_of_difference})\\
&= (-i)\,\exp(-i\theta)\,s_2^*\bigl(\overline{c_1\cos\theta} - \overline{i\sin\theta} - \overline{s_1c_2}\bigr)
&&(\because\ \blkref{complex_conjugate_of_difference})\\
&= (-i)\,\exp(-i\theta)\,s_2^*\bigl(\overline{c_1\cos\theta} - \bar i\;\overline{\sin\theta} - \overline{s_1c_2}\bigr)
&&(\because\ \blkref{complex_conjugate_of_product})\\
&= (-i)\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta - \bar i\sin\theta - s_1c_2\bigr)
&&(\because\ \blkref{complex_conjugate_of_real_inclusion}\ \text{を 3 箇所へ})\\
&= (-i)\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta - (-i)\sin\theta - s_1c_2\bigr)
&&(\because\ \text{上の}\ \bar i = -i)\\
&= (-i)\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta - \bigl(-(i\sin\theta)\bigr) - s_1c_2\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{で}\ (-x)y = -(xy)\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ x \to i,\ y \to \sin\theta\bigr)\\
&= (-i)\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{で}\ a - (-b) = a + b\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ a \to c_1\cos\theta,\ b \to i\sin\theta\bigr)\\
&= \bigl(-(i\,\exp(-i\theta))\bigr)\,s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{で}\ (-x)y = -(xy)\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ x \to i,\ y \to \exp(-i\theta)\bigr)\\
&= \bigl(-(i\,\exp(-i\theta)\,s_2^*)\bigr)\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{で}\ (-x)y = -(xy)\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ x \to i\,\exp(-i\theta),\ y \to s_2^*\bigr)\\
&= -\Bigl(i\,\exp(-i\theta)\,s_2^*\bigl(c_1\cos\theta + i\sin\theta - s_1c_2\bigr)\Bigr)
&&\bigl(\because\ \mathbb{C}\ \text{で}\ (-x)y = -(xy)\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ x \to i\,\exp(-i\theta)\,s_2^*,\ y \to c_1\cos\theta + i\sin\theta - s_1c_2\bigr)\\
&= -\gamma_2(-\theta)
&&(\because\ \text{上の}\ \gamma_2(-\theta)\ \text{の表示})
\end{aligned}`),
      paragraph([
        "第五に、",
        math(String.raw`\sin(\pi/2) = 1`),
        "・",
        math(String.raw`\cos(\pi/2) = 0`),
        " を確かめる。",
        ref("arcsin_is_bijection"),
        " の ",
        math(String.raw`\pi`),
        " について ",
        math(String.raw`\arcsin(1) = \pi/2`),
        " である（",
        ref("arcsin_of_one_is_half_pi"),
        "。",
        math(String.raw`\pi \in \mathbb{R}`),
        " を使うのは、弧の長さが実数だからである）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sin(\pi/2)
&= \sin(\arcsin(1))
&&(\because\ \blkref{arcsin_of_one_is_half_pi})\\
&= 1
&&(\because\ \pi/2 = \arcsin(1) \in [-\pi/2,\pi/2]\ (\blkref{arcsin_is_bijection}\ \text{の値域})\ \text{で}\ \blkref{def_sin}\ \text{の}\ y\ \text{はただ一つ。}\arcsin(1) = \pi/2\ \text{なので}\ y = 1)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\cos(\pi/2)
&= \sqrt{1-(\sin(\pi/2))^2}^{(\mathbb{R}_{\geq 0})}
&&(\because\ \blkref{def_cos})\\
&= \sqrt{1-1^2}^{(\mathbb{R}_{\geq 0})}
&&(\because\ \text{上の}\ \sin(\pi/2) = 1)\\
&= \sqrt{1-1}^{(\mathbb{R}_{\geq 0})}
&&\bigl(\because\ \blkref{power_of_real_one_is_one}\ \text{の}\ m \to 2\bigr)\\
&= \sqrt{0}^{(\mathbb{R}_{\geq 0})}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a - a = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）の}\ a \to 1\bigr)\\
&= 0
&&\bigl(\because\ \blkref{sqrt_of_real_zero_is_zero}\bigr)
\end{aligned}`),
      paragraph([
        ref("pi_is_positive"),
        " の ",
        math(String.raw`0 < \pi`),
        " より ",
        math(String.raw`0 \leq 0 - 2\cdot 0\cdot\pi < 2\pi`),
        " と ",
        math(String.raw`0 \leq \pi - 2\cdot 0\cdot\pi < 2\pi`),
        " が成り立つので、",
        ref("angle_section_existence_uniqueness"),
        " の整数は角度 ",
        math(String.raw`0`),
        " と ",
        math(String.raw`\pi`),
        " のどちらについても ",
        math(String.raw`0`),
        " である。",
      ]),
      paragraph([
        "(1) 主張 (1) の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(-\theta)
&= -\bigl(-\gamma_2(-\theta)\bigr)
&&\bigl(\because\ \mathbb{C}\ \text{で}\ -(-z) = z\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ z \to \gamma_2(-\theta)\ \text{を右辺から左辺へ}\bigr)\\
&= -\overline{\gamma_2(\theta)}
&&(\because\ \text{上の}\ \overline{\gamma_2(\theta)} = -\gamma_2(-\theta))
\end{aligned}`),
      paragraph([
        "(2) 主張 (2) の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta)\gamma_2(-\theta)
&= \gamma_2(\theta)\left(-\overline{\gamma_2(\theta)}\right)
&&(\because\ (1))\\
&= \gamma_2(\theta)\left((-1_{\mathbb{C}})\,\overline{\gamma_2(\theta)}\right)
&&(\because\ \blkref{multiply_by_minus_one})\\
&= \left(\gamma_2(\theta)(-1_{\mathbb{C}})\right)\overline{\gamma_2(\theta)}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= \left((-1_{\mathbb{C}})\,\gamma_2(\theta)\right)\overline{\gamma_2(\theta)}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&= (-1_{\mathbb{C}})\left(\gamma_2(\theta)\,\overline{\gamma_2(\theta)}\right)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= (-1_{\mathbb{C}})\left(\overline{\gamma_2(\theta)}\,\gamma_2(\theta)\right)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&= (-1_{\mathbb{C}})\left(\left|\gamma_2(\theta)\right|^2\right)_{\mathbb{C}}
&&(\because\ \blkref{complex_conjugate_times_self})\\
&= \left((-1)\left|\gamma_2(\theta)\right|^2\right)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= \left(-\left|\gamma_2(\theta)\right|^2\right)_{\mathbb{C}}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ (-1)a = -a\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ a \to \left|\gamma_2(\theta)\right|^2\bigr)
\end{aligned}`),
      paragraph([
        "これが主張 (2) の等式である。次に主張 (2) の不等式、すなわち実数 ",
        math(String.raw`-|\gamma_2(\theta)|^2`),
        " が負であることを示す。",
        ref("def_abs_arg"),
        " より ",
        math(String.raw`|\gamma_2(\theta)| \in \mathbb{R}_{\geq 0}`),
        "、",
        ref("gamma_2_theta_tilde_nonzero"),
        " の ",
        math(String.raw`\gamma_2(\theta) \neq 0_{\mathbb{C}}`),
        " と ",
        ref("abs_basic_properties"),
        " (3) より ",
        math(String.raw`|\gamma_2(\theta)| \neq 0`),
        " なので、",
        math(String.raw`|\gamma_2(\theta)| > 0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&= 0\cdot\left|\gamma_2(\theta)\right|
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0\cdot x = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to \left|\gamma_2(\theta)\right|\ \text{を右辺から左辺へ}\bigr)\\
&< \left|\gamma_2(\theta)\right|\left|\gamma_2(\theta)\right|
&&(\because\ 0 < \left|\gamma_2(\theta)\right|\ \text{の両辺に正の実数}\ \left|\gamma_2(\theta)\right|\ \text{を掛ける。}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation})\\
&= \left|\gamma_2(\theta)\right|^2
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to \left|\gamma_2(\theta)\right|)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\left|\gamma_2(\theta)\right|^2
&< -0
&&(\because\ \text{直前の鎖の}\ 0 < \left|\gamma_2(\theta)\right|^2\ \text{の両辺の符号を反転すると向きが変わる。}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation})\\
&= 0
&&\bigl(\because\ \mathbb{R}\ \text{で}\ -0 = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`\gamma_2(-\theta) \neq 0_{\mathbb{C}}`),
        " を背理法で示す。",
        math(String.raw`\gamma_2(-\theta) = 0_{\mathbb{C}}`),
        " と仮定すると、",
        math(String.raw`\gamma_2(\theta) = (x,y)`),
        " と成分で書いて",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta)
&= (x,y)
&&(\because\ \text{成分の置き方})\\
&= \bigl(x,-(-y)\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ -(-a) = a\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ a \to y\ \text{を右辺から左辺へ}\bigr)\\
&= \overline{(x,-y)}
&&(\because\ \blkref{def_complex_conjugate})\\
&= \overline{\overline{(x,y)}}
&&(\because\ \blkref{def_complex_conjugate})\\
&= \overline{\overline{\gamma_2(\theta)}}
&&(\because\ \text{成分の置き方})\\
&= \overline{-\gamma_2(-\theta)}
&&(\because\ \text{上の}\ \overline{\gamma_2(\theta)} = -\gamma_2(-\theta))\\
&= \overline{-0_{\mathbb{C}}}
&&(\because\ \text{仮定}\ \gamma_2(-\theta) = 0_{\mathbb{C}})\\
&= \overline{(-1_{\mathbb{C}})\,0_{\mathbb{C}}}
&&(\because\ \blkref{multiply_by_minus_one})\\
&= \overline{0_{\mathbb{C}}}
&&(\because\ \blkref{complex_times_zero_is_zero})\\
&= 0_{\mathbb{C}}
&&(\because\ \blkref{complex_conjugate_of_real_inclusion}\ \text{を}\ r = 0\ \text{で})
\end{aligned}`),
      paragraph([
        "となり、",
        ref("gamma_2_theta_tilde_nonzero"),
        " に反する。よって ",
        math(String.raw`\gamma_2(-\theta) \neq 0_{\mathbb{C}}`),
        " である。",
      ]),
      paragraph([
        "(3) 以下 ",
        math(String.raw`r := |\gamma_2(\theta)|^2 \in \mathbb{R}_{>0}`),
        " と置く（",
        math(String.raw`r > 0`),
        " は (2) で示した）。まず ",
        math(String.raw`\phi_{\mathrm{polar}}((-r)_{\mathbb{C}})`),
        " を求める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\phi_{\mathrm{polar}}\bigl((-r)_{\mathbb{C}}\bigr)
&= \phi_{\mathrm{polar}}\bigl((-r,0)\bigr)
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= \left[\left(\sqrt{(-r)^2+0^2}^{\,\mathbb{R}_{\ge 0}},\ \arctan\bigl(0/(-r)\bigr)+\pi\right)\right]_{\sim}
&&(\because\ \blkref{def_phi_polar}\ \text{の}\ x = -r < 0,\ y = 0 \geq 0\ \text{の場合})\\
&= \left[\left(\sqrt{(-r)(-r)+0^2}^{\,\mathbb{R}_{\ge 0}},\ \arctan\bigl(0/(-r)\bigr)+\pi\right)\right]_{\sim}
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to -r)\bigr)\\
&= \left[\left(\sqrt{r\,r+0^2}^{\,\mathbb{R}_{\ge 0}},\ \arctan\bigl(0/(-r)\bigr)+\pi\right)\right]_{\sim}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ (-a)(-b) = ab\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ a, b \to r\bigr)\\
&= \left[\left(\sqrt{r^2+0^2}^{\,\mathbb{R}_{\ge 0}},\ \arctan\bigl(0/(-r)\bigr)+\pi\right)\right]_{\sim}
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to r)\ \text{を右辺から左辺へ}\bigr)\\
&= \left[\left(\sqrt{r^2+0\cdot 0}^{\,\mathbb{R}_{\ge 0}},\ \arctan\bigl(0/(-r)\bigr)+\pi\right)\right]_{\sim}
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to 0)\bigr)\\
&= \left[\left(\sqrt{r^2+0}^{\,\mathbb{R}_{\ge 0}},\ \arctan\bigl(0/(-r)\bigr)+\pi\right)\right]_{\sim}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0\cdot x = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to 0\bigr)\\
&= \left[\left(\sqrt{r^2}^{\,\mathbb{R}_{\ge 0}},\ \arctan\bigl(0/(-r)\bigr)+\pi\right)\right]_{\sim}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a + 0 = a\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ a \to r^2\bigr)\\
&= \left[\left(\sqrt{r^2}^{\,\mathbb{R}_{\ge 0}},\ \arctan 0+\pi\right)\right]_{\sim}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0/x = 0\ (x \neq 0)\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to -r\text{。}-r < 0\ \text{より}\ -r \neq 0\bigr)\\
&= \left[\left(r,\ \arctan 0+\pi\right)\right]_{\sim}
&&(\because\ r \geq 0\ \text{かつ}\ r^2 = r^2\ \text{なので、}\blkref{definition_of_sqrt_r_positive}\ \text{のただ一つの元は}\ r)\\
&= \left[\left(r,\ 0+\pi\right)\right]_{\sim}
&&(\because\ \blkref{arctan_zero})\\
&= \left[\left(r,\ \pi\right)\right]_{\sim}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0 + a = a\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ a \to \pi\bigr)
\end{aligned}`),
      paragraph([
        "角度 ",
        math(String.raw`\pi`),
        " の ",
        ref("angle_section_existence_uniqueness"),
        " の整数は準備により ",
        math(String.raw`0`),
        " である。主張 (3) の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\arg^{[0,2\pi)}\!\left(\gamma_2(\theta)\gamma_2(-\theta)\right)
&= \arg^{[0,2\pi)}\!\left((-r)_{\mathbb{C}}\right)
&&(\because\ (2))\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2\bigl(\phi_{\mathrm{polar}}((-r)_{\mathbb{C}})\bigr)\right)
&&(\because\ \blkref{def_abs_arg})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2\bigl([(r,\pi)]_{\sim}\bigr)\right)
&&(\because\ \text{上の}\ \phi_{\mathrm{polar}}((-r)_{\mathbb{C}})\ \text{の値})\\
&= s_{[0,2\pi)}\!\left([\pi]_{\sim_{\mathrm{angle}}}\right)
&&(\because\ \blkref{first_and_second_projections}\ \text{の}\ r \neq 0\ \text{の場合})\\
&= \pi - 2\cdot 0\cdot\pi
&&\bigl(\because\ \blkref{section_of_angle_representation}\ \text{の}\ \theta \to \pi\ \text{と整数}\ n \to 0\bigr)\\
&= \pi - 0\cdot\pi
&&\bigl(\because\ \mathbb{R}\ \text{で}\ x\cdot 0 = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to 2\bigr)\\
&= \pi - 0
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0\cdot x = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to \pi\bigr)\\
&= \pi
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a - 0 = a\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ a \to \pi\bigr)
\end{aligned}`),
      paragraph([
        "(4) まず ",
        math(String.raw`-\gamma_2(\theta)\gamma_2(-\theta)`),
        " と ",
        math(String.raw`\phi_{\mathrm{polar}}(r_{\mathbb{C}})`),
        " を求める。",
      ]),
      displayMath(String.raw`\begin{aligned}
-\gamma_2(\theta)\gamma_2(-\theta)
&= (-1_{\mathbb{C}})\bigl(\gamma_2(\theta)\gamma_2(-\theta)\bigr)
&&(\because\ \blkref{multiply_by_minus_one})\\
&= (-1_{\mathbb{C}})\,(-r)_{\mathbb{C}}
&&(\because\ (2))\\
&= \bigl((-1)(-r)\bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= \bigl(1\cdot r\bigr)_{\mathbb{C}}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ (-a)(-b) = ab\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ a \to 1,\ b \to r\bigr)\\
&= r_{\mathbb{C}}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 1\cdot x = x\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to r\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\phi_{\mathrm{polar}}\bigl(r_{\mathbb{C}}\bigr)
&= \phi_{\mathrm{polar}}\bigl((r,0)\bigr)
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= \left[\left(\sqrt{r^2+0^2}^{\,\mathbb{R}_{\ge 0}},\ \arctan(0/r)\right)\right]_{\sim}
&&(\because\ \blkref{def_phi_polar}\ \text{の}\ x = r > 0\ \text{の場合})\\
&= \left[\left(\sqrt{r^2+0\cdot 0}^{\,\mathbb{R}_{\ge 0}},\ \arctan(0/r)\right)\right]_{\sim}
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to 0)\bigr)\\
&= \left[\left(\sqrt{r^2+0}^{\,\mathbb{R}_{\ge 0}},\ \arctan(0/r)\right)\right]_{\sim}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0\cdot x = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to 0\bigr)\\
&= \left[\left(\sqrt{r^2}^{\,\mathbb{R}_{\ge 0}},\ \arctan(0/r)\right)\right]_{\sim}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a + 0 = a\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ a \to r^2\bigr)\\
&= \left[\left(\sqrt{r^2}^{\,\mathbb{R}_{\ge 0}},\ \arctan 0\right)\right]_{\sim}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0/x = 0\ (x \neq 0)\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to r\text{。}r > 0\ \text{より}\ r \neq 0\bigr)\\
&= \left[\left(r,\ \arctan 0\right)\right]_{\sim}
&&(\because\ r \geq 0\ \text{かつ}\ r^2 = r^2\ \text{なので、}\blkref{definition_of_sqrt_r_positive}\ \text{のただ一つの元は}\ r)\\
&= \left[\left(r,\ 0\right)\right]_{\sim}
&&(\because\ \blkref{arctan_zero})
\end{aligned}`),
      paragraph([
        "代表元 ",
        math(String.raw`(r,0)`),
        " の角度 ",
        math(String.raw`0`),
        " の ",
        ref("angle_section_existence_uniqueness"),
        " の整数は準備により ",
        math(String.raw`0`),
        " である。主張 (4) の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{-\gamma_2(\theta)\gamma_2(-\theta)}
&= \sqrt{r_{\mathbb{C}}}
&&(\because\ \text{上の}\ -\gamma_2(\theta)\gamma_2(-\theta) = r_{\mathbb{C}})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{0}{2}-0\cdot\pi\right)\right]_{\sim}\right)
&&(\because\ \blkref{sqrt_expansion_via_polar}\ \text{を代表元}\ (r,0)\ \text{と整数}\ 0\ \text{で})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\left|\gamma_2(\theta)\right|,\ \tfrac{0}{2}-0\cdot\pi\right)\right]_{\sim}\right)
&&(\because\ \left|\gamma_2(\theta)\right| \geq 0\ \text{かつ}\ \left|\gamma_2(\theta)\right|^2 = r\ \text{なので、}\blkref{definition_of_sqrt_r_positive})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\left|\gamma_2(\theta)\right|,\ 0-0\cdot\pi\right)\right]_{\sim}\right)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0/x = 0\ (x \neq 0)\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to 2\text{。}2 \neq 0\bigr)\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\left|\gamma_2(\theta)\right|,\ 0-0\right)\right]_{\sim}\right)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0\cdot x = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to \pi\bigr)\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\left|\gamma_2(\theta)\right|,\ 0\right)\right]_{\sim}\right)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a - 0 = a\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ a \to 0\bigr)\\
&= \bigl(\left|\gamma_2(\theta)\right|\cos 0,\ \left|\gamma_2(\theta)\right|\sin 0\bigr)
&&(\because\ \blkref{def_phi_cartesian})\\
&= \bigl(\left|\gamma_2(\theta)\right|\cdot 1,\ \left|\gamma_2(\theta)\right|\sin 0\bigr)
&&(\because\ \blkref{cosine_zero})\\
&= \bigl(\left|\gamma_2(\theta)\right|\cdot 1,\ \left|\gamma_2(\theta)\right|\cdot 0\bigr)
&&(\because\ \blkref{sine_zero})\\
&= \bigl(\left|\gamma_2(\theta)\right|,\ \left|\gamma_2(\theta)\right|\cdot 0\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ x\cdot 1 = x\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to \left|\gamma_2(\theta)\right|\bigr)\\
&= \bigl(\left|\gamma_2(\theta)\right|,\ 0\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ x\cdot 0 = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to \left|\gamma_2(\theta)\right|\bigr)\\
&= \left|\gamma_2(\theta)\right|_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
      paragraph([
        "主張 (4) の右辺 ",
        math(String.raw`|\gamma_2(\theta)|`),
        " はこの実数の像として読み、",
        math(String.raw`|\gamma_2(\theta)| > 0`),
        " は (2) で示した。",
      ]),
      paragraph([
        "(5) 上の ",
        math(String.raw`\phi_{\mathrm{polar}}((-r)_{\mathbb{C}}) = [(r,\pi)]_{\sim}`),
        " の代表元 ",
        math(String.raw`(r,\pi)`),
        " の角度 ",
        math(String.raw`\pi`),
        " の ",
        ref("angle_section_existence_uniqueness"),
        " の整数は準備により ",
        math(String.raw`0`),
        " である。主張 (5) の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{\gamma_2(\theta)\gamma_2(-\theta)}
&= \sqrt{(-r)_{\mathbb{C}}}
&&(\because\ (2))\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{\pi}{2}-0\cdot\pi\right)\right]_{\sim}\right)
&&(\because\ \blkref{sqrt_expansion_via_polar}\ \text{を代表元}\ (r,\pi)\ \text{と整数}\ 0\ \text{で})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\left|\gamma_2(\theta)\right|,\ \tfrac{\pi}{2}-0\cdot\pi\right)\right]_{\sim}\right)
&&(\because\ \left|\gamma_2(\theta)\right| \geq 0\ \text{かつ}\ \left|\gamma_2(\theta)\right|^2 = r\ \text{なので、}\blkref{definition_of_sqrt_r_positive})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\left|\gamma_2(\theta)\right|,\ \tfrac{\pi}{2}-0\right)\right]_{\sim}\right)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0\cdot x = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to \pi\bigr)\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\left|\gamma_2(\theta)\right|,\ \tfrac{\pi}{2}\right)\right]_{\sim}\right)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a - 0 = a\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ a \to \tfrac{\pi}{2}\bigr)\\
&= \bigl(\left|\gamma_2(\theta)\right|\cos\tfrac{\pi}{2},\ \left|\gamma_2(\theta)\right|\sin\tfrac{\pi}{2}\bigr)
&&(\because\ \blkref{def_phi_cartesian})\\
&= \bigl(\left|\gamma_2(\theta)\right|\cdot 0,\ \left|\gamma_2(\theta)\right|\sin\tfrac{\pi}{2}\bigr)
&&(\because\ \text{準備の}\ \cos(\pi/2) = 0)\\
&= \bigl(\left|\gamma_2(\theta)\right|\cdot 0,\ \left|\gamma_2(\theta)\right|\cdot 1\bigr)
&&(\because\ \text{準備の}\ \sin(\pi/2) = 1)\\
&= \bigl(0\cdot \left|\gamma_2(\theta)\right|,\ 1\cdot \left|\gamma_2(\theta)\right|\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ xy = yx\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to \left|\gamma_2(\theta)\right|\ \text{と}\ y \to 0,\ y \to 1\ \text{を 2 成分へ}\bigr)\\
&= \bigl(0\cdot \left|\gamma_2(\theta)\right| - 0,\ 1\cdot \left|\gamma_2(\theta)\right|\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a - 0 = a\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ a \to 0\cdot \left|\gamma_2(\theta)\right|\ \text{を右辺から左辺へ}\bigr)\\
&= \bigl(0\cdot \left|\gamma_2(\theta)\right| - 1\cdot 0,\ 1\cdot \left|\gamma_2(\theta)\right|\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ x\cdot 0 = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to 1\ \text{を第 1 成分の引く側の}\ 0\ \text{へ右辺から左辺へ}\bigr)\\
&= \bigl(0\cdot \left|\gamma_2(\theta)\right| - 1\cdot 0,\ 0 + 1\cdot \left|\gamma_2(\theta)\right|\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0 + a = a\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ a \to 1\cdot \left|\gamma_2(\theta)\right|\ \text{を右辺から左辺へ}\bigr)\\
&= \bigl(0\cdot \left|\gamma_2(\theta)\right| - 1\cdot 0,\ 0\cdot 0 + 1\cdot \left|\gamma_2(\theta)\right|\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0\cdot x = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\text{の}\ x \to 0\ \text{を第 2 成分の足す側の}\ 0\ \text{へ右辺から左辺へ}\bigr)\\
&= (0,1)\bigl(\left|\gamma_2(\theta)\right|,\ 0\bigr)
&&(\because\ \blkref{definition_of_cc}\ \text{の積を右辺から左辺へ})\\
&= i\bigl(\left|\gamma_2(\theta)\right|,\ 0\bigr)
&&(\because\ \blkref{def_imaginary_unit})\\
&= i\left|\gamma_2(\theta)\right|_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "(4)(5) は 008 章では独立の主張になっていないが、半整数運動量では γ_2 ≠ 0 が常に成り立つため、" +
          "根号の中身が正の実数（(4)）・負の実数（(5)）に確定する。これにより後続の固有値・固有ベクトルの計算から" +
          "複素平方根の分枝の議論（008 章 eigenvector_of_A_theta が condition_of_commutativity_of_sqrt_and_product を" +
          "経由して行っていた部分）を追い出せる。",
        "検算: sagemath/check/relation_of_gamma_2_theta_tilde/（厳密計算。浮動小数点の旧検算 sagemath/check/048_claim_A_theta_tilde/check_02 も残っている）。",
        "2026-08-19 の式変形統一で、補助的な共役計算の末尾に複素数の四則という行末根拠を補い、散文で行っていた両辺の符号反転を主張 (1) の左辺から始まる一段の鎖へ移した。(5) の終端にも三角関数の特殊値と複素数の四則を行末根拠として明記した。内容・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-03: SageMath の検算（sagemath/check/relation_of_gamma_2_theta_tilde/）を付けるときに証明を直した。γ_2(−θ) の表示を def_gamma1_gamma2_of_theta の証明から借りず、euler_formula_cos_sin から cos(−θ)・sin(−θ) を求める鎖で作った。複素共役の行の根拠を complex_conjugate_of_product・complex_conjugate_of_difference・complex_conjugate_of_sum・complex_conjugate_of_real_inclusion に、ī = −i と conj(exp(iθ)) = exp(−iθ) を鎖に、z conj(z) = |z|^2 の根拠を abs_basic_properties（この性質を述べていない）から complex_conjugate_times_self に直した。(2) の狭義の負と γ_2(−θ) ≠ 0 を鎖に、(3)(4)(5) の偏角・平方根を def_phi_polar・def_abs_arg・sqrt_expansion_via_polar・def_phi_cartesian から一行ずつの鎖にした。主張の中身は不変。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 主張の |γ_2(θ̃_μ)| を def_abs_arg の絶対値、二乗 |γ_2(θ̃_μ)|^2 を def_power_of_real_number の冪（m = 2）、(2) の等号の右辺が実数 −|γ_2(θ̃_μ)|^2 の inclusion_rr_to_cc の像で、< 0 はその実数についての ℝ の順序であると (2) の直後に明記した。−|γ_2|^2 を ℂ と ℝ の両方の元として使わないよう、(2) を γ_2γ_2(−θ̃) = (−|γ_2|^2)_ℂ と −|γ_2|^2 < 0 の 2 式に分けた（証明の鎖の終わりの形と同じ）。続く「とくに〜負の実数」の文も実数の像と書き、anticommutator_of_check_psi の (2) を引く段落の読み方の文を新しい主張の形に合わせた。証明の −|γ_2(θ)|^2 < 0 の鎖の根拠「両辺を −1 倍すると向きが変わる」を、使っているのが符号反転なので「両辺の符号を反転すると向きが変わる」に直した。0 < |γ_2(θ)|^2 の鎖の |γ_2(θ)||γ_2(θ)| = |γ_2(θ)|^2 の行の名前だけの根拠「実数の 2 乗の定義」を square_of_real_number_is_product（r → |γ_2(θ)|）を右辺から左辺へ引く参照にした。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 準備の第五の arctan 0 の鎖の 2 行目「ℝ の四則 0/√1 = 0」（0^2 = 0・1 + 0 = 1・√1 = 1・0/1 = 0 を 1 行で使っていた）を、square_of_real_number_is_product（r → 0）、ℝ で 0·x = 0（x → 0）、ℝ で a + 0 = a（a → 1）、sqrt_of_real_one_is_one、ℝ で 0/x = 0（x → 1）の 5 行に割った。値と主張は変えていない。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 準備の第五の arctan 0 の鎖を独立の主張 arctan_zero（020_critical_point.ts）へ移し、(3)(4) の鎖の根拠「準備の arctan 0 = 0」を arctan_zero の参照にした。inverse_of_sqrt_cc の φ_polar(1_C) の鎖も同じ主張を引く。0 < π の鎖が引いていた arcsin(0) = 0 は、移した鎖の 7・8 行目と同じ 2 行の鎖（sine_zero・def_sin）として準備の第五に残した。値と主張は変えていない。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 準備の第五の cos(π/2) の鎖の「ℝ の四則」1 行（1^2 = 1・1 − 1 = 0 を 1 行で使っていた）を、power_of_real_one_is_one（m → 2）と ℝ で a − a = 0（a → 1）の 2 行に割った。最後の行 √0 = 0（0 ≥ 0・0^2 = 0・definition_of_sqrt_r_positive の一意性を 1 行で使っていた）を、新しく足した主張 sqrt_of_real_zero_is_zero（000_calculation_formulae_20_29.ts）の参照にした。値と主張は不変。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: (3) の φ_polar((−r)_C) の鎖の最後の行（[(r, arctan 0+π)] = [(r, π)]。arctan 0 = 0 と ℝ の 0 + π = π を 1 行で使っていた）を、arctan_zero の行（[(r, 0+π)]）と ℝ で 0 + a = a（a → π）の行の 2 行に割った。値と主張は不変。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 準備の第五の 0 < π の鎖（arcsin(0) = 0 を経て π = 2arcsin(1) > 2arcsin(0) = 0）を、zero_in_closed_interval_from_minus_half_pi_to_half_pi の証明から独立させた主張 pi_is_positive の参照にした。arcsin(0) = 0 の鎖は 0 < π の鎖にしか使われていなかったので外した。値と主張は不変。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: (3)(4) で 1 行に 2 つ以上の事実を使っていた行を割った。(3) の φ_polar((−r)_C) の鎖の「ℝ の四則」1 行（(−r)^2 = r^2・0^2 = 0・r^2 + 0 = r^2・0/(−r) = 0）を、square_of_real_number_is_product（r → −r）、ℝ で (−a)(−b) = ab（a, b → r）、square_of_real_number_is_product（r → r）を右辺から左辺へ、同（r → 0）、ℝ で 0·x = 0（x → 0）、ℝ で a + 0 = a（a → r^2。ℝ は体）、ℝ で 0/x = 0（x → −r）の 7 行に割った。(3) の主の鎖は、角度 π の angle_section_existence_uniqueness の整数が 0 であることを鎖の前の段落へ出して s_{[0,2π)} の行の根拠を section_of_angle_representation（θ → π、n → 0）だけにし、π − 2·0·π = π を x·0 = 0（x → 2）・0·x = 0（x → π）・a − 0 = a（a → π）の 3 行に割った。(4) の −γγ' の鎖の最後 (−1)(−r) = r を (−a)(−b) = ab（a → 1、b → r）と 1·x = x（x → r）の 2 行に、φ_polar(r_C) の鎖の「ℝ の四則」1 行（0^2 = 0・r^2 + 0 = r^2・0/r = 0）を 4 行に割り、次の行の根拠に definition_of_sqrt_r_positive の前提「r ≥ 0 かつ r^2 = r^2」を書いた。(4) の主の鎖の 0/2 − 0·π = 0 を 0/x = 0（x → 2）・0·x = 0（x → π）・a − 0 = a（a → 0）の 3 行に、「ℝ の四則を 2 箇所へ」を x·1 = x と x·0 = 0（x → |γ_2(θ)|）の 2 行に割った（0/x = 0 の x → 2 に 2 ≠ 0 を添えた）。(3) の φ_polar((−r)_C) の鎖の最後の 0 + a = a の行に「ℝ は体」を添えた。値と主張は不変。",
        "2026-11-09（Lean の通しの証明のゴールラインの確認）: 準備の第五の sin(π/2) の鎖の 1 行目の根拠と前の段落の π の説明を、remark_real_analysis_facts_R3_R4 の円周率の項から、数学的道具立てに足した arcsin_of_one_is_half_pi の参照にした。値と主張は不変。",
        "2026-11-09（Lean の通しの証明のゴールラインの確認）: (3)(4) の外で 1 行に 2 つ以上の事実を使うか名前だけの根拠だった 5 行を割った。(2) の鎖の最後の「ℝ の四則」を ℝ で (−1)a = −a（a → |γ_2(θ)|^2）に、0 = 0·|γ_2(θ)| の「ℝ の四則」を ℝ で 0·x = 0（x → |γ_2(θ)|）を右辺から左辺へに、−0 = 0 の「ℝ の四則」を ℝ で −0 = 0 に、(5) の π/2 − 0·π = π/2 を 0·x = 0（x → π）と a − 0 = a（a → π/2）の 2 行に、(5) の「ℝ の四則を 2 箇所へ」を x·0 = 0 と x·1 = x（x → |γ_2(θ)|）の 2 行にした（どれも ℝ は体 set_and_algebra_notation を添えた）。(4)(5) の鎖の前の段落の「整数は準備により 0」を、(3) と同じく angle_section_existence_uniqueness を引く書き方に揃えた。値と主張は不変。",
        "2026-11-09（Lean の通しの証明のゴールラインの確認）: 名前だけの根拠「ℂ の四則」11 か所と 1 行に 2 つの事実を使う行を、ℂ・ℝ の体の等式 1 つずつの行に割った。準備の第一の前に i(−θ) = −iθ（ℝ で −a = (−1)a、real_inclusion_preserves_product、ℂ で x(ay) = a(xy)、multiply_by_minus_one）と −i(−θ) = iθ（ℂ で −(−z) = z）の鎖を置き、cos(−θ)・sin(−θ) の鎖の引数の行を 2 行ずつにし、γ_2(−θ) の表示の鎖の引数の行もこれを引く形にした。sin(−θ) の鎖の符号を外へ出す行、cos θ + i sin θ の鎖の i/(2i) = 1/2 の行と最後の行、conj(exp(iθ)) の鎖の (−i) sin θ の行、γ_2(−θ) の表示と conj(γ_2(θ)) の鎖の −i(−sin θ)・(−i) を外へ出す行、(1) の −(−z) = z、背理の鎖の ℝ で −(−y) = y、(5) の (0,|γ_2(θ)|) = (0,1)(|γ_2(θ)|,0)（definition_of_cc の積の成分の ℝ の事実 4 つ）を割った（ℂ は体 complex_numbers_form_a_field、ℝ は体 set_and_algebra_notation を添えた）。値と主張は不変。",
        "2026-11-09（Lean の通しの証明）: 準備の第一の i(-θ) = -iθ・-i(-θ) = iθ・cos(-θ) = cos θ・sin(-θ) = -sin θ の 4 本の鎖を、def_gamma1_gamma2_of_theta からも引けるよう" +
          "主張 i_times_negated_real_is_negation_of_i_times・negation_of_i_times_negated_real_is_i_times・cos_of_negated_real・sin_of_negated_real として前へ移し、第三の鎖の根拠をそれらへの参照にした。主張と残りの鎖は変えていない。",
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 虚数単位 i = (0,1) の根拠を、後ろの章の antiperiodic_exp_sum の前置きから、計算公式の章に足した定義 def_imaginary_unit への参照に替えた。計算と主張は不変。",
      ],
    },
  },
  {
    id: "Athetatilde_004_claim_eigenvector",
    kind: "claim",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 6 },
    title: { tex: String.raw`A(\tilde\theta_\mu) \text{ の固有値と固有ベクトル}` },
    labels: ["eigenvector_of_A_theta_tilde"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " について、",
        math(String.raw`A(\tilde\theta_\mu)`),
        " の固有値（",
        ref("def_eigenvalue"),
        "）は",
      ]),
      displayMath(
        String.raw`\lambda_{\pm,\mu}
:= \gamma_1(\tilde\theta_\mu) \pm \sqrt{-\gamma_2(\tilde\theta_\mu)\,\gamma_2(-\tilde\theta_\mu)}
 = \gamma_1(\tilde\theta_\mu) \pm \left|\gamma_2(\tilde\theta_\mu)\right| \in \mathbb{R}`,
      ),
      paragraph([
        "の 2 つであり（",
        ref("relation_of_gamma_2_theta_tilde"),
        " (4) により根号は正の実数、したがって ",
        math(String.raw`\lambda_{+,\mu} \neq \lambda_{-,\mu}`),
        "）、",
        math(String.raw`c \in \mathbb{C}^\times`),
        " について",
      ]),
      displayMath(
        String.raw`v_{\pm,\mu}
:= c\begin{pmatrix} \pm i\,\sqrt{\gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu)} \\ \gamma_2(-\tilde\theta_\mu) \end{pmatrix}
= c\begin{pmatrix} \mp\left|\gamma_2(\tilde\theta_\mu)\right| \\ \gamma_2(-\tilde\theta_\mu) \end{pmatrix}`,
      ),
      paragraph([
        "は ",
        math(String.raw`A(\tilde\theta_\mu)`),
        " の ",
        math(String.raw`\lambda_{\pm,\mu}`),
        " に属する固有ベクトル（",
        ref("def_eigenvector"),
        "）である。",
        ref("gamma_2_theta_tilde_nonzero"),
        " により ",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " なので、場合分けは要らない。",
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`\theta := \tilde\theta_\mu`),
        "、",
        math(String.raw`g_1 := \gamma_1(\theta) \in \mathbb{R}`),
        "、",
        math(String.raw`a := \gamma_2(\theta) \in \mathbb{C}`),
        "、",
        math(String.raw`b := \gamma_2(-\theta) \in \mathbb{C}`),
        "、",
        math(String.raw`r := |a| \in \mathbb{R}_{>0}`),
        " と略記する（",
        ref("gamma_2_theta_tilde_nonzero"),
        " より ",
        math(String.raw`a \neq 0`),
        " なので ",
        math(String.raw`r > 0`),
        "）。",
        ref("relation_of_gamma_2_theta_tilde"),
        " より ",
        math(String.raw`b = -\bar a`),
        "、",
        math(String.raw`ab = -r^2`),
        "、",
        math(String.raw`\sqrt{-ab} = r`),
        "、",
        math(String.raw`\sqrt{ab} = ir`),
        " である。",
      ]),
      paragraph([
        "Step 1（固有値がこの 2 つに限ること）。",
        ref("def_gamma1_gamma2_of_theta"),
        " より ",
        math(String.raw`A(\theta) = \begin{pmatrix} g_1 & a \\ -b & g_1\end{pmatrix}`),
        " である。",
        math(String.raw`I := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "（",
        ref("def_identity_matrix"),
        "）とおき、",
        math(String.raw`\lambda \in \mathbb{C}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\lambda \text{ は } A(\theta) \text{ の固有値} \\
&\iff \exists\, v \in \mathbb{C}^2,\ v \neq 0 \ \text{かつ}\ A(\theta)v = \lambda v
   &&\bigl(\because \blkref{def_eigenvalue}\bigr) \\
&\iff \exists\, v \in \mathbb{C}^2,\ v \neq 0 \ \text{かつ}\ A(\theta)v - \lambda v = 0
   &&\bigl(\because \blkref{matrix_difference_zero_iff_equal}\text{ を } 2 \text{ 行 } 1 \text{ 列の行列 } A(\theta)v,\ \lambda v \text{ に適用}\bigr) \\
&\iff \exists\, v \in \mathbb{C}^2,\ v \neq 0 \ \text{かつ}\ A(\theta)v - \lambda (Iv) = 0
   &&\bigl(\because \blkref{identity_matrix_is_left_unit_of_mat_mult}\text{ を } 2 \text{ 行 } 1 \text{ 列の行列 } v \text{ に適用}\bigr) \\
&\iff \exists\, v \in \mathbb{C}^2,\ v \neq 0 \ \text{かつ}\ A(\theta)v - (\lambda I)v = 0
   &&\bigl(\because \blkref{scalar_multiple_factors_out_of_left_factor}\text{ を } a := \lambda,\ A := I,\ B := v \text{ に適用し、右辺から左辺へ}\bigr) \\
&\iff \exists\, v \in \mathbb{C}^2,\ v \neq 0 \ \text{かつ}\ \left(A(\theta) - \lambda I\right)v = 0
   &&\bigl(\because \blkref{matrix_difference_mul_vector}\bigr) \\
&\iff \det\left(A(\theta) - \lambda I\right) = 0
   &&\bigl(\because \blkref{nonzero_kernel_iff_det_zero_two_by_two}\text{ を } B := A(\theta) - \lambda I \text{ に適用}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "準備として、因数分解の恒等式を確かめる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\lambda - (g_1+r))(\lambda - (g_1-r))
&= \lambda^2 - (g_1-r)\lambda - (g_1+r)\lambda + (g_1+r)(g_1-r)
   \quad (\because \text{分配則}) \\
&= \lambda^2 - 2g_1\lambda + (g_1+r)(g_1-r)
   \quad (\because \text{同類項の統合}) \\
&= \lambda^2 - 2g_1\lambda + \left(g_1^2-g_1r+rg_1-r^2\right)
   \quad (\because \text{分配則}) \\
&= \lambda^2 - 2g_1\lambda + \left(g_1^2 - r^2\right)
   \quad (\because \mathbb{C}\text{ の乗法の可換則と加法逆元})
\end{aligned}`,
      ),
      paragraph(["そこで"]),
      displayMath(
        String.raw`\begin{aligned}
\det\left(A(\theta) - \lambda I\right)
&= \det\begin{pmatrix}
     A(\theta)_{11} - (\lambda I)_{11} & A(\theta)_{12} - (\lambda I)_{12} \\
     A(\theta)_{21} - (\lambda I)_{21} & A(\theta)_{22} - (\lambda I)_{22}
   \end{pmatrix}
   \quad (\because \blkref{def_matrix_difference}) \\
&= \det\begin{pmatrix}
     A(\theta)_{11} - \lambda I_{11} & A(\theta)_{12} - \lambda I_{12} \\
     A(\theta)_{21} - \lambda I_{21} & A(\theta)_{22} - \lambda I_{22}
   \end{pmatrix}
   \quad (\because \blkref{def_matrix_scalar_multiple}) \\
&= \det\begin{pmatrix}
     A(\theta)_{11} - \lambda \delta_{11} & A(\theta)_{12} - \lambda \delta_{12} \\
     A(\theta)_{21} - \lambda \delta_{21} & A(\theta)_{22} - \lambda \delta_{22}
   \end{pmatrix}
   \quad (\because \blkref{def_identity_matrix}) \\
&= \det\begin{pmatrix}
     A(\theta)_{11} - \lambda \cdot 1 & A(\theta)_{12} - \lambda \cdot 0 \\
     A(\theta)_{21} - \lambda \cdot 0 & A(\theta)_{22} - \lambda \cdot 1
   \end{pmatrix}
   \quad (\because \blkref{def_kronecker_delta}) \\
&= \det\begin{pmatrix}
     A(\theta)_{11} - \lambda & A(\theta)_{12} - \lambda \cdot 0 \\
     A(\theta)_{21} - \lambda \cdot 0 & A(\theta)_{22} - \lambda
   \end{pmatrix}
   \quad (\because x \cdot 1 = x\text{ を 2 成分へ同時適用}) \\
&= \det\begin{pmatrix}
     A(\theta)_{11} - \lambda & A(\theta)_{12} - 0 \\
     A(\theta)_{21} - 0 & A(\theta)_{22} - \lambda
   \end{pmatrix}
   \quad (\because x \cdot 0 = 0\text{ を 2 成分へ同時適用}) \\
&= \det\begin{pmatrix}
     A(\theta)_{11} - \lambda & A(\theta)_{12} \\
     A(\theta)_{21} & A(\theta)_{22} - \lambda
   \end{pmatrix}
   \quad (\because y - 0 = y\text{ を 2 成分へ同時適用}) \\
&= \det\begin{pmatrix} g_1-\lambda & a \\ -b & g_1-\lambda\end{pmatrix}
   \quad (\because \blkref{def_gamma1_gamma2_of_theta}) \\
&= (g_1-\lambda)(g_1-\lambda) - a\cdot(-b)
   \quad (\because \blkref{def_det_two_by_two}) \\
&= (g_1-\lambda)(g_1-\lambda) + ab
   \quad (\because \mathbb{C} \text{ の四則}\ (-a\cdot(-b) = ab)) \\
&= g_1^2-g_1\lambda-\lambda g_1+\lambda^2+ab
   \quad (\because \text{分配則}) \\
&= g_1^2-g_1\lambda-g_1\lambda+\lambda^2+ab
   \quad (\because \mathbb{C}\text{ の乗法の可換則}) \\
&= g_1^2-2g_1\lambda+\lambda^2+ab
   \quad (\because \text{同類項の統合}) \\
&= \lambda^2 - 2g_1\lambda + \left(g_1^2 + ab\right)
   \quad (\because \mathbb{C}\text{ の加法の交換則と結合則}) \\
&= \lambda^2 - 2g_1\lambda + \left(g_1^2 - r^2\right)
   \quad (\because \blkref{relation_of_gamma_2_theta_tilde}\ (ab = -r^2)) \\
&= (\lambda - (g_1+r))(\lambda - (g_1-r))
   \quad (\because \text{準備の因数分解の恒等式})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`\mathbb{C}`),
        " は体（",
        ref("complex_numbers_form_a_field"),
        "）ゆえ零因子を持たないから、この積が ",
        math(String.raw`0`),
        " になるのは ",
        math(String.raw`\lambda = g_1 \pm r`),
        " のときに限る。",
        ref("relation_of_gamma_2_theta_tilde"),
        " (4) の ",
        math(String.raw`\sqrt{-ab} = r`),
        " より、これは statement の ",
        math(String.raw`\lambda_{\pm,\mu}`),
        " に一致する。",
        math(String.raw`r > 0`),
        " なので ",
        math(String.raw`\lambda_{+,\mu} - \lambda_{-,\mu} = 2r \neq 0`),
        "。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`v_{\pm,\mu}`),
        " が固有ベクトルであること）。",
        ref("relation_of_gamma_2_theta_tilde"),
        " (5) より ",
        math(String.raw`\pm i\sqrt{ab} = \pm i\cdot ir = \mp r`),
        " なので、statement の 2 つの表示は一致する。",
        math(String.raw`c = 1`),
        " として ",
        math(String.raw`v_\pm := (\mp r,\ b)^{\mathsf{T}}`),
        " を代入すると、",
        math(String.raw`b = -\bar a`),
        " と ",
        math(String.raw`a\bar a = r^2`),
        " より第 1 成分は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(A(\theta)v_\pm\right)_1
&= g_1(\mp r) + a\,b
   \quad (\because \blkref{def_gamma1_gamma2_of_theta}\text{ と行列とベクトルの積の定義}) \\
&= \mp g_1 r + a\left(-\bar a\right)
   \quad (\because \blkref{relation_of_gamma_2_theta_tilde}\ (b = -\bar a)) \\
&= \mp g_1 r - r^2
   \quad (\because \blkref{abs_basic_properties}\ (a\bar a = |a|^2 = r^2)) \\
&= \left(g_1 \pm r\right)\left(\mp r\right)
   \quad (\because \text{分配則}\ (\left(g_1 \pm r\right)\left(\mp r\right) = \mp g_1 r - r^2)) \\
&= \lambda_{\pm,\mu}\,\left(v_\pm\right)_1
   \quad (\because \lambda_{\pm,\mu} = g_1 \pm r,\ \left(v_\pm\right)_1 = \mp r)
\end{aligned}`,
      ),
      paragraph([ref("def_gamma1_gamma2_of_theta"), "、", ref("relation_of_gamma_2_theta_tilde"), "、", ref("abs_basic_properties"), " が各行の根拠である。"]),
      paragraph(["第 2 成分は"]),
      displayMath(
        String.raw`\begin{aligned}
\left(A(\theta)v_\pm\right)_2
&= (-b)(\mp r) + g_1 b
   \quad (\because \blkref{def_gamma1_gamma2_of_theta}\text{ と行列とベクトルの積の定義}) \\
&= b(\pm r) + g_1 b
   \quad (\because \mathbb{C}\text{ の四則}\ ((-b)(\mp r) = b(\pm r))) \\
&= (\pm r)\,b + g_1 b
   \quad (\because \mathbb{C}\text{ の乗法の可換則}) \\
&= \left(\pm r + g_1\right)b
   \quad (\because \text{分配則で } b \text{ を括り出す}) \\
&= \left(g_1 \pm r\right)b
   \quad (\because \mathbb{C}\text{ の加法の交換則（下の符号では } g_1 + (-r) = g_1 - r \text{ と書く）}) \\
&= \lambda_{\pm,\mu}\,\left(v_\pm\right)_2
   \quad (\because \lambda_{\pm,\mu} = g_1 \pm r,\ \left(v_\pm\right)_2 = b)
\end{aligned}`,
      ),
      paragraph(["第 1 行の根拠は ", ref("def_gamma1_gamma2_of_theta"), " である。"]),
      paragraph([
        "よって ",
        math(String.raw`A(\theta)v_\pm = \lambda_{\pm,\mu}v_\pm`),
        "。",
        math(String.raw`b \neq 0`),
        "（",
        ref("relation_of_gamma_2_theta_tilde"),
        "）より ",
        math(String.raw`v_\pm \neq 0`),
        " であり、これは固有ベクトルである。",
        math(String.raw`c \in \mathbb{C}^\times`),
        " 倍しても固有ベクトルであることは次による。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A(\theta)(cv)
&= c\,A(\theta)v
   \quad (\because \text{行列とベクトルの積の各成分の分配則（スカラー倍は積の外へ出る）}) \\
&= c(\lambda v)
   \quad (\because \text{上で示した } A(\theta)v = \lambda v \text{ の代入}) \\
&= \lambda(cv)
   \quad (\because \text{複素数の積の可換性と、ベクトルのスカラー倍の結合})
\end{aligned}`,
      ),
      paragraph([
        "また ",
        math(String.raw`v \neq 0`),
        " なので ",
        math(String.raw`v_k \neq 0`),
        " となる成分 ",
        math(String.raw`k \in \{1, 2\}`),
        " があり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(cv)_k
&= c\,v_k
   \quad (\because \text{ベクトルのスカラー倍は成分ごとの積}) \\
&\neq 0
   \quad (\because c \neq 0,\ v_k \neq 0 \text{ と、}\mathbb{C}\text{ は体ゆえ零因子を持たないこと（}\blkref{complex_numbers_form_a_field}\text{）})
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`cv \neq 0`),
        "。よって ",
        math(String.raw`cv`),
        " も ",
        math(String.raw`\lambda`),
        " に属する固有ベクトル（",
        ref("def_eigenvector"),
        "）である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の eigenvector_of_A_theta は γ_2 = 0 の場合分けを持ち、γ_2 ≠ 0 の場合も複素平方根の分枝の扱い" +
          "（condition_of_commutativity_of_sqrt_and_product, inverse_of_sqrt_cc）を経由して固有ベクトルを導いていた。" +
          "半整数運動量では relation_of_gamma_2_theta_tilde (4)(5) で根号が |γ_2| と i|γ_2| に確定するので、" +
          "固有ベクトルは代入して確かめるだけで済む。得られる形は 008 章と同一である。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_03（特性方程式・固有ベクトル・Sage の固有値集合との一致、残差 ≤ 2e-12）。",
        "2026-08-19 の式変形統一で、Step 1 の「右辺を展開すれば左辺に一致する」と散文に畳まれていた因数分解を、" +
          "準備の恒等式と行列式の一続きの鎖へ開き、固有ベクトル成分の二本の鎖の根拠なしの行に行末根拠を補った。内容・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-01: Step 1 が「固有値」を定義せずに「固有値 ⟺ det(A(θ) − λI) = 0」を証明なしに使っていたので、" +
          "def_eigenvalue・def_eigenvector・def_det_two_by_two を数学的道具立てに置き、同値を nonzero_kernel_iff_det_zero_two_by_two（2×2 の成分計算）から引く同値の鎖にした。" +
          "Lean の eigenvalue_AMat_iff と同じ手順である。",
        "2026-11-01: Step 3（固有空間が 1 次元で、固有ベクトルは v_{±,μ} の ℂ^× 倍に限ること）と statement の「限る」の側を、" +
          "参照用ノート claims_unused_by_chapter_goals_not_adopted へ退避した。後段（diagonalization_check_P_D ほか）が使うのは " +
          "λ_{±,μ} の値と A(θ̃_μ)v_{±,μ} = λ_{±,μ}v_{±,μ} だけで、Step 3 は本文のどこからも使われず、" +
          "「階数」「固有空間」「次元」を本文で定義しないまま使っていたため。",
        "2026-11-01: c ∈ ℂ^× 倍が固有ベクトルであることのうち cv ≠ 0 の段が無かったので足した（Lean の isEigenvector_smul_eigen_pos/neg の smul_ne_zero と同じ手順）。",
        "2026-11-01: Step 2 の第 2 成分は b = -ā を代入して ā を括り出し、最後に (v_±)_2 = b = -ā で b へ戻す往復をしていた。" +
          "b のまま括り出す鎖にし、b = -ā を使わない形にした（Lean の必要十分版 skew2_mulVec_pos/neg の第 2 成分が仮定なしで閉じることの反映）。",
      ],
    },
  },
  {
    id: "Athetatilde_005_claim_diagonalization",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 7 },
    title: { tex: String.raw`A(\tilde\theta_\mu) \text{ の対角化 } (\check{P}_\mu,\, \check{D}_\mu)` },
    labels: ["diagonalization_check_P_D"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " について、",
        ref("eigenvector_of_A_theta_tilde"),
        " の任意定数を ",
        math(String.raw`c = \dfrac{1}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\mu)}`),
        " と選んで",
      ]),
      displayMath(
        String.raw`\check{P}_\mu
:= \begin{pmatrix}
\dfrac{-\left|\gamma_2(\tilde\theta_\mu)\right|}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\mu)}
& \dfrac{+\left|\gamma_2(\tilde\theta_\mu)\right|}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\mu)} \\[8pt]
\dfrac{1}{2\sqrt{M_{\mathrm{col}}}} & \dfrac{1}{2\sqrt{M_{\mathrm{col}}}}
\end{pmatrix},
\qquad
\check{D}_\mu := \begin{pmatrix} \lambda_{+,\mu} & 0 \\ 0 & \lambda_{-,\mu}\end{pmatrix}`,
      ),
      paragraph(["とおく。このとき"]),
      displayMath(
        String.raw`\det\check{P}_\mu
= \frac{-\left|\gamma_2(\tilde\theta_\mu)\right|}{2M_{\mathrm{col}}\,\gamma_2(-\tilde\theta_\mu)} \neq 0_{\mathbb{C}},
\qquad
A(\tilde\theta_\mu) = \check{P}_\mu\,\check{D}_\mu\,\check{P}_\mu^{-1}`,
      ),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("eigenvector_of_A_theta_tilde"),
        " の記号 ",
        math(String.raw`a := \gamma_2(\tilde\theta_\mu)`),
        "、",
        math(String.raw`b := \gamma_2(-\tilde\theta_\mu)`),
        "、",
        math(String.raw`r := |a|`),
        " を使う。",
      ]),
      paragraph([
        "Step 1（各成分が定まること）。",
        ref("gamma_2_theta_tilde_nonzero"),
        " と ",
        ref("relation_of_gamma_2_theta_tilde"),
        " より ",
        math(String.raw`a \neq 0`),
        " かつ ",
        math(String.raw`b \neq 0`),
        "。また ",
        math(String.raw`M_{\mathrm{col}} \geq 2`),
        " より ",
        math(String.raw`\sqrt{M_{\mathrm{col}}} > 0`),
        "（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）。よって分母 ",
        math(String.raw`2\sqrt{M_{\mathrm{col}}}\,b \neq 0`),
        " であり、",
        math(String.raw`c := \dfrac{1}{2\sqrt{M_{\mathrm{col}}}\,b} \in \mathbb{C}^\times`),
        " が定まって ",
        math(String.raw`\check{P}_\mu`),
        " の 4 成分はすべて定まる。",
      ]),
      paragraph([
        "Step 2（2 つの列が固有ベクトルであること）。",
        ref("eigenvector_of_A_theta_tilde"),
        " の ",
        math(String.raw`v_{\pm,\mu} = c(\mp r,\ b)^{\mathsf{T}}`),
        " に上の ",
        math(String.raw`c`),
        " を代入すると、第 2 成分は次の鎖で定まる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
cb
&= \frac{1}{2\sqrt{M_{\mathrm{col}}}\,b}\,b
   \quad (\because c\text{ の定義}) \\
&= \frac{1}{2\sqrt{M_{\mathrm{col}}}}
   \quad (\because b\ne0\text{ と }\mathbb{C}\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`v_{+,\mu}, v_{-,\mu}`),
        " はそれぞれ ",
        math(String.raw`\check{P}_\mu`),
        " の第 1 列・第 2 列に一致する。行列の積を列ごとに見れば",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A(\tilde\theta_\mu)\,\check{P}_\mu
&= \left(A(\tilde\theta_\mu)v_{+,\mu}\ \ A(\tilde\theta_\mu)v_{-,\mu}\right)
   \quad (\because \text{行列の積を列ごとに見た}) \\
&= \left(\lambda_{+,\mu}v_{+,\mu}\ \ \lambda_{-,\mu}v_{-,\mu}\right)
   \quad (\because \blkref{eigenvector_of_A_theta_tilde}\text{ を 2 列へ同時適用}) \\
&= \check{P}_\mu\,\check{D}_\mu
   \quad (\because \check{D}_\mu = \mathrm{diag}(\lambda_{+,\mu}, \lambda_{-,\mu}) \text{ の右乗が列ごとのスカラー倍})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（",
        math(String.raw`\det\check{P}_\mu`),
        "）。",
        ref("def_det_two_by_two"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\det\check{P}_\mu
&= \frac{-r}{2\sqrt{M_{\mathrm{col}}}\,b}\cdot\frac{1}{2\sqrt{M_{\mathrm{col}}}}
 - \frac{+r}{2\sqrt{M_{\mathrm{col}}}\,b}\cdot\frac{1}{2\sqrt{M_{\mathrm{col}}}}
   \quad (\because \blkref{def_det_two_by_two}) \\
&= \frac{-r}{4M_{\mathrm{col}}\,b} - \frac{+r}{4M_{\mathrm{col}}\,b}
   \quad \left(\because \left(2\sqrt{M_{\mathrm{col}}}\right)^2 = 4M_{\mathrm{col}}\right) \\
&= \frac{-r}{4M_{\mathrm{col}}\,b} + \frac{-r}{4M_{\mathrm{col}}\,b}
   \quad (\because -\tfrac{+r}{4M_{\mathrm{col}}\,b}=\tfrac{-r}{4M_{\mathrm{col}}\,b}\text{。}\mathbb{C}\text{ の四則}) \\
&= 2\cdot\frac{-r}{4M_{\mathrm{col}}\,b}
   \quad (\because \text{同類項の統合}) \\
&= \frac{-r}{2M_{\mathrm{col}}\,b}
   \quad (\because 2M_{\mathrm{col}}\ne0\text{ と }\mathbb{C}\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`r > 0`),
        "、",
        math(String.raw`2M_{\mathrm{col}} \neq 0`),
        "、",
        math(String.raw`b \neq 0`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " が零因子を持たないこと（",
        ref("complex_numbers_form_a_field"),
        "）から ",
        math(String.raw`\det\check{P}_\mu \neq 0_{\mathbb{C}}`),
        "。",
      ]),
      paragraph([
        "Step 4（対角化）。",
        math(String.raw`\det\check{P}_\mu \neq 0`),
        " より ",
        math(String.raw`\check{P}_\mu^{-1}`),
        " が存在するので、Step 2 の両辺に右から掛けて ",
        "次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A(\tilde\theta_\mu)
&= A(\tilde\theta_\mu)\left(\check{P}_\mu\check{P}_\mu^{-1}\right)
   \quad (\because \check{P}_\mu\check{P}_\mu^{-1}=I\text{ と積の単位元}) \\
&= \left(A(\tilde\theta_\mu)\check{P}_\mu\right)\check{P}_\mu^{-1}
   \quad (\because \text{行列の積の結合則}) \\
&= \left(\check{P}_\mu\check{D}_\mu\right)\check{P}_\mu^{-1}
   \quad (\because \text{Step 2}) \\
&= \check{P}_\mu\check{D}_\mu\check{P}_\mu^{-1}
   \quad (\because \text{行列の積の結合則})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "正規化 c = 1/(2√M γ_2(−θ~_μ)) は 008 章の diagonalization_P_D と同じに揃えた（後段の半整数運動量フェルミオンで" +
          "同じ規格化を使うため）。008 章の P_μ の (1,1) 成分 +i√(γ_2(θ)γ_2(−θ))/(2√M γ_2(−θ)) は、" +
          "relation_of_gamma_2_theta_tilde (5) により半整数運動量では −|γ_2|/(2√M γ_2(−θ~)) に等しい。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_03（det の明示式との一致、|det| ≥ 6.25e-2、" +
          "A − P̌ Ď P̌^{-1} の残差 ≤ 3e-14）。",
        "2026-08-19 の式変形統一で、固有ベクトルの第 2 成分の約分、行列式の同類項の統合、対角化の右乗を、" +
          "それぞれ主張の左辺から始まる一続きの鎖と行末根拠へ開いた。内容・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "Athetatilde_006_claim_det_A",
    kind: "claim",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 8 },
    title: { tex: String.raw`\det A(\tilde\theta_\mu) = 1` },
    labels: ["det_A_theta_tilde"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " について、",
      ]),
      displayMath(
        String.raw`\det A(\tilde\theta_\mu) = 1,
\qquad
\gamma_1(\tilde\theta_\mu)^2 + \gamma_2(\tilde\theta_\mu)\gamma_2(-\tilde\theta_\mu) = 1,
\qquad
\lambda_{+,\mu}\,\lambda_{-,\mu} = 1`,
      ),
      paragraph([
        "が成り立つ（第 1・第 2 の等式は ",
        math(String.raw`\mathbb{C}`),
        " の等式で、実数 ",
        math(String.raw`\gamma_1(\tilde\theta_\mu)`),
        " と ",
        math(String.raw`1`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の像として読む。",
        math(String.raw`\lambda_{\pm,\mu} \in \mathbb{R}`),
        "（",
        ref("eigenvector_of_A_theta_tilde"),
        "）なので第 3 の等式は ",
        math(String.raw`\mathbb{R}`),
        " の等式である）。とくに ",
        ref("relation_of_gamma_2_theta_tilde"),
        " (2) と合わせて",
      ]),
      displayMath(
        String.raw`\gamma_1(\tilde\theta_\mu)^2 = 1 + \left|\gamma_2(\tilde\theta_\mu)\right|^2`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathbb{R}`),
        " の等式。",
        math(String.raw`\left|\gamma_2(\tilde\theta_\mu)\right|`),
        " は ",
        ref("def_abs_arg"),
        " の絶対値、二乗 ",
        math(String.raw`\gamma_1(\tilde\theta_\mu)^2`),
        "・",
        math(String.raw`\left|\gamma_2(\tilde\theta_\mu)\right|^2`),
        " は ",
        ref("def_power_of_real_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "）である）。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`\theta := \tilde\theta_\mu`),
        " と略記する。",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`\theta \in \mathbb{R}`),
        " である。",
        math(String.raw`c_1, s_1, c_2, c_2^*, s_2^* \in \mathbb{R}`),
        " は ",
        ref("def_indexed_hyperbolic_abbreviations"),
        " の略記、",
        math(String.raw`u := \cos\theta \in \mathbb{R}`),
        "・",
        math(String.raw`v := \sin\theta \in \mathbb{R}`),
        " は ",
        ref("euler_formula_cos_sin"),
        " の前置きのとおり全実数上の ",
        math(String.raw`\cos, \sin`),
        " の値（全実数上への拡張は未整備）、",
        math(String.raw`a_0 := c_1u - s_1c_2 \in \mathbb{R}`),
        "、",
        math(String.raw`r := \left|\gamma_2(\theta)\right| \in \mathbb{R}`),
        "（",
        ref("def_abs_arg"),
        "）とおく。",
        math(String.raw`i = (0_{\mathbb{R}}, 1_{\mathbb{R}})`),
        " は ",
        ref("def_imaginary_unit"),
        " の虚数単位、",
        math(String.raw`e_+ := \exp(i\theta) \in \mathbb{C}`),
        "・",
        math(String.raw`e_- := \exp(-i\theta) \in \mathbb{C}`),
        " とする。",
        math(String.raw`e_-`),
        " の ",
        math(String.raw`-i\theta`),
        " は、",
        ref("euler_formula_cos_sin"),
        "・",
        ref("exp_of_negative_i_real_as_cos_minus_i_sin"),
        "・",
        ref("def_A_theta"),
        " の読みのとおり ",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-(i\theta)`),
        " である。実数が ",
        math(String.raw`\mathbb{C}`),
        " の式に現れるときは、",
        ref("def_gamma1_gamma2_of_theta"),
        " の書き方に従い ",
        ref("inclusion_rr_to_cc"),
        " の像 ",
        math(String.raw`x_{\mathbb{C}}`),
        " として読み、像の記号を省く。",
        math(String.raw`x, y \in \mathbb{R}`),
        " について ",
        math(String.raw`x_{\mathbb{C}}y_{\mathbb{C}} = (xy)_{\mathbb{C}}`),
        "（",
        ref("real_inclusion_preserves_product"),
        "）、",
        math(String.raw`x_{\mathbb{C}} + y_{\mathbb{C}} = (x+y)_{\mathbb{C}}`),
        "（",
        ref("real_inclusion_preserves_sum"),
        "）、",
        math(String.raw`x_{\mathbb{C}} - y_{\mathbb{C}} = (x-y)_{\mathbb{C}}`),
        "（",
        ref("real_inclusion_preserves_difference"),
        "）なので、実数の和・差・積の像は像の和・差・積である。",
        math(String.raw`\mathbb{C}`),
        " の和と積の結合律・可換律・分配律・単位元・零元・加法逆元・乗法の逆元は ",
        ref("complex_numbers_form_a_field"),
        " による。",
        math(String.raw`w \neq 0_{\mathbb{C}}`),
        " について ",
        math(String.raw`w^{-1}`),
        " はその乗法の逆元、商は ",
        math(String.raw`z/w := z\,w^{-1}`),
        " とする。",
        math(String.raw`2_{\mathbb{C}} = (2,0)`),
        "、",
        math(String.raw`i = (0,1)`),
        "、",
        math(String.raw`2_{\mathbb{C}}\,i = (2\cdot 0 - 0\cdot 1,\ 2\cdot 1 + 0\cdot 0) = (0,2)`),
        "（",
        ref("definition_of_cc"),
        " の積）は、いずれも成分の一つが ",
        math(String.raw`0`),
        " でないので ",
        math(String.raw`0_{\mathbb{C}} = (0,0)`),
        " と異なり、逆元を持つ。",
      ]),
      paragraph([
        "第一に、",
        math(String.raw`-(-z) = z`),
        "（",
        math(String.raw`z \in \mathbb{C}`),
        "）、",
        math(String.raw`ii = -1_{\mathbb{C}}`),
        "、",
        math(String.raw`e_+e_- = 1_{\mathbb{C}}`),
        "、",
        math(String.raw`x, y \in \mathbb{C}`),
        " についての ",
        math(String.raw`(x - iy)(x + iy) = x^2 + y^2`),
        " と ",
        math(String.raw`(x - y)^2 = x^2 - 2_{\mathbb{C}}(xy) + y^2`),
        "、",
        math(String.raw`u + iv = e_+`),
        "、",
        math(String.raw`u^2 + v^2 = 1_{\mathbb{C}}`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
-(-z)
&= (-1_{\mathbb{C}})\bigl((-1_{\mathbb{C}})z\bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 2 箇所へ})\\
&= \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)z
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= \bigl((-1)(-1)\bigr)_{\mathbb{C}}\,z
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= 1_{\mathbb{C}}\,z
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= z
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
ii
&= (0,1)(0,1)
&&(\because\ \blkref{def_imaginary_unit})\\
&= (0\cdot 0 - 1\cdot 1,\ 0\cdot 1 + 1\cdot 0)
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= (-1, 0)
&&(\because\ \mathbb{R}\ \text{の四則})\\
&= -1_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{を右辺から左辺へ})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
e_+e_-
&= \exp(i\theta)\exp(-i\theta)
&&(\because\ e_\pm\ \text{の定義})\\
&= \exp\bigl(i\theta + (-i\theta)\bigr)
&&(\because\ \blkref{scalar_exp_product}\ \text{を}\ K = \mathbb{C}\ \text{で})\\
&= \exp(0_{\mathbb{C}})
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法逆元})\\
&= 1_{\mathbb{C}}
&&(\because\ \blkref{scalar_exp_zero}\ \text{を}\ K = \mathbb{C}\ \text{で})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(x - iy)(x + iy)
&= \bigl(x + (-(iy))\bigr)(x + iy)
&&(\because\ \blkref{def_complex_difference})\\
&= \bigl(x + (-1_{\mathbb{C}})(iy)\bigr)(x + iy)
&&(\because\ \blkref{multiply_by_minus_one})\\
&= x(x + iy) + \bigl((-1_{\mathbb{C}})(iy)\bigr)(x + iy)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律（外側の積へ）})\\
&= \bigl(xx + x(iy)\bigr) + \Bigl(\bigl((-1_{\mathbb{C}})(iy)\bigr)x + \bigl((-1_{\mathbb{C}})(iy)\bigr)(iy)\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を 2 箇所へ（内側の積へ）})\\
&= xx + x(iy) + \bigl((-1_{\mathbb{C}})(iy)\bigr)x + \bigl((-1_{\mathbb{C}})(iy)\bigr)(iy)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律を右辺から左辺へ})\\
&= xx + (iy)x + (-1_{\mathbb{C}})\bigl((iy)x\bigr) + (-1_{\mathbb{C}})\bigl((iy)(iy)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= xx + \Bigl((iy)x + (-1_{\mathbb{C}})\bigl((iy)x\bigr)\Bigr) + (-1_{\mathbb{C}})\bigl((iy)(iy)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律})\\
&= xx + \Bigl((iy)x + \bigl(-((iy)x)\bigr)\Bigr) + (-1_{\mathbb{C}})\bigl((iy)(iy)\bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を右辺から左辺へ})\\
&= xx + 0_{\mathbb{C}} + (-1_{\mathbb{C}})\bigl((iy)(iy)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法逆元})\\
&= xx + (-1_{\mathbb{C}})\bigl((iy)(iy)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零元})\\
&= xx + (-1_{\mathbb{C}})\bigl((ii)(yy)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= xx + (-1_{\mathbb{C}})\bigl((-1_{\mathbb{C}})(yy)\bigr)
&&(\because\ \text{上の}\ ii = -1_{\mathbb{C}})\\
&= xx + \bigl(-(-(yy))\bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 2 箇所へ右辺から左辺へ})\\
&= xx + yy
&&(\because\ \text{上の}\ -(-z) = z)\\
&= x^2 + y^2
&&(\because\ \blkref{square_of_complex_number_is_product}\ \text{の}\ z^2 = zz\ \text{を 2 箇所へ右辺から左辺へ})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(x - y)^2
&= (x - y)(x - y)
&&(\because\ \blkref{square_of_complex_number_is_product}\ \text{の}\ z^2 = zz)\\
&= \bigl(x + (-y)\bigr)\bigl(x + (-y)\bigr)
&&(\because\ \blkref{def_complex_difference}\ \text{を 2 箇所へ})\\
&= \bigl(x + (-1_{\mathbb{C}})y\bigr)\bigl(x + (-1_{\mathbb{C}})y\bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 2 箇所へ})\\
&= x\bigl(x + (-1_{\mathbb{C}})y\bigr) + \bigl((-1_{\mathbb{C}})y\bigr)\bigl(x + (-1_{\mathbb{C}})y\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律（外側の積へ）})\\
&= \Bigl(xx + x\bigl((-1_{\mathbb{C}})y\bigr)\Bigr) + \Bigl(\bigl((-1_{\mathbb{C}})y\bigr)x + \bigl((-1_{\mathbb{C}})y\bigr)\bigl((-1_{\mathbb{C}})y\bigr)\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を 2 箇所へ（内側の積へ）})\\
&= xx + x\bigl((-1_{\mathbb{C}})y\bigr) + \bigl((-1_{\mathbb{C}})y\bigr)x + \bigl((-1_{\mathbb{C}})y\bigr)\bigl((-1_{\mathbb{C}})y\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律を右辺から左辺へ})\\
&= xx + (-1_{\mathbb{C}})(xy) + (-1_{\mathbb{C}})(xy) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)(yy)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= xx + \bigl((-1_{\mathbb{C}})(xy) + (-1_{\mathbb{C}})(xy)\bigr) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)(yy)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律})\\
&= xx + \bigl((-1_{\mathbb{C}}) + (-1_{\mathbb{C}})\bigr)(xy) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)(yy)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を右辺から左辺へ})\\
&= xx + \bigl((-1) + (-1)\bigr)_{\mathbb{C}}(xy) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)(yy)
&&(\because\ \blkref{real_inclusion_preserves_finite_sum}\ \text{を}\ m = 2\ \text{で})\\
&= xx + \bigl((-1) + (-1)\bigr)_{\mathbb{C}}(xy) + \bigl((-1)(-1)\bigr)_{\mathbb{C}}(yy)
&&(\because\ \blkref{real_inclusion_preserves_product})\\
&= xx + \bigl((-1)\cdot 2\bigr)_{\mathbb{C}}(xy) + 1_{\mathbb{C}}(yy)
&&(\because\ \mathbb{R}\ \text{の四則を 2 箇所へ})\\
&= xx + \bigl((-1_{\mathbb{C}})\,2_{\mathbb{C}}\bigr)(xy) + 1_{\mathbb{C}}(yy)
&&(\because\ \blkref{real_inclusion_preserves_product}\ \text{を右辺から左辺へ})\\
&= xx + (-1_{\mathbb{C}})\bigl(2_{\mathbb{C}}(xy)\bigr) + 1_{\mathbb{C}}(yy)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= xx + (-1_{\mathbb{C}})\bigl(2_{\mathbb{C}}(xy)\bigr) + yy
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&= xx + \bigl(-\bigl(2_{\mathbb{C}}(xy)\bigr)\bigr) + yy
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を右辺から左辺へ})\\
&= xx - 2_{\mathbb{C}}(xy) + yy
&&(\because\ \blkref{def_complex_difference}\ \text{を右辺から左辺へ})\\
&= x^2 - 2_{\mathbb{C}}(xy) + y^2
&&(\because\ \blkref{square_of_complex_number_is_product}\ \text{の}\ z^2 = zz\ \text{を 2 箇所へ右辺から左辺へ})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
u + iv
&= \frac{e_+ + e_-}{2} + i\,\frac{e_+ - e_-}{2i}
&&(\because\ \blkref{euler_formula_cos_sin}\ \text{を 2 箇所へ})\\
&= (e_+ + e_-)\,2_{\mathbb{C}}^{-1} + i\bigl((e_+ - e_-)(2_{\mathbb{C}}i)^{-1}\bigr)
&&(\because\ \text{準備の商}\ z/w := zw^{-1}\ \text{を 2 箇所へ})\\
&= (e_+ + e_-)\,2_{\mathbb{C}}^{-1} + (e_+ - e_-)\bigl(i\,(2_{\mathbb{C}}i)^{-1}\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= (e_+ + e_-)\,2_{\mathbb{C}}^{-1} + (e_+ - e_-)\bigl(i\,(2_{\mathbb{C}}^{-1}i^{-1})\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の乗法の逆元の一意性より}\ (2_{\mathbb{C}}i)^{-1} = 2_{\mathbb{C}}^{-1}i^{-1})\\
&= (e_+ + e_-)\,2_{\mathbb{C}}^{-1} + (e_+ - e_-)\bigl(2_{\mathbb{C}}^{-1}(i\,i^{-1})\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= (e_+ + e_-)\,2_{\mathbb{C}}^{-1} + (e_+ - e_-)\bigl(2_{\mathbb{C}}^{-1}1_{\mathbb{C}}\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の乗法の逆元})\\
&= (e_+ + e_-)\,2_{\mathbb{C}}^{-1} + (e_+ - e_-)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&= \bigl((e_+ + e_-) + (e_+ - e_-)\bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律}\ \text{を右辺から左辺へ})\\
&= \Bigl((e_+ + e_-) + \bigl(e_+ + (-e_-)\bigr)\Bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{def_complex_difference})\\
&= \Bigl(e_+ + e_+ + \bigl(e_- + (-e_-)\bigr)\Bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律・可換律})\\
&= \bigl(e_+ + e_+ + 0_{\mathbb{C}}\bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法逆元})\\
&= \bigl(e_+ + e_+\bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零元})\\
&= \bigl(1_{\mathbb{C}}e_+ + 1_{\mathbb{C}}e_+\bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元}\ \text{を右辺から左辺へ})\\
&= \bigl((1_{\mathbb{C}} + 1_{\mathbb{C}})e_+\bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律}\ \text{を右辺から左辺へ})\\
&= \bigl((1 + 1)_{\mathbb{C}}e_+\bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{real_inclusion_preserves_finite_sum}\ \text{を}\ m = 2\ \text{で})\\
&= \bigl(2_{\mathbb{C}}e_+\bigr)\,2_{\mathbb{C}}^{-1}
&&(\because\ \mathbb{R}\ \text{の四則}\ 1 + 1 = 2)\\
&= e_+\bigl(2_{\mathbb{C}}\,2_{\mathbb{C}}^{-1}\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= e_+\,1_{\mathbb{C}}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の乗法の逆元})\\
&= e_+
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
u^2 + v^2
&= (u - iv)(u + iv)
&&(\because\ \text{上の}\ (x - iy)(x + iy) = x^2 + y^2\ \text{を}\ x = u,\ y = v\ \text{で右辺から左辺へ})\\
&= e_-\,(u + iv)
&&(\because\ \blkref{exp_of_negative_i_real_as_cos_minus_i_sin}\ \text{を右辺から左辺へ})\\
&= e_-\,e_+
&&(\because\ \text{上の}\ u + iv = e_+)\\
&= e_+e_-
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&= 1_{\mathbb{C}}
&&(\because\ \text{上の}\ e_+e_- = 1_{\mathbb{C}})
\end{aligned}`),
      paragraph([
        "第二に、",
        math(String.raw`\gamma_2(\theta)`),
        "・",
        math(String.raw`\gamma_2(-\theta)`),
        " とその積を ",
        math(String.raw`a_0, v`),
        " で書く。",
        math(String.raw`\gamma_2(-\theta)`),
        " は ",
        ref("def_gamma1_gamma2_of_theta"),
        " が述べる ",
        math(String.raw`A(\theta)`),
        " の ",
        math(String.raw`(2,1)`),
        " 成分 ",
        math(String.raw`-\gamma_2(-\theta)`),
        " と ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`(2,1)`),
        " 成分を比べて得る（",
        ref("def_A_theta"),
        " の ",
        math(String.raw`(2,1)`),
        " 成分は、その定義に書いた読みのとおり、先頭の ",
        math(String.raw`-i`),
        " を ",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-i`),
        " とし、四つの因子の積を左から順に括ったものである）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta)
&= i\,e_+\,s_2^*\bigl(c_1u - iv - s_1c_2\bigr)
&&(\because\ \blkref{def_gamma1_gamma2_of_theta})\\
&= i\,e_+\,s_2^*\bigl((c_1u - s_1c_2) - iv\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律・可換律})\\
&= i\,e_+\,s_2^*\bigl(a_0 - iv\bigr)
&&(\because\ a_0\ \text{の定義})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\gamma_2(-\theta)
&= -\bigl(-\gamma_2(-\theta)\bigr)
&&(\because\ \text{上の}\ -(-z) = z)\\
&= -A(\theta)_{2,1}
&&(\because\ \blkref{def_gamma1_gamma2_of_theta}\ \text{の}\ (2,1)\ \text{成分})\\
&= -\Bigl(\Bigl(\bigl((-i)e_-\bigr)s_2^*\Bigr)(c_1u + iv - s_1c_2)\Bigr)
&&(\because\ \blkref{def_A_theta}\ \text{の}\ (2,1)\ \text{成分})\\
&= -\Bigl(\Bigl(\bigl(-(i\,e_-)\bigr)s_2^*\Bigr)(c_1u + iv - s_1c_2)\Bigr)
&&\bigl(\because\ \blkref{negative_i_times_complex_is_negation_of_i_times}\ (z \to e_-)\bigr)\\
&= -\Bigl(\Bigl(-\bigl((i\,e_-)s_2^*\bigr)\Bigr)(c_1u + iv - s_1c_2)\Bigr)
&&\bigl(\because\ \mathbb{C}\ \text{で}\ (-x)y = -(xy)\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ x \to i\,e_-,\ y \to s_2^*\bigr)\\
&= -\Bigl(-\Bigl(\bigl((i\,e_-)s_2^*\bigr)(c_1u + iv - s_1c_2)\Bigr)\Bigr)
&&\bigl(\because\ \mathbb{C}\ \text{で}\ (-x)y = -(xy)\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ x \to (i\,e_-)s_2^*,\ y \to c_1u + iv - s_1c_2\bigr)\\
&= i\,e_-\,s_2^*\bigl(c_1u + iv - s_1c_2\bigr)
&&(\because\ \text{上の}\ -(-z) = z)\\
&= i\,e_-\,s_2^*\bigl((c_1u - s_1c_2) + iv\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律・可換律})\\
&= i\,e_-\,s_2^*\bigl(a_0 + iv\bigr)
&&(\because\ a_0\ \text{の定義})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta)\gamma_2(-\theta)
&= \bigl(i\,e_+\,s_2^*(a_0 - iv)\bigr)\gamma_2(-\theta)
&&(\because\ \text{上の}\ \gamma_2(\theta)\ \text{の表示})\\
&= \bigl(i\,e_+\,s_2^*(a_0 - iv)\bigr)\bigl(i\,e_-\,s_2^*(a_0 + iv)\bigr)
&&(\because\ \text{上の}\ \gamma_2(-\theta)\ \text{の表示})\\
&= (ii)(e_+e_-)(s_2^*s_2^*)\bigl((a_0 - iv)(a_0 + iv)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= (-1_{\mathbb{C}})(e_+e_-)(s_2^*s_2^*)\bigl((a_0 - iv)(a_0 + iv)\bigr)
&&(\because\ \text{上の}\ ii = -1_{\mathbb{C}})\\
&= (-1_{\mathbb{C}})\,1_{\mathbb{C}}\,(s_2^*s_2^*)\bigl((a_0 - iv)(a_0 + iv)\bigr)
&&(\because\ \text{上の}\ e_+e_- = 1_{\mathbb{C}})\\
&= (-1_{\mathbb{C}})(s_2^*s_2^*)\bigl((a_0 - iv)(a_0 + iv)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&= (-1_{\mathbb{C}})(s_2^*s_2^*)\bigl(a_0^2 + v^2\bigr)
&&(\because\ \text{上の}\ (x - iy)(x + iy) = x^2 + y^2\ \text{を}\ x = a_0,\ y = v\ \text{で})\\
&= (-1_{\mathbb{C}})\Bigl((s_2^*s_2^*)\bigl(a_0^2 + v^2\bigr)\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= (-1_{\mathbb{C}})\Bigl((s_2^*)^2\bigl(a_0^2 + v^2\bigr)\Bigr)
&&(\because\ \blkref{square_of_complex_number_is_product}\ \text{の}\ z^2 = zz\ \text{を右辺から左辺へ})\\
&= -\Bigl((s_2^*)^2\bigl(a_0^2 + v^2\bigr)\Bigr)
&&(\because\ \blkref{multiply_by_minus_one})
\end{aligned}`),
      paragraph([
        "第三に、",
        ref("cosh_sinh_basic_properties"),
        " (2) と ",
        ref("duality_c2_star_eq_s2_star_c2"),
        " から ",
        math(String.raw`c_1, s_1, c_2, c_2^*, s_2^*`),
        " の間の ",
        math(String.raw`\mathbb{R}`),
        " の関係を三つ作る（",
        math(String.raw`2K_1, 2K_2^* \in \mathbb{R}`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " の結合定数と第二の双対結合定数の 2 倍である）。",
      ]),
      displayMath(String.raw`\begin{aligned}
c_1^2 - s_1^2
&= (\cosh 2K_1)^2 - (\sinh 2K_1)^2
&&(\because\ \blkref{def_indexed_hyperbolic_abbreviations})\\
&= 1
&&(\because\ \blkref{cosh_sinh_basic_properties}\ (2)\ \text{を}\ x = 2K_1\ \text{で})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(c_2^*)^2 - (s_2^*)^2
&= (\cosh 2K_2^*)^2 - (\sinh 2K_2^*)^2
&&(\because\ \blkref{def_indexed_hyperbolic_abbreviations})\\
&= 1
&&(\because\ \blkref{cosh_sinh_basic_properties}\ (2)\ \text{を}\ x = 2K_2^*\ \text{で})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
c_2s_2^*
&= s_2^*c_2
&&(\because\ \mathbb{R}\ \text{の積の可換律})\\
&= c_2^*
&&(\because\ \blkref{duality_c2_star_eq_s2_star_c2})
\end{aligned}`),
      paragraph([
        "第 2 の等式は、主張の左辺から次のとおりである（",
        math(String.raw`\mathbb{C}`),
        " の等式）。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta) \\
&\quad= \bigl(c_1c_2^* - s_1s_2^*u\bigr)^2 + \gamma_2(\theta)\gamma_2(-\theta)
&&(\because\ \blkref{def_gamma1_gamma2_of_theta})\\
&\quad= \bigl(c_1c_2^* - s_1s_2^*u\bigr)^2 + \Bigl(-\bigl((s_2^*)^2(a_0^2 + v^2)\bigr)\Bigr)
&&(\because\ \text{上の}\ \gamma_2(\theta)\gamma_2(-\theta)\ \text{の鎖})\\
&\quad= \bigl(c_1c_2^* - s_1s_2^*u\bigr)^2 - (s_2^*)^2\bigl(a_0^2 + v^2\bigr)
&&(\because\ \blkref{def_complex_difference})\\
&\quad= \bigl(c_1c_2^* - s_1s_2^*u\bigr)^2 - (s_2^*)^2\bigl(a_0^2 + (1 - u^2)\bigr)
&&(\because\ \text{上の}\ u^2 + v^2 = 1_{\mathbb{C}}\ \text{を移項した}\ v^2 = 1 - u^2)\\
&\quad= \bigl(c_1c_2^* - s_1s_2^*u\bigr)^2 - (s_2^*)^2\Bigl(a_0^2 + \bigl(1 + (-u^2)\bigr)\Bigr)
&&(\because\ \blkref{def_complex_difference})\\
&\quad= \bigl(c_1c_2^* - s_1s_2^*u\bigr)^2 - (s_2^*)^2\bigl(a_0^2 + 1 + (-u^2)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律})\\
&\quad= \bigl(c_1c_2^* - s_1s_2^*u\bigr)^2 - (s_2^*)^2\bigl(a_0^2 + 1 - u^2\bigr)
&&(\because\ \blkref{def_complex_difference}\ \text{を右辺から左辺へ})\\
&\quad= \bigl(c_1c_2^* - s_1s_2^*u\bigr)^2 - (s_2^*)^2\bigl((c_1u - s_1c_2)^2 + 1 - u^2\bigr)
&&(\because\ a_0\ \text{の定義})\\
&\quad= (c_1c_2^*)^2 - 2_{\mathbb{C}}\bigl((c_1c_2^*)(s_1s_2^*u)\bigr) + (s_1s_2^*u)^2 \\
&\qquad\quad - (s_2^*)^2\Bigl((c_1u)^2 - 2_{\mathbb{C}}\bigl((c_1u)(s_1c_2)\bigr) + (s_1c_2)^2 + 1 - u^2\Bigr)
&&(\because\ \text{上の}\ (x - y)^2 = x^2 - 2_{\mathbb{C}}(xy) + y^2\ \text{を 2 箇所へ})\\
&\quad= (c_1c_2^*)(c_1c_2^*) - 2_{\mathbb{C}}\bigl((c_1c_2^*)(s_1s_2^*u)\bigr) + (s_1s_2^*u)(s_1s_2^*u) \\
&\qquad\quad - (s_2^*s_2^*)\Bigl((c_1u)(c_1u) - 2_{\mathbb{C}}\bigl((c_1u)(s_1c_2)\bigr) + (s_1c_2)(s_1c_2) + 1 - uu\Bigr)
&&(\because\ \blkref{square_of_complex_number_is_product}\ \text{の}\ z^2 = zz\ \text{を 6 箇所へ})\\
&\quad= (c_1c_1)(c_2^*c_2^*) - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + (s_1s_1)(s_2^*s_2^*)(uu) \\
&\qquad\quad - (s_2^*s_2^*)\bigl((c_1c_1)(uu) - 2_{\mathbb{C}}c_1s_1c_2u + (s_1s_1)(c_2c_2) + 1 - uu\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad - (s_2^*)^2\bigl(c_1^2u^2 - 2_{\mathbb{C}}c_1s_1c_2u + s_1^2c_2^2 + 1 - u^2\bigr)
&&(\because\ \blkref{square_of_complex_number_is_product}\ \text{の}\ z^2 = zz\ \text{を 11 箇所へ右辺から左辺へ})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad + \Bigl(-\bigl((s_2^*)^2(c_1^2u^2 - 2_{\mathbb{C}}c_1s_1c_2u + s_1^2c_2^2 + 1 - u^2)\bigr)\Bigr)
&&(\because\ \blkref{def_complex_difference})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad + \Bigl(-\Bigl((s_2^*)^2\bigl(c_1^2u^2 + (-(2_{\mathbb{C}}c_1s_1c_2u)) + s_1^2c_2^2 + 1 + (-u^2)\bigr)\Bigr)\Bigr)
&&(\because\ \blkref{def_complex_difference}\ \text{を 2 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad + (-1_{\mathbb{C}})\Bigl((s_2^*)^2\bigl(c_1^2u^2 + (-1_{\mathbb{C}})(2_{\mathbb{C}}c_1s_1c_2u) + s_1^2c_2^2 + 1 + (-1_{\mathbb{C}})u^2\bigr)\Bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 3 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad + \Bigl((-1_{\mathbb{C}})\bigl((s_2^*)^2(c_1^2u^2)\bigr) + (-1_{\mathbb{C}})\Bigl((s_2^*)^2\bigl((-1_{\mathbb{C}})(2_{\mathbb{C}}c_1s_1c_2u)\bigr)\Bigr) \\
&\qquad\qquad + (-1_{\mathbb{C}})\bigl((s_2^*)^2(s_1^2c_2^2)\bigr) + (-1_{\mathbb{C}})\bigl((s_2^*)^2\cdot 1\bigr) + (-1_{\mathbb{C}})\Bigl((s_2^*)^2\bigl((-1_{\mathbb{C}})u^2\bigr)\Bigr)\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl((s_2^*)^2(c_1^2u^2)\bigr) + (-1_{\mathbb{C}})\Bigl((s_2^*)^2\bigl((-1_{\mathbb{C}})(2_{\mathbb{C}}c_1s_1c_2u)\bigr)\Bigr) \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl((s_2^*)^2(s_1^2c_2^2)\bigr) + (-1_{\mathbb{C}})\bigl((s_2^*)^2\cdot 1\bigr) + (-1_{\mathbb{C}})\Bigl((s_2^*)^2\bigl((-1_{\mathbb{C}})u^2\bigr)\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)\bigl(2_{\mathbb{C}}c_1s_1c_2(s_2^*)^2u\bigr) \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2c_2^2(s_2^*)^2\bigr) + (-1_{\mathbb{C}})\bigl((s_2^*)^2\cdot 1\bigr) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)\bigl(2_{\mathbb{C}}c_1s_1c_2(s_2^*)^2u\bigr) \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2c_2^2(s_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + \bigl((-1)(-1)\bigr)_{\mathbb{C}}\bigl(2_{\mathbb{C}}c_1s_1c_2(s_2^*)^2u\bigr) \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2c_2^2(s_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + \bigl((-1)(-1)\bigr)_{\mathbb{C}}\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{real_inclusion_preserves_product}\ \text{を 2 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + 1_{\mathbb{C}}\bigl(2_{\mathbb{C}}c_1s_1c_2(s_2^*)^2u\bigr) \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2c_2^2(s_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + 1_{\mathbb{C}}\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \mathbb{R}\ \text{の四則を 2 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + 2_{\mathbb{C}}c_1s_1c_2(s_2^*)^2u \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2c_2^2(s_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元を 2 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 + \bigl(-(c_1^2(s_2^*)^2u^2)\bigr) + 2_{\mathbb{C}}c_1s_1c_2(s_2^*)^2u + \bigl(-(s_1^2c_2^2(s_2^*)^2)\bigr) + \bigl(-(s_2^*)^2\bigr) + (s_2^*)^2u^2
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 3 箇所へ右辺から左辺へ})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 - c_1^2(s_2^*)^2u^2 + 2_{\mathbb{C}}c_1s_1c_2(s_2^*)^2u - s_1^2c_2^2(s_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{def_complex_difference}\ \text{を 3 箇所へ右辺から左辺へ})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad - c_1^2(s_2^*)^2u^2 + 2_{\mathbb{C}}c_1s_1c_2(s_2^*s_2^*)u - s_1^2(c_2c_2)(s_2^*s_2^*) - (s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{square_of_complex_number_is_product}\ \text{の}\ z^2 = zz\ \text{を 3 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad - c_1^2(s_2^*)^2u^2 + 2_{\mathbb{C}}c_1s_1(c_2s_2^*)s_2^*u - s_1^2\bigl((c_2s_2^*)(c_2s_2^*)\bigr) - (s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad - c_1^2(s_2^*)^2u^2 + 2_{\mathbb{C}}c_1s_1(c_2s_2^*)s_2^*u - s_1^2(c_2s_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{square_of_complex_number_is_product}\ \text{の}\ z^2 = zz\ \text{を右辺から左辺へ})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad - c_1^2(s_2^*)^2u^2 + 2_{\mathbb{C}}c_1s_1c_2^*s_2^*u - s_1^2(c_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \text{上の}\ c_2s_2^* = c_2^*\ \text{を 2 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 - 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u + s_1^2(s_2^*)^2u^2 \\
&\qquad\quad - c_1^2(s_2^*)^2u^2 + 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u - s_1^2(c_2^*)^2 - (s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&\quad= c_1^2(c_2^*)^2 + \bigl(-(2_{\mathbb{C}}c_1c_2^*s_1s_2^*u)\bigr) + s_1^2(s_2^*)^2u^2 + \bigl(-(c_1^2(s_2^*)^2u^2)\bigr) + 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u \\
&\qquad\quad + \bigl(-(s_1^2(c_2^*)^2)\bigr) + \bigl(-(s_2^*)^2\bigr) + (s_2^*)^2u^2
&&(\because\ \blkref{def_complex_difference}\ \text{を 4 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 + (-1_{\mathbb{C}})(2_{\mathbb{C}}c_1c_2^*s_1s_2^*u) + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2(c_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 4 箇所へ})\\
&\quad= c_1^2(c_2^*)^2 + \bigl((-1_{\mathbb{C}})(2_{\mathbb{C}}c_1c_2^*s_1s_2^*u) + 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u\bigr) + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2(c_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律・可換律})\\
&\quad= c_1^2(c_2^*)^2 + \bigl(-(2_{\mathbb{C}}c_1c_2^*s_1s_2^*u) + 2_{\mathbb{C}}c_1c_2^*s_1s_2^*u\bigr) + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) \\
&\qquad\quad + (-1_{\mathbb{C}})\bigl(s_1^2(c_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を右辺から左辺へ})\\
&\quad= c_1^2(c_2^*)^2 + 0_{\mathbb{C}} + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr)
 + (-1_{\mathbb{C}})\bigl(s_1^2(c_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法逆元})\\
&\quad= c_1^2(c_2^*)^2 + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr)
 + (-1_{\mathbb{C}})\bigl(s_1^2(c_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2 + (s_2^*)^2u^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零元})\\
&\quad= c_1^2(c_2^*)^2 + (-1_{\mathbb{C}})\bigl(s_1^2(c_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2
 + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + (s_2^*)^2u^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律・可換律})\\
&\quad= c_1^2(c_2^*)^2 + (-1_{\mathbb{C}})\bigl(s_1^2(c_2^*)^2\bigr) + (-1_{\mathbb{C}})(s_2^*)^2
 + s_1^2(s_2^*)^2u^2 + (-1_{\mathbb{C}})\bigl(c_1^2(s_2^*)^2u^2\bigr) + 1_{\mathbb{C}}\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元を右辺から左辺へ})\\
&\quad= c_1^2(c_2^*)^2 + \bigl((-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + s_1^2\bigl((s_2^*)^2u^2\bigr) + \bigl((-1_{\mathbb{C}})c_1^2\bigr)\bigl((s_2^*)^2u^2\bigr) + 1_{\mathbb{C}}\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律を 3 箇所へ}\ (c_1^2(s_2^*)^2u^2\ \text{の項には 2 回}))\\
&\quad= c_1^2(c_2^*)^2 + \bigl((-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \Bigl(s_1^2\bigl((s_2^*)^2u^2\bigr) + \bigl((-1_{\mathbb{C}})c_1^2\bigr)\bigl((s_2^*)^2u^2\bigr) + 1_{\mathbb{C}}\bigl((s_2^*)^2u^2\bigr)\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律})\\
&\quad= \bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \bigl(s_1^2 + (-1_{\mathbb{C}})c_1^2 + 1_{\mathbb{C}}\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を右辺から左辺へ}\ ((c_2^*)^2\ \text{の 2 項に 1 回}、(s_2^*)^2u^2\ \text{の 3 項に 2 回}))\\
&\quad= \bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \bigl((-1_{\mathbb{C}})c_1^2 + s_1^2 + 1_{\mathbb{C}}\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の可換律})\\
&\quad= \bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \bigl((-1_{\mathbb{C}})c_1^2 + 1_{\mathbb{C}}s_1^2 + 1_{\mathbb{C}}\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元を右辺から左辺へ})\\
&\quad= \bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \bigl((-1_{\mathbb{C}})c_1^2 + \bigl((-1)(-1)\bigr)_{\mathbb{C}}s_1^2 + 1_{\mathbb{C}}\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \mathbb{R}\ \text{の四則}\ 1 = (-1)(-1))\\
&\quad= \bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \bigl((-1_{\mathbb{C}})c_1^2 + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)s_1^2 + 1_{\mathbb{C}}\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{real_inclusion_preserves_product}\ \text{を右辺から左辺へ})\\
&\quad= \bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \Bigl((-1_{\mathbb{C}})c_1^2 + (-1_{\mathbb{C}})\bigl((-1_{\mathbb{C}})s_1^2\bigr) + 1_{\mathbb{C}}\Bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&\quad= \bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \Bigl((-1_{\mathbb{C}})\bigl(c_1^2 + (-1_{\mathbb{C}})s_1^2\bigr) + 1_{\mathbb{C}}\Bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を右辺から左辺へ})\\
&\quad= \bigl(c_1^2 + (-s_1^2)\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \Bigl((-1_{\mathbb{C}})\bigl(c_1^2 + (-s_1^2)\bigr) + 1_{\mathbb{C}}\Bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 2 箇所へ右辺から左辺へ})\\
&\quad= \bigl(c_1^2 - s_1^2\bigr)(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
 + \Bigl((-1_{\mathbb{C}})\bigl(c_1^2 - s_1^2\bigr) + 1_{\mathbb{C}}\Bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{def_complex_difference}\ \text{を 2 箇所へ右辺から左辺へ})\\
&\quad= 1_{\mathbb{C}}(c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2 + \bigl((-1_{\mathbb{C}})1_{\mathbb{C}} + 1_{\mathbb{C}}\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \text{上の}\ c_1^2 - s_1^2 = 1\ \text{を 2 箇所へ})\\
&\quad= (c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2 + \bigl((-1_{\mathbb{C}}) + 1_{\mathbb{C}}\bigr)\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元を 2 箇所へ})\\
&\quad= (c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2 + \bigl((-1) + 1\bigr)_{\mathbb{C}}\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \blkref{real_inclusion_preserves_sum}\ (a \to -1,\ b \to 1))\\
&\quad= (c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2 + 0_{\mathbb{C}}\bigl((s_2^*)^2u^2\bigr)
&&(\because\ \mathbb{R}\ \text{の四則}\ (-1) + 1 = 0)\\
&\quad= (c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2 + 0_{\mathbb{C}}
&&(\because\ \blkref{complex_zero_times_is_zero})\\
&\quad= (c_2^*)^2 + (-1_{\mathbb{C}})(s_2^*)^2
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零元})\\
&\quad= (c_2^*)^2 + \bigl(-(s_2^*)^2\bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を右辺から左辺へ})\\
&\quad= (c_2^*)^2 - (s_2^*)^2
&&(\because\ \blkref{def_complex_difference}\ \text{を右辺から左辺へ})\\
&\quad= 1
&&(\because\ \text{上の}\ (c_2^*)^2 - (s_2^*)^2 = 1)
\end{aligned}`),
      paragraph(["第 1 の等式は、主張の左辺から次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\det A(\theta)
&= \det\begin{pmatrix}
   \gamma_1(\theta) & \gamma_2(\theta) \\
   -\gamma_2(-\theta) & \gamma_1(\theta)
   \end{pmatrix}
&&(\because\ \blkref{def_gamma1_gamma2_of_theta})\\
&= \gamma_1(\theta)\gamma_1(\theta) - \gamma_2(\theta)\bigl(-\gamma_2(-\theta)\bigr)
&&(\because\ \blkref{def_det_two_by_two})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \Bigl(-\bigl(\gamma_2(\theta)(-\gamma_2(-\theta))\bigr)\Bigr)
&&(\because\ \blkref{def_complex_difference})\\
&= \gamma_1(\theta)\gamma_1(\theta) + (-1_{\mathbb{C}})\Bigl(\gamma_2(\theta)\bigl((-1_{\mathbb{C}})\gamma_2(-\theta)\bigr)\Bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 2 箇所へ})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \bigl((-1_{\mathbb{C}})(-1_{\mathbb{C}})\bigr)\bigl(\gamma_2(\theta)\gamma_2(-\theta)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= \gamma_1(\theta)\gamma_1(\theta) + 1_{\mathbb{C}}\bigl(\gamma_2(\theta)\gamma_2(-\theta)\bigr)
&&(\because\ \blkref{minus_one_times_minus_one_is_one_in_cc})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \gamma_2(\theta)\gamma_2(-\theta)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&= \gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta)
&&(\because\ \blkref{square_of_complex_number_is_product}\ \text{の}\ z^2 = zz\ \text{を右辺から左辺へ})\\
&= 1
&&(\because\ \text{上の第 2 の等式の鎖})
\end{aligned}`),
      paragraph([
        "第 3 の等式。",
        ref("eigenvector_of_A_theta_tilde"),
        " より ",
        math(String.raw`\lambda_{\pm,\mu} = \gamma_1(\theta) \pm r \in \mathbb{R}`),
        "、",
        ref("relation_of_gamma_2_theta_tilde"),
        " (2) より ",
        math(String.raw`\gamma_2(\theta)\gamma_2(-\theta) = (-r^2)_{\mathbb{C}}`),
        " である。まず ",
        math(String.raw`\mathbb{C}`),
        " の中で",
      ]),
      displayMath(String.raw`\begin{aligned}
(\lambda_{+,\mu}\lambda_{-,\mu})_{\mathbb{C}}
&= (\lambda_{+,\mu})_{\mathbb{C}}\,(\lambda_{-,\mu})_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product}\ \text{を右辺から左辺へ})\\
&= \bigl(\gamma_1(\theta) + r\bigr)_{\mathbb{C}}\,\bigl(\gamma_1(\theta) - r\bigr)_{\mathbb{C}}
&&(\because\ \blkref{eigenvector_of_A_theta_tilde})\\
&= \bigl(\gamma_1(\theta)_{\mathbb{C}} + r_{\mathbb{C}}\bigr)\bigl(\gamma_1(\theta) - r\bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_inclusion_preserves_sum}\ (a \to \gamma_1(\theta),\ b \to r)\ \text{を右辺から左辺へ}\bigr)\\
&= \bigl(\gamma_1(\theta) + r\bigr)\bigl(\gamma_1(\theta) - r\bigr)
&&\bigl(\because\ \blkref{real_inclusion_preserves_difference}\ (y \to \gamma_1(\theta),\ z \to r)\ \text{を右辺から左辺へ。この行から}\ \gamma_1(\theta)\ \text{の像の記号を省き、}\ r\ \text{の像の記号は書き戻す行の直前まで省く}\bigr)\\
&= \bigl(\gamma_1(\theta) + r\bigr)\bigl(\gamma_1(\theta) + (-r)\bigr)
&&(\because\ \blkref{def_complex_difference})\\
&= \bigl(\gamma_1(\theta) + r\bigr)\gamma_1(\theta) + \bigl(\gamma_1(\theta) + r\bigr)(-r)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律（外側の積へ）})\\
&= \bigl(\gamma_1(\theta)\gamma_1(\theta) + r\gamma_1(\theta)\bigr) + \bigl(\gamma_1(\theta)(-r) + r(-r)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を 2 箇所へ（内側の積へ）})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \Bigl(r\gamma_1(\theta) + \bigl(\gamma_1(\theta)(-r) + r(-r)\bigr)\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \Bigl(\bigl(r\gamma_1(\theta) + \gamma_1(\theta)(-r)\bigr) + r(-r)\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律を右辺から左辺へ})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \Bigl(\bigl(r\gamma_1(\theta) + \gamma_1(\theta)\bigl((-1_{\mathbb{C}})r\bigr)\bigr) + r\bigl((-1_{\mathbb{C}})r\bigr)\Bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 2 箇所へ})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \Bigl(\bigl(r\gamma_1(\theta) + (-1_{\mathbb{C}})\bigl(r\gamma_1(\theta)\bigr)\bigr) + (-1_{\mathbb{C}})(rr)\Bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律・可換律})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \Bigl(\Bigl(r\gamma_1(\theta) + \bigl(-\bigl(r\gamma_1(\theta)\bigr)\bigr)\Bigr) + \bigl(-(rr)\bigr)\Bigr)
&&(\because\ \blkref{multiply_by_minus_one}\ \text{を 2 箇所へ右辺から左辺へ})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \bigl(0_{\mathbb{C}} + (-(rr))\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法逆元})\\
&= \bigl(\gamma_1(\theta)\gamma_1(\theta) + 0_{\mathbb{C}}\bigr) + \bigl(-(rr)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律を右辺から左辺へ})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \bigl(-(rr)\bigr)
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零元})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \Bigl(-\bigl((rr)_{\mathbb{C}}\bigr)\Bigr)
&&(\because\ \blkref{real_inclusion_preserves_product}\ \text{。この行から}\ r\ \text{の像の記号を書き戻す})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \Bigl(-\bigl((r^2)_{\mathbb{C}}\bigr)\Bigr)
&&(\because\ \blkref{square_of_real_number_is_product}\ \text{を右辺から左辺へ})\\
&= \gamma_1(\theta)\gamma_1(\theta) + (-1_{\mathbb{C}})(r^2)_{\mathbb{C}}
&&(\because\ \blkref{multiply_by_minus_one})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \bigl((-1)r^2\bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product}\ \text{（}-1_{\mathbb{C}}\ \text{は略記}\ (-1)_{\mathbb{C}}\text{）})\\
&= \gamma_1(\theta)\gamma_1(\theta) + \bigl(-r^2\bigr)_{\mathbb{C}}
&&(\because\ \mathbb{R}\ \text{の四則}\ (-1)x = -x)\\
&= \gamma_1(\theta)^2 + \bigl(-r^2\bigr)_{\mathbb{C}}
&&(\because\ \blkref{square_of_complex_number_is_product}\ \text{の}\ z^2 = zz\ \text{を右辺から左辺へ})\\
&= \gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta)
&&(\because\ \blkref{relation_of_gamma_2_theta_tilde}\ (2)\ \text{を右辺から左辺へ})\\
&= 1_{\mathbb{C}}
&&(\because\ \text{上の第 2 の等式の鎖})
\end{aligned}`),
      paragraph(["であり、これを実数の対として読むと"]),
      displayMath(String.raw`\begin{aligned}
(\lambda_{+,\mu}\lambda_{-,\mu},\ 0)
&= (\lambda_{+,\mu}\lambda_{-,\mu})_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc})\\
&= 1_{\mathbb{C}}
&&(\because\ \text{直前の鎖})\\
&= (1,\ 0)
&&(\because\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
      paragraph([
        "となる。",
        ref("definition_of_cc"),
        " の台集合 ",
        math(String.raw`\mathbb{R}^2`),
        " の元は成分がすべて等しいときに限り等しいので、第 1 成分を比べて ",
        math(String.raw`\lambda_{+,\mu}\lambda_{-,\mu} = 1`),
        "（",
        math(String.raw`\mathbb{R}`),
        " の等式）を得る。",
      ]),
      paragraph(["最後の等式。まず ", math(String.raw`\mathbb{C}`), " の中で"]),
      displayMath(String.raw`\begin{aligned}
\bigl(\gamma_1(\theta)^2\bigr)_{\mathbb{C}}
&= \bigl(\gamma_1(\theta)\gamma_1(\theta)\bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to \gamma_1(\theta))\bigr)\\
&= \gamma_1(\theta)_{\mathbb{C}}\,\gamma_1(\theta)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product}\ \text{を右辺から左辺へ})\\
&= \bigl(\gamma_1(\theta)_{\mathbb{C}}\bigr)^2
&&(\because\ \blkref{square_of_complex_number_is_product}\ \text{の}\ z^2 = zz\ \text{を右辺から左辺へ})\\
&= \gamma_1(\theta)^2 + 0_{\mathbb{C}}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零元を右辺から左辺へ。以下この鎖では}\ \gamma_1(\theta)\ \text{の像の記号を省き、}\gamma_1(\theta)^2\ \text{は}\ \bigl(\gamma_1(\theta)_{\mathbb{C}}\bigr)^2\ \text{の略記とする})\\
&= \gamma_1(\theta)^2 + (0)_{\mathbb{C}}
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\ 0_{\mathbb{C}} = (0)_{\mathbb{C}}\bigr)\\
&= \gamma_1(\theta)^2 + \bigl(-r^2 + r^2\bigr)_{\mathbb{C}}
&&\bigl(\because\ \mathbb{R}\ \text{の加法逆元}\ -a + a = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）の}\ a \to r^2\ \text{を右辺から左辺へ}\bigr)\\
&= \gamma_1(\theta)^2 + \bigl((-r^2)_{\mathbb{C}} + (r^2)_{\mathbb{C}}\bigr)
&&\bigl(\because\ \blkref{real_inclusion_preserves_sum}\ (a \to -r^2,\ b \to r^2)\ \text{を右辺から左辺へ}\bigr)\\
&= \gamma_1(\theta)^2 + \bigl(\gamma_2(\theta)\gamma_2(-\theta) + (r^2)_{\mathbb{C}}\bigr)
&&(\because\ \blkref{relation_of_gamma_2_theta_tilde}\ (2)\ \text{を右辺から左辺へ})\\
&= \bigl(\gamma_1(\theta)^2 + \gamma_2(\theta)\gamma_2(-\theta)\bigr) + (r^2)_{\mathbb{C}}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律を右辺から左辺へ})\\
&= 1_{\mathbb{C}} + (r^2)_{\mathbb{C}}
&&(\because\ \text{上の第 2 の等式の鎖})\\
&= \bigl(1 + r^2\bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_inclusion_preserves_sum}\ (a \to 1,\ b \to r^2)\text{。}1_{\mathbb{C}}\ \text{は}\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\ (1)_{\mathbb{C}}\bigr)
\end{aligned}`),
      paragraph([
        "であり、第 3 の等式と同じく ",
        ref("inclusion_rr_to_cc"),
        " の対の第 1 成分を比べて ",
        math(String.raw`\gamma_1(\theta)^2 = 1 + r^2 = 1 + \left|\gamma_2(\theta)\right|^2`),
        "（",
        math(String.raw`\mathbb{R}`),
        " の等式）を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "det_A_theta（008 章）の Step 0〜Step 6 と同じ計算である。θ_μ 固有の性質は使われておらず、" +
          "θ ∈ R の恒等式として成立することを本文で明示した。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_04（残差 ≤ 1.4e-12）。式変形の各行の厳密な検算は sagemath/check/det_A_theta_tilde/。",
        "2026-08-19 の式変形統一で、Step 3 の展開 2 式と Step 4 の鎖の先頭行に行末根拠を補い、" +
          "散文で畳まれていた γ_1(θ)^2 = 1 + r^2 の導出を主張の左辺から始まる三段の鎖へ開いた。内容・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-03: SageMath の検算（sagemath/check/det_A_theta_tilde/）を付けるときに証明を直した。Step 0〜Step 6 の散文のつなぎを、準備（像の読み方）と、−(−z) = z・ii = −1_C・e_+e_− = 1_C・u^2 + v^2 = 1_C・γ_2(θ)・γ_2(−θ)・(a_0 − iv)(a_0 + iv)・γ_2(θ)γ_2(−θ)・三つの双曲線の関係の鎖と、主張の左辺から始まる四本の鎖に組み直した。" +
          "e_+e_− = 1 の根拠を行列の theorem_exp_product（n=1）・theorem_exp_zero から scalar_exp_product・scalar_exp_zero に、u^2 + v^2 = 1 を根拠の無い前提から euler_formula_cos_sin による u + iv = e_+ と exp_of_negative_i_real_as_cos_minus_i_sin の鎖に（商は乗法の逆元との積として準備に置いた）、γ_2(−θ) の表示を根拠の無い代入から def_gamma1_gamma2_of_theta と def_A_theta の (2,1) 成分の比較に直し、一行に束ねていた並べ替え・相殺・くくり出しを一操作ずつに分けた。" +
          "第 3・第 4 の等式は ℂ の中で示してから inclusion_rr_to_cc の対の第 1 成分で ℝ の等式に戻した。主張に、どの等式が ℂ と ℝ のどちらのものかを書いた（中身は不変）。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 主張の最後の等式の |γ_2(θ̃_μ)| を def_abs_arg の絶対値、二乗 γ_1(θ̃_μ)^2・|γ_2(θ̃_μ)|^2 を def_power_of_real_number の冪（m = 2）と書いた。最後の等式の鎖の第 2 行と第 13 行（左辺だけの行を第 1 行と数える）の名前だけの根拠「ℝ の冪 x^2 = xx」「ℝ の冪 xx = x^2」を square_of_real_number_is_product（r → γ_1(θ)、r → |γ_2(θ)| を右辺から左辺へ）の参照にした（中身は不変）。",
        "2026-11-09（Lean の通しの証明のゴールラインの確認）: 準備の e_− := exp(−iθ) の −iθ が euler_formula_cos_sin・exp_of_negative_i_real_as_cos_minus_i_sin・def_A_theta と同じく multiply_by_minus_one の −(iθ) であることを書いた（e_+e_− の鎖の加法逆元の行・u^2 + v^2 の鎖・γ_2(−θ) の鎖がこの読みに乗っている。中身は不変）。",
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 準備の像の読み方の和・差を、名前だけの言い換え（和は real_inclusion_preserves_finite_sum を m = 2 で、差は def_complex_difference・multiply_by_minus_one）から主張 real_inclusion_preserves_sum・real_inclusion_preserves_difference の参照にした。第 3 の等式の鎖の 4 行目「準備の像の読み方（和・差の像は像の和・差）」は 2 つの主張を 1 行で当てていたので、和の行と差の行の 2 行に割った（22 行から 23 行）。主張・値は不変。",
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 第一の準備の (x − iy)(x + iy) の鎖と (x − y)^2 の鎖で、根拠を「分配律」だけにしていた行が左から括った 4 項の和にするのに和の結合律も当てていたので、分配律の行と和の結合律を右辺から左辺へ当てる行に割った。(x − y)^2 の鎖の「分配律を右辺から左辺へ」の行も xx + A + A を xx + (A + A) に括り直していたので、和の結合律の行を前に置いた（13 等号から 14 等号、15 等号から 17 等号）。主張・値は不変。",
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 冪の行の根拠「def_power_of_complex_number より z^2 = (1_ℂz)z = zz」「同 z^2 = zz」「同 zz = z^2」は、冪の定義の 3 つの式と積の単位元を 1 行で当てていたので、新しく足した主張 square_of_complex_number_is_product（z^2 = zz）の参照にした（zz = z^2 は「右辺から左辺へ」と書いた。12 行。第 2 の等式の鎖の 10・12 行目に箇所数（6 箇所・11 箇所）を書いた。主張・値は不変）。",
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 最後の等式の鎖は relation_of_gamma_2_theta_tilde (2) を ℂ の −(r_ℂ)^2 の形で当てていたが、(2) の右辺は実数 −r^2 の像 (−r^2)_ℂ である。零元の後を、0_ℂ = (0)_ℂ、ℝ の加法逆元 −r^2 + r^2 = 0 を右辺から左辺へ、real_inclusion_preserves_sum を右辺から左辺へ、(2) を右辺から左辺へ、の順にして (2) をその形のまま当て、末尾を 1_ℂ + (r^2)_ℂ = (1 + r^2)_ℂ（real_inclusion_preserves_sum）にした（13 行 → 12 行）。第 3 行の real_inclusion_preserves_product、零元の行、和の結合律の行に「右辺から左辺へ」を書いた。",
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: (x − iy)(x + iy) の鎖・(x − y)^2 の鎖・第 3 の等式の ℂ の中の鎖で、分配律を外側の積に当ててから内側の 2 つの積へ当てるのを 1 行に書いていた。内側の積は外側に当てた後に現れるので同じ定理の同時の適用ではない。外側の積へ当てる行と、内側の 2 箇所へ同時に当てる行の 2 行に割った（左辺の行を含めて (x − iy)(x + iy) の鎖は 15 行から 16 行、(x − y)^2 の鎖は 18 行から 19 行、第 3 の等式の鎖は 23 行から 24 行。中身は不変）。",
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 虚数単位 i = (0,1) の根拠を、後ろの章の antiperiodic_exp_sum の前置きから、計算公式の章に足した定義 def_imaginary_unit への参照に替えた。計算と主張は不変。",
      ],
    },
  },
  {
    id: "Athetatilde_007_claim_gamma1_gt_1",
    kind: "claim",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 9 },
    title: { tex: String.raw`\gamma_1(\tilde\theta_\mu) > 1` },
    labels: ["gamma1_gt_1_theta_tilde"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもと ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " とする。",
        ref("def_gamma1_gamma2_of_theta"),
        " の ",
        math(String.raw`\gamma_1(\tilde\theta_\mu) \in \mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`\gamma_1(\tilde\theta_\mu) \geq 1, \qquad \text{さらに} \qquad \gamma_1(\tilde\theta_\mu) > 1`),
      paragraph([
        "が成り立つ。証明は ",
        ref("gamma1_lower_bound_all_theta"),
        " を通じて、全実数上の ",
        math(String.raw`\cos`),
        " の性質 ",
        math(String.raw`\cos\theta \leq 1\ (\theta \in \mathbb{R})`),
        " を前提とする。狭義の不等号は ",
        ref("gamma_2_theta_tilde_nonzero"),
        " による。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`\theta := \tilde\theta_\mu \in \mathbb{R}`),
        "（",
        ref("antiperiodic_exp_sum"),
        "）、",
        math(String.raw`g := \gamma_1(\theta) \in \mathbb{R}`),
        "（",
        ref("def_gamma1_gamma2_of_theta"),
        "）、",
        math(String.raw`r := \left|\gamma_2(\theta)\right| \in \mathbb{R}_{\geq 0}`),
        "（",
        ref("def_abs_arg"),
        "）と置く。二乗 ",
        math(String.raw`g^2`),
        "・",
        math(String.raw`r^2`),
        " は ",
        ref("def_power_of_real_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "）である。現れる量はすべて ",
        math(String.raw`\mathbb{R}`),
        " の元で、不等号は ",
        math(String.raw`\mathbb{R}`),
        " の順序である（",
        math(String.raw`\tilde\theta_\mu`),
        " は ",
        math(String.raw`\pi`),
        " を含み、",
        math(String.raw`g`),
        " は実数の exp と全実数上の ",
        math(String.raw`\cos`),
        " の値から、",
        math(String.raw`r`),
        " は非負の平方根から作るので、いずれも ",
        math(String.raw`\mathbb{R}`),
        " の完備性に依る）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&g \geq \cosh\left(2K_1 - 2K_2^*\right)\ \text{かつ}\ \cosh\left(2K_1 - 2K_2^*\right) \geq 1
&&(\because\ \blkref{gamma1_lower_bound_all_theta}\ \text{を}\ \theta\ \text{に適用})\\
&\Longrightarrow\ g \geq 1
&&(\because\ \mathbb{R}\ \text{の順序の推移律})\\
&\Longrightarrow\ g > 0
&&(\because\ g \geq 1\ \text{と}\ 1 > 0\ \text{に}\ \mathbb{R}\ \text{の順序の推移律})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
&\gamma_2(\theta) \neq 0_{\mathbb{C}}
&&(\because\ \blkref{gamma_2_theta_tilde_nonzero})\\
&\Longrightarrow\ r \neq 0
&&(\because\ \blkref{abs_basic_properties}\ (3)\ \text{の対偶})\\
&\Longrightarrow\ r > 0
&&(\because\ \blkref{def_abs_arg}\ \text{の}\ r \geq 0\ \text{かつ}\ r \neq 0)\\
&\Longrightarrow\ r \cdot r > 0 \cdot r
&&(\because\ r > 0\ \text{の両辺に}\ 0 < r\ \text{を掛ける})\\
&\Longrightarrow\ r \cdot r > 0
&&(\because\ 0 \cdot r = 0)\\
&\Longrightarrow\ r^2 > 0
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to \left|\gamma_2(\theta)\right|)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "第 1 の不等式 ",
        math(String.raw`\gamma_1(\tilde\theta_\mu) \geq 1`),
        " は準備の ",
        math(String.raw`g \geq 1`),
        " である。第 2 の不等式のために ",
        math(String.raw`g^2`),
        " を評価する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
g^2
&= 1 + r^2
&&(\because\ \blkref{det_A_theta_tilde}\ (\gamma_1(\tilde\theta_\mu)^2 = 1 + |\gamma_2(\tilde\theta_\mu)|^2))\\
&> 1 + 0
&&(\because\ \text{準備の}\ r^2 > 0\ \text{の両辺に}\ 1\ \text{を加える})\\
&= 1
&&(\because\ 0\ \text{は加法の単位元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`g \leq 1`),
        " と仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
g^2
&= g \cdot g
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to g)\bigr)\\
&\leq 1 \cdot g
&&(\because\ g \leq 1\ \text{の両辺に準備の}\ 0 < g\ \text{を掛ける})\\
&\leq 1 \cdot 1
&&(\because\ g \leq 1\ \text{の両辺に}\ 0 < 1\ \text{を掛ける})\\
&= 1
&&(\because\ 1\ \text{は乗法の単位元})
\end{aligned}`,
      ),
      paragraph([
        "となり、上の ",
        math(String.raw`g^2 > 1`),
        " と合わせて ",
        math(String.raw`1 < g^2 \leq 1`),
        "、すなわち ",
        math(String.raw`1 < 1`),
        " となって ",
        math(String.raw`\mathbb{R}`),
        " の順序に矛盾する。したがって ",
        math(String.raw`g \leq 1`),
        " ではなく、",
        math(String.raw`\mathbb{R}`),
        " の順序は全順序なので ",
        math(String.raw`g > 1`),
        "、すなわち ",
        math(String.raw`\gamma_1(\tilde\theta_\mu) > 1`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_04（16 組の (K_1,K_2)、M = 2..8 の全 μ で " +
          "min(γ_1(θ~_μ) − 1) ≥ 1.3e-2 > 0。臨界点ちょうどでも狭義に正）。同じ K で整数運動量 θ = 2π では " +
          "臨界点で γ_1 = 1 になる（check_05 の対比表）。",
        "2026-08-19 の式変形統一で、Step 1 の正値性を一操作ずつの鎖へ分け、Step 2 の平方評価と Step 3 の背理法を主張の左辺から始まる鎖へ開いた。内容・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。" +
          "Step 1 で出典なしに使っていた K_2^* > 0 に def_second_dual_coupling_constant の参照を付けた。",
        "2026-11-03: SageMath の検算（sagemath/check/gamma1_gt_1_theta_tilde/）を付けるときに証明を直した。Step 1 の γ_1 > 0 は、根拠の無い cos θ~_μ ≤ 1 と c_1 > s_1 > 0 を使っていたのを、gamma1_lower_bound_all_theta の γ_1(θ) ≥ cosh(2K_1 − 2K_2^*) ≥ 1 から g ≥ 1 と g > 0 を出す準備に替えた（第 1 の不等式 γ_1 ≥ 1 は狭義の不等式から従うと書いていたのを、この準備で直接示した）。" +
          "Step 2 の根拠「det A = 1 と固有値の積」を det_A_theta_tilde の γ_1^2 = 1 + |γ_2|^2 に、「γ_2 ≠ 0 より |γ_2|^2 > 0」を gamma_2_theta_tilde_nonzero・abs_basic_properties (3) からの含意の鎖にした。cos θ ≤ 1（全実数）を前提とすることを主張に書き、主張の中の「後段で最大固有値の一意性に使う」の一文は使い道の説明なので除いた（中身は不変）。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 準備に二乗 g^2・r^2 が def_power_of_real_number の冪（m = 2）であることを書き、準備の r·r > 0 ⇒ r^2 > 0 の行と背理の鎖の g^2 = g·g の行の名前だけの根拠「平方の定義」を square_of_real_number_is_product（r → |γ_2(θ)| を右辺から左辺へ、r → g）の参照にした（中身は不変）。",
      ],
    },
  },
  {
    id: "Athetatilde_008_claim_gamma_theta_tilde_positive",
    kind: "claim",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 10 },
    title: { tex: String.raw`\gamma(\tilde\theta_\mu) > 0` },
    labels: ["gamma_theta_tilde_mu_positive"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " とする。",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma`),
        " の ",
        math(String.raw`\theta = \tilde\theta_\mu`),
        " での値 ",
        math(String.raw`\gamma(\tilde\theta_\mu) \in \mathbb{R}_{\geq 0}`),
        " について",
      ]),
      displayMath(String.raw`\gamma(\tilde\theta_\mu) > 0`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`g := \gamma_1(\tilde\theta_\mu) \in \mathbb{R}`),
        "、",
        math(String.raw`t := \gamma(\tilde\theta_\mu) \in \mathbb{R}`),
        " と置く。",
        ref("gamma1_gt_1_theta_tilde"),
        " より ",
        math(String.raw`g > 1`),
        "、とくに ",
        math(String.raw`g \geq 1`),
        " であり、",
        ref("def_gamma_theta"),
        " より ",
        math(String.raw`t = \mathrm{arccosh}(g)`),
        " である。したがって ",
        ref("arccosh_properties"),
        " (1)・(2) を ",
        math(String.raw`y = g`),
        " に適用して ",
        math(String.raw`t \geq 0`),
        "、",
        math(String.raw`\cosh t = g`),
        " である。以下の exp は ",
        ref("def_cosh_sinh"),
        " のとおり実数の exp である。",
      ]),
      paragraph([
        math(String.raw`t = 0`),
        " と仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
g
&= \cosh t
&&(\because\ \text{準備の}\ \cosh t = g\ (\blkref{arccosh_properties}\ (2)))\\
&= \cosh 0
&&(\because\ \text{仮定}\ t = 0)\\
&= \frac{\exp 0 + \exp(-0)}{2}
&&(\because\ \blkref{def_cosh_sinh})\\
&= \frac{\exp 0 + \exp 0}{2}
&&(\because\ -0 = 0)\\
&= \frac{1 + 1}{2}
&&(\because\ \blkref{scalar_exp_zero}\ (K = \mathbb{R}))\\
&= 1
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`,
      ),
      paragraph([
        "となり、準備の ",
        math(String.raw`g > 1`),
        " と合わせて ",
        math(String.raw`1 > 1`),
        " となって ",
        math(String.raw`\mathbb{R}`),
        " の順序に矛盾する。よって ",
        math(String.raw`t \neq 0`),
        " であり、準備の ",
        math(String.raw`t \geq 0`),
        " と合わせて ",
        math(String.raw`t > 0`),
        "、すなわち ",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "def_gamma_theta_mu（008 章）と同じ arccosh の使い方に揃えたうえで、半整数運動量に固有の帰結" +
          "「γ(θ~_μ) > 0（狭義）」を statement に含めた。C′-15（最大固有値の一意性）で使う。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-10-31: γ(θ~_μ) := arccosh(γ_1(θ~_μ)) の定義を def_gamma_theta（θ∈ℝ の γ(θ) の定義）へまとめ、" +
          "このブロックには γ(θ~_μ) > 0 の主張だけを残した（1 ブロック 1 主張）。中身に合わせ、ラベルを def_gamma_theta_tilde_mu から gamma_theta_tilde_mu_positive へ、" +
          "id を Athetatilde_008_definition_gamma_theta_tilde から Athetatilde_008_claim_gamma_theta_tilde_positive へ改めた。" +
          "statement の括弧書きにあった背理法を、式変形の形で証明へ移した。中身は変えていない。",
        "2026-11-03: SageMath の検算（sagemath/check/gamma_theta_tilde_mu_positive/）を付けるときに証明を直した。γ ≥ 0 と cosh γ = γ_1 の根拠を def_gamma_theta だけから、それが引く arccosh_properties (1)・(2) の y = γ_1(θ~_μ) への適用に（γ_1 ≥ 1 は gamma1_gt_1_theta_tilde から）、値 γ(θ~_μ) を関数 γ と別の文字 t で置き、矛盾と結論の散文を 1 > 1 と t ≠ 0 かつ t ≥ 0 の形に書いた（中身は不変）。",
      ],
    },
  },
  {
    id: "Athetatilde_009_claim_lambda_eq_exp_gamma",
    kind: "claim",
    origin: { path: "structured-latex/content/015_A_theta_tilde_diagonalization.ts", ordinal: 11 },
    title: { tex: String.raw`\lambda_{\pm,\mu} = \exp(\pm\gamma(\tilde\theta_\mu))` },
    labels: ["lambda_eq_exp_gamma_theta_tilde"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " について、",
      ]),
      displayMath(
        String.raw`\lambda_{+,\mu} = \exp(+\gamma(\tilde\theta_\mu)), \qquad
\lambda_{-,\mu} = \exp(-\gamma(\tilde\theta_\mu))`,
      ),
      paragraph([
        "が成り立つ。ここで ",
        math(String.raw`\lambda_{\pm,\mu}`),
        " は ",
        ref("eigenvector_of_A_theta_tilde"),
        " の固有値、",
        math(String.raw`\gamma`),
        " は ",
        ref("def_gamma_theta"),
        " の関数で、exp は実数の exp である。とくに ",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        "（",
        ref("gamma_theta_tilde_mu_positive"),
        "）なので",
      ]),
      displayMath(String.raw`\lambda_{+,\mu} > 1 > \lambda_{-,\mu} > 0`),
      paragraph([
        "であり、2 つの固有値は**必ず分離している**。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`g := \gamma_1(\tilde\theta_\mu) \in \mathbb{R}`),
        "（",
        ref("def_gamma1_gamma2_of_theta"),
        "。実数の exp で作る結合定数と ",
        math(String.raw`\cos\tilde\theta_\mu`),
        " の値なので ",
        math(String.raw`\mathbb{R}`),
        " に住む）、",
        math(String.raw`r := \left|\gamma_2(\tilde\theta_\mu)\right| \in \mathbb{R}_{\geq 0}`),
        "（",
        ref("def_abs_arg"),
        "。非負の平方根の値）、",
        math(String.raw`t := \gamma(\tilde\theta_\mu) \in \mathbb{R}`),
        "（",
        ref("def_gamma_theta"),
        "。",
        ref("def_arccosh"),
        " の実対数の値なので ",
        math(String.raw`\mathbb{R}`),
        " に住む）と置く（関数 ",
        math(String.raw`\gamma`),
        " とその値を区別するため、値に別の文字を使う）。以下の exp は ",
        ref("def_cosh_sinh"),
        " のとおり実数の exp である。準備で使う事実は次の五つである。",
      ]),
      list([
        [
          "(a) ",
          ref("gamma1_gt_1_theta_tilde"),
          " より ",
          math(String.raw`g > 1`),
          "、とくに ",
          math(String.raw`g \geq 1`),
          " であり、",
          ref("def_gamma_theta"),
          " より ",
          math(String.raw`t = \mathrm{arccosh}(g)`),
          " である。",
          ref("arccosh_properties"),
          " (2) を ",
          math(String.raw`y = g`),
          " に適用して ",
          math(String.raw`\cosh t = g`),
          "。",
        ],
        [
          "(b) ",
          ref("gamma_theta_tilde_mu_positive"),
          " より ",
          math(String.raw`t > 0`),
          "。",
        ],
        [
          "(c) ",
          math(String.raw`r > 0`),
          "（下の鎖）。",
        ],
        [
          "(d) ",
          ref("det_A_theta_tilde"),
          " より ",
          math(String.raw`g^2 = 1 + r^2`),
          "。",
        ],
        [
          "(e) ",
          ref("eigenvector_of_A_theta_tilde"),
          " より ",
          math(String.raw`\lambda_{+,\mu} = g + r`),
          "、",
          math(String.raw`\lambda_{-,\mu} = g - r`),
          "。",
        ],
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\gamma_2(\tilde\theta_\mu) \neq 0_{\mathbb{C}}
&&(\because\ \blkref{gamma_2_theta_tilde_nonzero})\\
&\Longrightarrow\ r \neq 0
&&(\because\ \blkref{abs_basic_properties}\ (3)\ \text{の対偶})\\
&\Longrightarrow\ r > 0
&&(\because\ \blkref{def_abs_arg}\ \text{の}\ r \geq 0\ \text{かつ}\ r \neq 0)
\end{aligned}`,
      ),
      paragraph([
        "Step 1（",
        math(String.raw`\sinh t = r`),
        "）。まず両辺の平方が等しいことを示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sinh t\right)^2
&= \left(\cosh t\right)^2 - 1
&&(\because\ \blkref{cosh_sinh_basic_properties}\ (2)\ \text{を}\ x = t\ \text{に適用})\\
&= g^2 - 1
&&(\because\ \text{準備 (a) の}\ \cosh t = g)\\
&= \left(1 + r^2\right) - 1
&&(\because\ \text{準備 (d) の}\ g^2 = 1 + r^2)\\
&= r^2
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`,
      ),
      paragraph(["次に両者が正であることを示す。"]),
      displayMath(
        String.raw`\begin{aligned}
&t > 0
&&(\because\ \text{準備 (b)})\\
&\Longrightarrow\ \cosh t > \sinh t\ \text{かつ}\ \sinh t > 0
&&(\because\ \blkref{cosh_sinh_basic_properties}\ (3)\ \text{を}\ x = t\ \text{に適用})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`r > 0`),
        " は準備 (c) である。",
        math(String.raw`a = \sinh t \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`b = r \in \mathbb{R}_{>0}`),
        " は ",
        math(String.raw`a^2 = b^2`),
        " を満たすので、",
        ref("cosh_sinh_basic_properties"),
        " (4) より ",
        math(String.raw`\sinh t = r`),
        " である。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`\lambda_{\pm,\mu} = \exp(\pm t)`),
        "）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\lambda_{+,\mu}
&= g + r
&&(\because\ \text{準備 (e)})\\
&= \cosh t + r
&&(\because\ \text{準備 (a) の}\ \cosh t = g)\\
&= \cosh t + \sinh t
&&(\because\ \text{Step 1 の}\ \sinh t = r)\\
&= \exp(t)
&&(\because\ \blkref{cosh_sinh_basic_properties}\ (1)\ \text{を}\ x = t\ \text{に適用})\\
&= \exp(+t)
&&(\because\ +t = t)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\lambda_{-,\mu}
&= g - r
&&(\because\ \text{準備 (e)})\\
&= \cosh t - r
&&(\because\ \text{準備 (a) の}\ \cosh t = g)\\
&= \cosh t - \sinh t
&&(\because\ \text{Step 1 の}\ \sinh t = r)\\
&= \exp(-t)
&&(\because\ \blkref{cosh_sinh_basic_properties}\ (1)\ \text{を}\ x = t\ \text{に適用})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`t = \gamma(\tilde\theta_\mu)`),
        " なので、これが主張の前半である。",
      ]),
      paragraph([
        "Step 3（分離）。まず ",
        math(String.raw`-t < 0`),
        " を示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&0 < t
&&(\because\ \text{準備 (b)})\\
&\Longrightarrow\ 0 + (-t) < t + (-t)
&&(\because\ \mathbb{R}\ \text{の順序は両辺に同じ数を足しても保たれる})\\
&\Longrightarrow\ -t < 0
&&(\because\ \mathbb{R}\ \text{の四則})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\lambda_{+,\mu}
&= \exp(t)
&&(\because\ \text{Step 2})\\
&> \exp(0)
&&(\because\ \blkref{real_exp_strictly_increasing}\ \text{を}\ 0 < t\ \text{に適用})\\
&= 1
&&(\because\ \blkref{scalar_exp_zero}\ (K = \mathbb{R}))
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
1
&= \exp(0)
&&(\because\ \blkref{scalar_exp_zero}\ (K = \mathbb{R}))\\
&> \exp(-t)
&&(\because\ \blkref{real_exp_strictly_increasing}\ \text{を}\ -t < 0\ \text{に適用})\\
&= \lambda_{-,\mu}
&&(\because\ \text{Step 2})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\lambda_{-,\mu}
&= \exp(-t)
&&(\because\ \text{Step 2})\\
&> 0
&&(\because\ \blkref{real_exp_positive}\ \text{を}\ x = -t\ \text{に適用})
\end{aligned}`,
      ),
      paragraph([
        "三つを合わせて ",
        math(String.raw`\lambda_{+,\mu} > 1 > \lambda_{-,\mu} > 0`),
        " であり、",
        math(String.raw`\mathbb{R}`),
        " の順序の推移律より ",
        math(String.raw`\lambda_{+,\mu} > \lambda_{-,\mu}`),
        "、すなわち 2 つの固有値は分離している。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の lambda_eq_exp_gamma は「λ_+λ_- = 1 かつ λ_+ + λ_- = 2γ_1 ≥ 2 > 0 なので両固有値は正」" +
          "という筋で書かれていたが、ここでは sinh γ = |γ_2| を経由して e^{±γ} = cosh γ ± sinh γ から直接出した" +
          "（半整数運動量では γ > 0 が確定しているので分離まで一気に言える）。",
        "数値検証: sagemath/check/048_claim_A_theta_tilde/check_05（cosh γ = γ_1、sinh γ = |γ_2|、λ_± = e^{±γ}、" +
          "min γ(θ~_μ) ≥ 3.0e-1 > 0、残差 ≤ 1e-12）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-03: SageMath の検算（sagemath/check/lambda_eq_exp_gamma_theta_tilde/）を付けるときに証明を直した。r > 0 の根拠を def_gamma_theta・gamma_theta_tilde_mu_positive（どちらもこれを述べていない）から gamma_2_theta_tilde_nonzero・abs_basic_properties (3)・def_abs_arg の鎖に、値 γ(θ~_μ) を関数 γ と別の文字 t で置き、cosh t = g の根拠を arccosh_properties (2) の y = g への適用に、sinh t > 0 の散文を cosh_sinh_basic_properties (3) の当てはめに、sinh t = r の一意性を cosh_sinh_basic_properties (4)（正の数の平方の一致）の当てはめに、g・r・t の住処の理由を書き、Step 2 を λ_± から始める鎖に、Step 3 の名前だけの根拠（実指数関数の狭義単調増加性・exp(0) = 1・正値性）を real_exp_strictly_increasing・scalar_exp_zero・real_exp_positive に直し、−t < 0 を鎖にした。主張に λ_±・γ・exp の出所を書いた（中身は不変）。",
      ],
    },
  },
  {
    id: "evenfermi_000_remark_overview",
    kind: "remark",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 2 },
    title: { tex: String.raw`\check\psi_\mu, \check\psi_\mu^\dagger \text{ を導入して } V^{(+)} = c\,\check{V}' \text{ を示す道筋}` },
    labels: [],
    statement: [
      paragraph([
        ref("T_V_plus_check_Z_Y"),
        " で ",
        math(String.raw`\left(T_{(V^{(+)})}(\check{Z}_\mu),\ T_{(V^{(+)})}(\check{Y}_\mu)\right)
= \left(\check{Z}_\mu,\ \check{Y}_\mu\right) A(\tilde\theta_\mu)`),
        " を、",
        ref("diagonalization_check_P_D"),
        " で ",
        math(String.raw`A(\tilde\theta_\mu) = \check{P}_\mu \check{D}_\mu \check{P}_\mu^{-1}`),
        " を得た。以下では、",
        math(String.raw`\check{P}_\mu`),
        " の列で ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " を組み替えた ",
        math(String.raw`\check\psi_\mu, \check\psi_\mu^\dagger`),
        " を導入し、",
      ]),
      displayMath(
        String.raw`\check{V}' := \exp\!\left(\sum_{\mu \in \check{\mathcal{M}}}
\gamma(\tilde\theta_\mu)\left(\check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}
- \tfrac12 I\right)\right)`,
      ),
      paragraph([
        "とおいたとき、ある ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " について ",
        math(String.raw`V^{(+)} = c\,\check{V}'`),
        " が成り立つこと（",
        ref("V_plus_eq_c_check_Vprime"),
        "）まで到達し、最後にこれを ",
        math(String.raw`\check{n}_\mu := \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}`),
        " で書き直す。",
        math(String.raw`c`),
        " の値の決定は次の章で扱う。",
      ]),
      paragraph([
        "**場合分けは一つも要らない。** ",
        ref("gamma_2_theta_tilde_nonzero"),
        " により ",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " が**すべての ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）とすべての ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "（臨界点を含む）について**成り立つので、",
        math(String.raw`\check\psi_\mu, \check\psi_\mu^\dagger`),
        " はすべての ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " について定義され、",
        math(String.raw`\check{V}'`),
        " の和も ",
        math(String.raw`\check{\mathcal{M}}`),
        " 全体にわたる。",
      ]),
      paragraph([
        "**平方根の分枝の議論も要らない。** ",
        ref("relation_of_gamma_2_theta_tilde"),
        " (4)(5) により根号が ",
        math(String.raw`\left|\gamma_2(\tilde\theta_\mu)\right| \in \mathbb{R}_{>0}`),
        " と ",
        math(String.raw`i\left|\gamma_2(\tilde\theta_\mu)\right|`),
        " に確定しているので、",
        ref("diagonalization_check_P_D"),
        " の ",
        math(String.raw`\check{P}_\mu`),
        " の成分は実の絶対値だけで書かれており、",
        math(String.raw`\check\psi`),
        " どうしの反交換関係を計算するときに分枝の問題が生じない。",
      ]),
      paragraph([
        "**対になる添字は ",
        math(String.raw`\mu`),
        " と ",
        math(String.raw`M_{\mathrm{col}}+1-\mu`),
        " である。** ",
        ref("conjugate_index_of_check_Z_Y"),
        " の ",
        math(String.raw`\tilde\theta_{M_{\mathrm{col}}+1-\mu} = 2\pi - \tilde\theta_\mu`),
        " と ",
        ref("anticommutator_of_check_Z_Y"),
        " の ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " に対応する。",
        ref("def_check_index_set"),
        " (2) により ",
        math(String.raw`M_{\mathrm{col}}+1-\mu`),
        " は ",
        math(String.raw`\check{\mathcal{M}}`),
        " の中にとどまるので、**以下では ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外の添字が現れない。**",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-10-31: 章立ての組み直しで、旧い章「ψ̌_μ, ψ̌_μ^† と V^{(+)} = c V̌'」の案内文をこの章の ψ̌ の定義の前へ移した。題を式で指すものにし、「この章」を「以下」に、「次章」を「次の章」に直し、「半整数運動量のフェルミオン」「フェルミオン」の語を外し、章の最後で ň_μ による書き直しを置くことを書き足した。",
      ],
    },
  },
  {
    id: "evenfermi_001_definition_check_fermi",
    kind: "definition",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 3 },
    title: { tex: String.raw`\check\psi_\mu, \check\psi_\mu^\dagger \text{（}\check{Z}_\mu, \check{Y}_\mu\text{ の一次結合）}` },
    labels: ["def_check_fermi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）とする。",
        ref("diagonalization_check_P_D"),
        " の ",
        math(String.raw`\check{P}_\mu`),
        " を用いて ",
        math(String.raw`\check\psi_\mu^\dagger, \check\psi_\mu \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を",
      ]),
      displayMath(
        String.raw`\begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix}
:= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu`,
      ),
      paragraph([
        "すなわち（",
        math(String.raw`a := \gamma_2(\tilde\theta_\mu)`),
        "、",
        math(String.raw`b := \gamma_2(-\tilde\theta_\mu)`),
        "、",
        math(String.raw`r := |a| \in \mathbb{R}_{>0}`),
        " と略記して）",
      ]),
      displayMath(
        String.raw`\check\psi_\mu^\dagger := \frac{-r}{2\sqrt{M_{\mathrm{col}}}\,b}\,\check{Z}_\mu + \frac{1}{2\sqrt{M_{\mathrm{col}}}}\,\check{Y}_\mu,
\qquad
\check\psi_\mu := \frac{+r}{2\sqrt{M_{\mathrm{col}}}\,b}\,\check{Z}_\mu + \frac{1}{2\sqrt{M_{\mathrm{col}}}}\,\check{Y}_\mu`,
      ),
      paragraph([
        "と定める（行ベクトルと ",
        math(String.raw`2\times 2`),
        " 行列の積は ",
        ref("def_pair_of_matrices_times_two_by_two_matrix"),
        "・",
        ref("def_pair_of_matrices_times_column_of_numbers"),
        " を続けて展開した ",
        math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}p & q \\ r & s\end{pmatrix} = (pA + rB,\ qA + sB)`),
        "）。",
      ]),
      paragraph([
        "**この定義は ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " のすべてについて意味をもつ。** ",
        ref("gamma_2_theta_tilde_nonzero"),
        " より ",
        math(String.raw`a \neq 0`),
        " すなわち ",
        math(String.raw`r > 0`),
        "、",
        ref("relation_of_gamma_2_theta_tilde"),
        " より ",
        math(String.raw`b \neq 0`),
        " であり、",
        math(String.raw`M_{\mathrm{col}} \geq 2`),
        " より ",
        math(String.raw`\sqrt{M_{\mathrm{col}}} > 0`),
        " なので分母 ",
        math(String.raw`2\sqrt{M_{\mathrm{col}}}\,b`),
        " は ",
        math(String.raw`0`),
        " でない（",
        ref("diagonalization_check_P_D"),
        " の Step 1）。したがって**除外される ",
        math(String.raw`\mu`),
        " は無い**。",
      ]),
      paragraph([
        math(String.raw`\dagger`),
        " は転置共役を表す記号ではなく、2 つの元を区別する添え字の一部として使う。",
      ]),
    ],
    proof: [],
    conversion: {
      status: "added",
      notes: [
        "008 章の def_fermi の半整数運動量版。008 章の P_μ の (1,1) 成分 +i√(γ_2(θ_μ)γ_2(−θ_μ))/(2√M γ_2(−θ_μ)) は、" +
          "relation_of_gamma_2_theta_tilde (5)（√(γ_2 γ_2(−)) = i|γ_2|）により半整数運動量では −|γ_2|/(2√M γ_2(−θ~_μ)) に等しい。" +
          "したがって定義式の形は 008 章と同一であり、根号が実の絶対値に書き換わっているだけである。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_01（定義式と P̌_μ の列の一致、および ψ̌ の M 周期性）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evenfermi_002_claim_periodicity",
    kind: "claim",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 4 },
    title: { tex: String.raw`\gamma_1, \gamma_2 \text{ の周期性と共役添字 } M_{\mathrm{col}}+1-\mu` },
    labels: ["periodicity_of_check_fermi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu \in \mathbb{R}`),
        "（",
        math(String.raw`\mu \in \mathbb{Z}`),
        "）と整数の像の記号 ",
        math(String.raw`a_{\mathbb R} := \iota_{\mathbb Z\to\mathbb R}(a)`),
        "（",
        math(String.raw`a \in \mathbb{Z}`),
        "）を用いる。次が成り立つ。",
      ]),
      list([
        [
          "(1) **",
          math(String.raw`\gamma_1, \gamma_2`),
          " の ",
          math(String.raw`2\pi`),
          " 周期性**（",
          math(String.raw`\theta \in \mathbb{R}`),
          "、",
          math(String.raw`k \in \mathbb{Z}`),
          "）：",
          math(String.raw`\gamma_1(\theta + 2\pi k_{\mathbb R}) = \gamma_1(\theta)`),
          "、",
          math(String.raw`\gamma_2(\theta + 2\pi k_{\mathbb R}) = \gamma_2(\theta)`),
          "。",
        ],
        [
          "(2) **添字の ",
          math(String.raw`M_{\mathrm{col}}`),
          " 周期性**（",
          math(String.raw`\mu, k \in \mathbb{Z}`),
          "）：",
          math(String.raw`\tilde\theta_{\mu+kM_{\mathrm{col}}} = \tilde\theta_\mu + 2\pi k_{\mathbb R}`),
          "、したがって ",
          math(String.raw`\gamma_1(\tilde\theta_{\mu+kM_{\mathrm{col}}}) = \gamma_1(\tilde\theta_\mu)`),
          "、",
          math(String.raw`\gamma_2(\pm\tilde\theta_{\mu+kM_{\mathrm{col}}}) = \gamma_2(\pm\tilde\theta_\mu)`),
          "（複号同順）。",
        ],
        [
          "(3) **共役添字**（",
          math(String.raw`\mu \in \check{\mathcal{M}}`),
          "）：",
          math(String.raw`\gamma_2(\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \gamma_2(-\tilde\theta_\mu)`),
          "、",
          math(String.raw`\gamma_2(-\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \gamma_2(\tilde\theta_\mu)`),
          "、",
          math(String.raw`\gamma_1(\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \gamma_1(\tilde\theta_\mu)`),
          "、",
          math(String.raw`\gamma(\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \gamma(\tilde\theta_\mu)`),
          "（",
          ref("def_gamma_theta"),
          "）、および ",
          ref("diagonalization_check_P_D"),
          " の ",
          math(String.raw`\check{P}`),
          " について",
        ],
      ]),
      displayMath(
        String.raw`\check{P}_{M_{\mathrm{col}}+1-\mu}
= \begin{pmatrix}
\dfrac{-\left|\gamma_2(-\tilde\theta_\mu)\right|}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(\tilde\theta_\mu)}
& \dfrac{+\left|\gamma_2(-\tilde\theta_\mu)\right|}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(\tilde\theta_\mu)} \\[8pt]
\dfrac{1}{2\sqrt{M_{\mathrm{col}}}} & \dfrac{1}{2\sqrt{M_{\mathrm{col}}}}
\end{pmatrix}`,
      ),
      paragraph([
        "（",
        math(String.raw`\check{P}_\mu`),
        " の式の ",
        math(String.raw`\gamma_2(\tilde\theta_\mu)`),
        " と ",
        math(String.raw`\gamma_2(-\tilde\theta_\mu)`),
        " を入れ替えたもの）。",
      ]),
      paragraph([
        "**この主張は全実数上の ",
        math(String.raw`\cos, \sin`),
        " を前提とする。** ",
        ref("def_gamma1_gamma2_of_theta"),
        " の ",
        math(String.raw`\gamma_1, \gamma_2`),
        " は全実数上の ",
        math(String.raw`\cos, \sin`),
        " の値で書かれ、証明は ",
        ref("euler_formula_cos_sin"),
        " の二つの等式、",
        ref("cos_of_negated_real"),
        "（これも ",
        ref("euler_formula_cos_sin"),
        " に依る）と ",
        math(String.raw`2\pi`),
        " 周期性（",
        math(String.raw`x \in \mathbb{R}`),
        "、",
        math(String.raw`n \in \mathbb{Z}`),
        " について ",
        math(String.raw`\cos(x+2\pi n_{\mathbb R}) = \cos x`),
        "、",
        math(String.raw`\sin(x+2\pi n_{\mathbb R}) = \sin x`),
        "）を使う。全実数への拡張は ",
        ref("euler_formula_cos_sin"),
        " の前置きのとおり未整備である。",
      ]),
      paragraph([
        "**この主張の (2) だけは ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " で量化する。** ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外の添字を扱う主張には、この (2) のほかに ",
        ref("half_integer_checkZ_periodicity"),
        " と ",
        ref("half_integer_checkY_periodicity"),
        " がある。(2) は ",
        math(String.raw`\gamma_1, \gamma_2`),
        " が ",
        math(String.raw`\theta \in \mathbb{R}`),
        " の関数（",
        ref("def_gamma1_gamma2_of_theta"),
        "）であることによって意味をもつ主張であり、",
        math(String.raw`\check{P}_\mu`),
        " や ",
        math(String.raw`\check\psi_\mu`),
        "（これらは ",
        math(String.raw`\check{\mathcal{M}}`),
        " 上でしか定義していない）には言及していない。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`c_1, c_2, c_2^*, s_1, s_2^* \in \mathbb{R}`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " の値、",
        math(String.raw`x \in \mathbb{R}`),
        " について ",
        math(String.raw`\cos x, \sin x \in \mathbb{R}`),
        " は全実数上の ",
        math(String.raw`\cos, \sin`),
        " の値である（全実数上への拡張は未整備）。これらの実数が ",
        math(String.raw`\mathbb{C}`),
        " の式に現れるときは、",
        ref("def_gamma1_gamma2_of_theta"),
        " の書き方に従い ",
        ref("inclusion_rr_to_cc"),
        " の像 ",
        math(String.raw`r_{\mathbb{C}}`),
        " として読み、像の記号を省く。",
        math(String.raw`\iota_{\mathbb Z\to\mathbb R}`),
        " は ",
        ref("antiperiodic_exp_sum"),
        " のとおり零・単位元・和・積を保つ。",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb R} \neq 0_{\mathbb R}`),
        " も ",
        ref("antiperiodic_exp_sum"),
        " による。",
      ]),
      paragraph([
        "第一に、",
        math(String.raw`x \in \mathbb{R}`),
        " について ",
        math(String.raw`\exp(ix)`),
        " を書く。",
        math(String.raw`-ix`),
        " は ",
        ref("euler_formula_cos_sin"),
        " の読みのとおり ",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-(ix)`),
        " である。以下の分母の ",
        math(String.raw`2`), " は ", math(String.raw`2_{\mathbb{C}}`),
        " で、",
        ref("exp_of_negative_i_real_as_cos_minus_i_sin"),
        " の証明の前置きのとおり ",
        ref("complex_numbers_form_a_field"),
        " の体で ",
        math(String.raw`2_{\mathbb{C}} \neq 0_{\mathbb{C}}`), "、",
        math(String.raw`i \neq 0_{\mathbb{C}}`), "、",
        math(String.raw`2_{\mathbb{C}}i \neq 0_{\mathbb{C}}`),
        " なので、分数は定まる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\cos x + i\sin x
&= \frac{\exp(ix) + \exp(-ix)}{2} + i\,\frac{\exp(ix) - \exp(-ix)}{2i}
&&(\because\ \blkref{euler_formula_cos_sin})\\
&= \frac{\exp(ix) + \exp(-ix)}{2} + \frac{i\bigl(\exp(ix) - \exp(-ix)\bigr)}{2i}
&&\bigl(\because\ \mathbb{C}\ \text{で}\ u\tfrac{v}{w} = \tfrac{uv}{w}\ (w \neq 0_{\mathbb{C}})\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ u \to i,\ v \to \exp(ix) - \exp(-ix),\ w \to 2i\bigr)\\
&= \frac{\exp(ix) + \exp(-ix)}{2} + \frac{\bigl(\exp(ix) - \exp(-ix)\bigr)i}{2i}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の可換律})\\
&= \frac{\exp(ix) + \exp(-ix)}{2} + \frac{\exp(ix) - \exp(-ix)}{2}
&&\bigl(\because\ \mathbb{C}\ \text{で}\ \tfrac{va}{wa} = \tfrac{v}{w}\ (a \neq 0_{\mathbb{C}},\ w \neq 0_{\mathbb{C}})\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ v \to \exp(ix) - \exp(-ix),\ w \to 2,\ a \to i\bigr)\\
&= \frac{\bigl(\exp(ix) + \exp(-ix)\bigr) + \bigl(\exp(ix) - \exp(-ix)\bigr)}{2}
&&\bigl(\because\ \mathbb{C}\ \text{で}\ \tfrac{u}{w} + \tfrac{v}{w} = \tfrac{u + v}{w}\ (w \neq 0_{\mathbb{C}})\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ u \to \exp(ix) + \exp(-ix),\ v \to \exp(ix) - \exp(-ix),\ w \to 2\bigr)\\
&= \frac{\bigl(\exp(ix) + \exp(-ix)\bigr) + \bigl(\exp(ix) + (-\exp(-ix))\bigr)}{2}
&&(\because\ \blkref{def_complex_difference})\\
&= \frac{\exp(ix) + \Bigl(\exp(-ix) + \bigl(\exp(ix) + (-\exp(-ix))\bigr)\Bigr)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律})\\
&= \frac{\exp(ix) + \Bigl(\bigl(\exp(-ix) + \exp(ix)\bigr) + (-\exp(-ix))\Bigr)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律})\\
&= \frac{\exp(ix) + \Bigl(\bigl(\exp(ix) + \exp(-ix)\bigr) + (-\exp(-ix))\Bigr)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の可換律})\\
&= \frac{\exp(ix) + \Bigl(\exp(ix) + \bigl(\exp(-ix) + (-\exp(-ix))\bigr)\Bigr)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の和の結合律})\\
&= \frac{\exp(ix) + \bigl(\exp(ix) + 0_{\mathbb{C}}\bigr)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法逆元})\\
&= \frac{\exp(ix) + \exp(ix)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の零元})\\
&= \frac{1_{\mathbb{C}}\exp(ix) + 1_{\mathbb{C}}\exp(ix)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元を 2 箇所へ右辺から左辺へ})\\
&= \frac{\bigl(1_{\mathbb{C}} + 1_{\mathbb{C}}\bigr)\exp(ix)}{2}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の分配律を右辺から左辺へ})\\
&= \frac{(1 + 1)_{\mathbb{C}}\,\exp(ix)}{2}
&&\bigl(\because\ \blkref{real_inclusion_preserves_sum}\ (a \to 1,\ b \to 1)\bigr)\\
&= \frac{2\exp(ix)}{2}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 1 + 1 = 2\bigr)\\
&= \exp(ix)
&&\bigl(\because\ \mathbb{C}\ \text{で}\ \tfrac{2a}{2} = a\ (2 \neq 0_{\mathbb{C}})\ \text{（}\mathbb{C}\ \text{は体 }\blkref{complex_numbers_form_a_field}\text{）}\text{の}\ a \to \exp(ix)\bigr)
\end{aligned}`),
      paragraph([
        "第二に、",
        math(String.raw`k \in \mathbb{Z}`),
        " について ",
        math(String.raw`(-k)_{\mathbb R} = -k_{\mathbb R}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
(-k)_{\mathbb R}
&= (-k)_{\mathbb R} + 0_{\mathbb R}
&&(\because\ 0_{\mathbb R}\ \text{は}\ \mathbb{R}\ \text{の和の単位元})\\
&= (-k)_{\mathbb R} + \bigl(k_{\mathbb R} + (-k_{\mathbb R})\bigr)
&&(\because\ \mathbb{R}\ \text{の加法逆元}\ k_{\mathbb R} + (-k_{\mathbb R}) = 0_{\mathbb R})\\
&= \bigl((-k)_{\mathbb R} + k_{\mathbb R}\bigr) + (-k_{\mathbb R})
&&(\because\ \mathbb{R}\ \text{の加法の結合律})\\
&= \bigl((-k) + k\bigr)_{\mathbb R} + (-k_{\mathbb R})
&&(\because\ \iota_{\mathbb Z\to\mathbb R}\ \text{は和を保つ})\\
&= (0)_{\mathbb R} + (-k_{\mathbb R})
&&(\because\ \mathbb{Z}\ \text{で}\ (-k) + k = 0)\\
&= 0_{\mathbb R} + (-k_{\mathbb R})
&&(\because\ \iota_{\mathbb Z\to\mathbb R}\ \text{は零を保つ})\\
&= -k_{\mathbb R}
&&(\because\ 0_{\mathbb R}\ \text{は}\ \mathbb{R}\ \text{の和の単位元})
\end{aligned}`),
      paragraph([
        "第三に、",
        math(String.raw`x \in \mathbb{R}`),
        " について ",
        math(String.raw`\mathbb{R}`),
        " の等式 ",
        math(String.raw`\cos(-x) = \cos x`),
        " を作る。",
        ref("cos_of_negated_real"),
        "（",
        math(String.raw`\theta \to x`),
        "）より ",
        math(String.raw`(\cos(-x))_{\mathbb{C}} = (\cos x)_{\mathbb{C}}`),
        " なので、",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to \cos(-x),\ b \to \cos x`),
        "）より ",
        math(String.raw`\cos(-x) = \cos x`),
        " である。",
      ]),
      paragraph([
        "(1) ",
        math(String.raw`\theta \in \mathbb{R}`),
        "、",
        math(String.raw`k \in \mathbb{Z}`),
        " とする。",
        math(String.raw`\theta + 2\pi k_{\mathbb R} \in \mathbb{R}`),
        " なので ",
        ref("def_gamma1_gamma2_of_theta"),
        " をこの点に適用できる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma_1(\theta + 2\pi k_{\mathbb R})
&= c_1c_2^* - s_1s_2^*\cos(\theta + 2\pi k_{\mathbb R})
&&(\because\ \blkref{def_gamma1_gamma2_of_theta}\ \text{を}\ \theta + 2\pi k_{\mathbb R}\ \text{に適用})\\
&= c_1c_2^* - s_1s_2^*\cos\theta
&&(\because\ \cos\ \text{の}\ 2\pi\ \text{周期性を}\ n = k\ \text{で})\\
&= \gamma_1(\theta)
&&(\because\ \blkref{def_gamma1_gamma2_of_theta})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta + 2\pi k_{\mathbb R})
&= i\,\exp(i(\theta + 2\pi k_{\mathbb R}))\,s_2^*\bigl(c_1\cos(\theta + 2\pi k_{\mathbb R}) - i\sin(\theta + 2\pi k_{\mathbb R}) - s_1c_2\bigr)
&&(\because\ \blkref{def_gamma1_gamma2_of_theta}\ \text{を}\ \theta + 2\pi k_{\mathbb R}\ \text{に適用})\\
&= i\,\bigl(\cos(\theta + 2\pi k_{\mathbb R}) + i\sin(\theta + 2\pi k_{\mathbb R})\bigr)\,s_2^*\bigl(c_1\cos(\theta + 2\pi k_{\mathbb R}) - i\sin(\theta + 2\pi k_{\mathbb R}) - s_1c_2\bigr)
&&(\because\ \text{準備の}\ \exp(ix)\ \text{の表示を}\ x = \theta + 2\pi k_{\mathbb R}\ \text{で})\\
&= i\,\bigl(\cos\theta + i\sin(\theta + 2\pi k_{\mathbb R})\bigr)\,s_2^*\bigl(c_1\cos\theta - i\sin(\theta + 2\pi k_{\mathbb R}) - s_1c_2\bigr)
&&(\because\ \cos\ \text{の}\ 2\pi\ \text{周期性を}\ n = k\ \text{で 2 箇所へ同時適用})\\
&= i\,\bigl(\cos\theta + i\sin\theta\bigr)\,s_2^*\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)
&&(\because\ \sin\ \text{の}\ 2\pi\ \text{周期性を}\ n = k\ \text{で 2 箇所へ同時適用})\\
&= i\,\exp(i\theta)\,s_2^*\bigl(c_1\cos\theta - i\sin\theta - s_1c_2\bigr)
&&(\because\ \text{準備の}\ \exp(ix)\ \text{の表示を}\ x = \theta\ \text{で})\\
&= \gamma_2(\theta)
&&(\because\ \blkref{def_gamma1_gamma2_of_theta})
\end{aligned}`),
      paragraph([
        "(2) ",
        math(String.raw`\mu, k \in \mathbb{Z}`),
        " とする。",
        math(String.raw`\mu + kM_{\mathrm{col}} \in \mathbb{Z}`),
        " なので ",
        math(String.raw`\tilde\theta`),
        " の定義をこの添字に適用できる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\tilde\theta_{\mu+kM_{\mathrm{col}}}
&= \frac{2\pi\left((\mu+kM_{\mathrm{col}})_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \tilde\theta\ \text{の定義を}\ \mu+kM_{\mathrm{col}}\ \text{で。}\blkref{antiperiodic_exp_sum})\\
&= \frac{2\pi\left(\left(\mu_{\mathbb R}+(kM_{\mathrm{col}})_{\mathbb R}\right)-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \iota_{\mathbb Z\to\mathbb R}\ \text{は和を保つ})\\
&= \frac{2\pi\left(\left(\mu_{\mathbb R}+k_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}\right)-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \iota_{\mathbb Z\to\mathbb R}\ \text{は積を保つ})\\
&= \frac{2\pi\left(\left(k_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}+\mu_{\mathbb R}\right)-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb{R}\ \text{の加法の交換律})\\
&= \frac{2\pi\left(\left(k_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}+\mu_{\mathbb R}\right)+\left(-\tfrac12\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb{R}\ \text{の差の定義})\\
&= \frac{2\pi\left(k_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}+\left(\mu_{\mathbb R}+\left(-\tfrac12\right)\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb{R}\ \text{の加法の結合律})\\
&= \frac{2\pi\left(k_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}+\left(\mu_{\mathbb R}-\tfrac12\right)\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb{R}\ \text{の差の定義を右辺から左辺へ})\\
&= \frac{2\pi\left(\left(\mu_{\mathbb R}-\tfrac12\right)+k_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}\right)}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb{R}\ \text{の加法の交換律})\\
&= \frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)+2\pi k_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \mathbb{R}\ \text{の分配法則})\\
&= \frac{2\pi\left(\mu_{\mathbb R}-\tfrac12\right)}{(M_{\mathrm{col}})_{\mathbb R}}+\frac{2\pi k_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ (M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}\ \text{を分母とする分数の和})\\
&= \tilde\theta_\mu+\frac{2\pi k_{\mathbb R}(M_{\mathrm{col}})_{\mathbb R}}{(M_{\mathrm{col}})_{\mathbb R}}
&&(\because\ \tilde\theta_\mu\ \text{の定義。}\blkref{antiperiodic_exp_sum})\\
&= \tilde\theta_\mu+2\pi k_{\mathbb R}
&&(\because\ (M_{\mathrm{col}})_{\mathbb R}\neq0_{\mathbb R}\ \text{による約分})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\tilde\theta_{\mu+kM_{\mathrm{col}}}
&= -\left(\tilde\theta_\mu+2\pi k_{\mathbb R}\right)
&&(\because\ \text{上の鎖})\\
&= \left(-\tilde\theta_\mu\right)+\left(-2\pi k_{\mathbb R}\right)
&&(\because\ \mathbb{R}\ \text{で}\ -(u+v) = (-u)+(-v))\\
&= \left(-\tilde\theta_\mu\right)+2\pi\left(-k_{\mathbb R}\right)
&&(\because\ \mathbb{R}\ \text{で}\ -(uv) = u(-v))\\
&= \left(-\tilde\theta_\mu\right)+2\pi(-k)_{\mathbb R}
&&(\because\ \text{準備の第二})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\gamma_1(\tilde\theta_{\mu+kM_{\mathrm{col}}})
&= \gamma_1(\tilde\theta_\mu+2\pi k_{\mathbb R})
&&(\because\ \text{上の第一の鎖})\\
&= \gamma_1(\tilde\theta_\mu)
&&(\because\ \text{本ブロックの (1) を}\ \theta = \tilde\theta_\mu\ \text{で}),\\[4pt]
\gamma_2(\tilde\theta_{\mu+kM_{\mathrm{col}}})
&= \gamma_2(\tilde\theta_\mu+2\pi k_{\mathbb R})
&&(\because\ \text{上の第一の鎖})\\
&= \gamma_2(\tilde\theta_\mu)
&&(\because\ \text{本ブロックの (1) を}\ \theta = \tilde\theta_\mu\ \text{で}),\\[4pt]
\gamma_2(-\tilde\theta_{\mu+kM_{\mathrm{col}}})
&= \gamma_2\bigl(\left(-\tilde\theta_\mu\right)+2\pi(-k)_{\mathbb R}\bigr)
&&(\because\ \text{上の第二の鎖})\\
&= \gamma_2(-\tilde\theta_\mu)
&&(\because\ \text{本ブロックの (1) を}\ \theta = -\tilde\theta_\mu,\ -k \in \mathbb{Z}\ \text{で})
\end{aligned}`),
      paragraph([
        "(3) ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " とし、",
        math(String.raw`\nu := M_{\mathrm{col}}+1-\mu`),
        " とおく。",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " である。添字の角度を書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\tilde\theta_\nu
&= 2\pi - \tilde\theta_\mu
&&(\because\ \blkref{conjugate_index_of_check_Z_Y}\ (1))\\
&= 2\pi + \left(-\tilde\theta_\mu\right)
&&(\because\ \mathbb{R}\ \text{の差の定義})\\
&= \left(-\tilde\theta_\mu\right) + 2\pi
&&(\because\ \mathbb{R}\ \text{の加法の交換律})\\
&= \left(-\tilde\theta_\mu\right) + 2\pi\cdot1_{\mathbb R}
&&(\because\ 1_{\mathbb R}\ \text{は積の単位元})\\
&= \left(-\tilde\theta_\mu\right) + 2\pi\,(1)_{\mathbb R}
&&(\because\ \iota_{\mathbb Z\to\mathbb R}\ \text{は単位元を保つ})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\tilde\theta_\nu
&= -\left(2\pi - \tilde\theta_\mu\right)
&&(\because\ \blkref{conjugate_index_of_check_Z_Y}\ (1))\\
&= \tilde\theta_\mu + \left(-2\pi\right)
&&(\because\ \mathbb{R}\ \text{で}\ -(u-v) = v+(-u))\\
&= \tilde\theta_\mu + 2\pi\left(-1_{\mathbb R}\right)
&&(\because\ \mathbb{R}\ \text{で}\ -u = u(-1_{\mathbb R}))\\
&= \tilde\theta_\mu + 2\pi\left(-(1)_{\mathbb R}\right)
&&(\because\ \iota_{\mathbb Z\to\mathbb R}\ \text{は単位元を保つ})\\
&= \tilde\theta_\mu + 2\pi\,(-1)_{\mathbb R}
&&(\because\ \text{準備の第二を}\ k = 1\ \text{で})
\end{aligned}`),
      paragraph(["これを使って、主張の左辺から"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\tilde\theta_\nu)
&= \gamma_2\bigl(\left(-\tilde\theta_\mu\right) + 2\pi\,(1)_{\mathbb R}\bigr)
&&(\because\ \text{上の}\ \tilde\theta_\nu\ \text{の鎖})\\
&= \gamma_2(-\tilde\theta_\mu)
&&(\because\ \text{本ブロックの (1) を}\ \theta = -\tilde\theta_\mu,\ k = 1\ \text{で}),\\[4pt]
\gamma_2(-\tilde\theta_\nu)
&= \gamma_2\bigl(\tilde\theta_\mu + 2\pi\,(-1)_{\mathbb R}\bigr)
&&(\because\ \text{上の}\ -\tilde\theta_\nu\ \text{の鎖})\\
&= \gamma_2(\tilde\theta_\mu)
&&(\because\ \text{本ブロックの (1) を}\ \theta = \tilde\theta_\mu,\ k = -1\ \text{で}),\\[4pt]
\gamma_1(\tilde\theta_\nu)
&= \gamma_1\bigl(\left(-\tilde\theta_\mu\right) + 2\pi\,(1)_{\mathbb R}\bigr)
&&(\because\ \text{上の}\ \tilde\theta_\nu\ \text{の鎖})\\
&= \gamma_1(-\tilde\theta_\mu)
&&(\because\ \text{本ブロックの (1) を}\ \theta = -\tilde\theta_\mu,\ k = 1\ \text{で})\\
&= c_1c_2^* - s_1s_2^*\cos(-\tilde\theta_\mu)
&&(\because\ \blkref{def_gamma1_gamma2_of_theta}\ \text{を}\ -\tilde\theta_\mu\ \text{に適用})\\
&= c_1c_2^* - s_1s_2^*\cos\tilde\theta_\mu
&&(\because\ \text{準備の第三の}\ \cos(-x) = \cos x\ \text{を}\ x = \tilde\theta_\mu\ \text{で})\\
&= \gamma_1(\tilde\theta_\mu)
&&(\because\ \blkref{def_gamma1_gamma2_of_theta}),\\[4pt]
\gamma(\tilde\theta_\nu)
&= \mathrm{arccosh}\bigl(\gamma_1(\tilde\theta_\nu)\bigr)
&&(\because\ \blkref{def_gamma_theta})\\
&= \mathrm{arccosh}\bigl(\gamma_1(\tilde\theta_\mu)\bigr)
&&(\because\ \text{上の}\ \gamma_1\ \text{の鎖})\\
&= \gamma(\tilde\theta_\mu)
&&(\because\ \blkref{def_gamma_theta})
\end{aligned}`),
      paragraph([
        "最後に ",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " なので ",
        ref("diagonalization_check_P_D"),
        " の ",
        math(String.raw`\check{P}_\nu`),
        " が定まり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\check{P}_\nu
&= \begin{pmatrix}
\dfrac{-\left|\gamma_2(\tilde\theta_\nu)\right|}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\nu)}
& \dfrac{+\left|\gamma_2(\tilde\theta_\nu)\right|}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\nu)} \\[8pt]
\dfrac{1}{2\sqrt{M_{\mathrm{col}}}} & \dfrac{1}{2\sqrt{M_{\mathrm{col}}}}
\end{pmatrix}
&&(\because\ \blkref{diagonalization_check_P_D}\ \text{を}\ \nu\ \text{で})\\
&= \begin{pmatrix}
\dfrac{-\left|\gamma_2(-\tilde\theta_\mu)\right|}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\nu)}
& \dfrac{+\left|\gamma_2(-\tilde\theta_\mu)\right|}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\nu)} \\[8pt]
\dfrac{1}{2\sqrt{M_{\mathrm{col}}}} & \dfrac{1}{2\sqrt{M_{\mathrm{col}}}}
\end{pmatrix}
&&(\because\ \text{上の}\ \gamma_2(\tilde\theta_\nu) = \gamma_2(-\tilde\theta_\mu)\ \text{を 2 箇所へ同時代入})\\
&= \begin{pmatrix}
\dfrac{-\left|\gamma_2(-\tilde\theta_\mu)\right|}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(\tilde\theta_\mu)}
& \dfrac{+\left|\gamma_2(-\tilde\theta_\mu)\right|}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(\tilde\theta_\mu)} \\[8pt]
\dfrac{1}{2\sqrt{M_{\mathrm{col}}}} & \dfrac{1}{2\sqrt{M_{\mathrm{col}}}}
\end{pmatrix}
&&(\because\ \text{上の}\ \gamma_2(-\tilde\theta_\nu) = \gamma_2(\tilde\theta_\mu)\ \text{を 2 箇所へ同時代入})
\end{aligned}`),
      paragraph(["となる。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章では対応する事実が gamma2_theta_M_periodicity と hatZ_hatY_M_periodicity に分かれ、" +
          "action_of_T_Vprime_on_psi の proof の中で μ の符号ごとの場合分け（a)〜c)）として使われていた。" +
          "半整数運動量では添字を 𝓜̌ = {1,…,M} に絞り、共役添字を M+1−μ で取ることで場合分けが要らない。",
        "以前この主張は ψ̌_{μ+kM} = ψ̌_μ（μ ∈ Z）を含んでいたが、共役添字を 1−μ から M+1−μ へ書き換えたことで " +
          "ψ̌ を 𝓜̌ の外の添字で評価する箇所が本文から消えたため、その項目は不要になった。" +
          "γ_1, γ_2 は θ ∈ R の関数なので (2) だけは μ ∈ Z のまま残してある。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_01、sagemath/check/periodicity_of_check_fermi/（証明の各行）。",
        "2026-08-19 の式変形統一で、周期性の鎖の機械識別子を人間可読な根拠へ直し、根拠の無かった分配則の行を補った。" +
          "また、「同じ計算」に省略していた共役添字の二本の導出を、各結論の左辺から始まる鎖へ開いた。内容と参照は変えていない。",
        "2026-11-03（全証明の SageMath 検算）: (1) が主張と違う式を述べる euler_formula_cos_sin を exp(i(t+2kπ)) の表示に引いていたので、準備で euler_formula_cos_sin から exp(ix) = cos x + i sin x と cos(−x) = cos x を導く鎖にした。" +
          "「(1) が従う」「成分が書けることが分かる」の散文を γ_1・γ_2・γ・P̌ の鎖に、角度を像の記号 k_R で書き、P̌_{M+1−μ} の主張を行列で明示し、全実数上の cos・sin の 2π 周期性を前提とすることを主張に書いた。主張の中身は変えていない。",
        "2026-11-09（Lean の通しの証明のゴールラインの確認）: 準備の第一の名前だけの根拠「ℂ の四則」3 か所（cos(-x) の鎖の i(-w) = -iw・-i(-w) = iw、cos x + i sin x の鎖の i/(2i) = 1/2 と最後の行）と、1 行に 3 つの等号を使っていた (-x)_C = -x_C の行を、relation_of_gamma_2_theta_tilde の準備の第一と同じ書き方にした。-x ∈ ℝ のまま i(-x) = -ix（6 行）と -i(-x) = ix（2 行）を先に作り、cos(-x) の鎖からそれを引く。cos x + i sin x の鎖は ℂ の体の等式 1 つずつの 17 行にした。値と主張は不変。",
        "2026-11-09（Lean の通しの証明のゴールラインの確認）: 準備の第一の i(-x) = -ix（6 行）・-i(-x) = ix（2 行）・cos(-x) の 5 行の鎖は、主張 i_times_negated_real_is_negation_of_i_times・negation_of_i_times_negated_real_is_i_times・cos_of_negated_real の鎖と同じだった。" +
          "3 本の鎖を消し、cos(-x) = cos x を cos_of_negated_real と inclusion_rr_to_cc_is_injective から ℝ の等式として作る文（準備の第三）にした（消した鎖は ℂ の等式で終わり、ℝ の γ_1 の鎖へ像の記号を省いて持ち込んでいた）。(3) の γ_1 の鎖の行と主張の中身は不変。",
        "2026-11-10（Lean の通しの証明）: 1 行に 2 つの事実を当てていた 2 行を割った。準備の第二の「k_R + (-k_R) = 0_R と零の性質」を、和の単位元の行と加法逆元の行に（6 等号 → 7 等号）、(2) の θ~_{μ+kM} の鎖の「ℝ の加法の結合律と交換律」を、交換律・差の定義・結合律・差の定義（右辺から左辺へ）・交換律の 5 行に（8 等号 → 12 等号）した。主張の中身は不変。",
      ],
    },
  },
  {
    id: "evenfermi_003_claim_anticommutator",
    kind: "claim",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 5 },
    title: { tex: String.raw`\check\psi \text{ の反交換関係}` },
    labels: ["anticommutator_of_check_psi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`\left[\check\psi_\mu^\dagger, \check\psi_\nu^\dagger\right]_+ = 0,
\qquad
\left[\check\psi_\mu^\dagger, \check\psi_\nu\right]_+ = \delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I,
\qquad
\left[\check\psi_\mu, \check\psi_\nu\right]_+ = 0`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`I := I_{\mathrm{Mat}(2^{(M_{\mathrm{col}})_{\mathbb N}},\mathbb{C})}`),
        "、",
        math(String.raw`\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}`),
        " は ",
        ref("anticommutator_of_check_Z_Y"),
        " と同じ通常のクロネッカーのデルタ）。反交換子は ",
        ref("def_matrix_anticommutator"),
        "、右辺の ",
        math(String.raw`0`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列 ",
        math(String.raw`O \in \mathrm{Mat}(2^{(M_{\mathrm{col}})_{\mathbb N}},\mathbb{C})`),
        " である。対になる添字は ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " である。",
        ref("def_check_index_set"),
        " (5) により、この対の条件は合同式なしで書ける。",
      ]),
    ],
    proof: [
      paragraph([
        "準備（記号と読み方）。",
        math(String.raw`N := (M_{\mathrm{col}})_{\mathbb N}`),
        "、",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb R}`),
        "・",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb C}`),
        " は ",
        ref("antiperiodic_exp_sum"),
        " の像の記号とし、",
        math(String.raw`I := I_{\mathrm{Mat}(2^{N},\mathbb{C})}`),
        "、",
        math(String.raw`O \in \mathrm{Mat}(2^{N},\mathbb{C})`),
        " と置く。",
        math(String.raw`s := \sqrt{(M_{\mathrm{col}})_{\mathbb R}}^{(\mathbb{R}_{\ge 0})} \in \mathbb{R}_{\ge 0}`),
        "（",
        ref("definition_of_sqrt_r_positive"),
        "。",
        math(String.raw`s^2 = (M_{\mathrm{col}})_{\mathbb R}`),
        "。二乗は ",
        ref("def_power_of_real_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "）である）と置く。",
        math(String.raw`s`),
        " と下の ",
        math(String.raw`r_\lambda`),
        " は ",
        math(String.raw`\mathbb{R}_{\ge 0}`),
        " の平方根の値であり、存在を ",
        math(String.raw`\mathbb{R}`),
        " の完備性に頼るので ",
        math(String.raw`\mathbb{R}`),
        " へ脱出している（",
        math(String.raw`M_{\mathrm{col}}`),
        " が平方数でなければ ",
        math(String.raw`s \notin \mathbb{Q}`),
        "）。",
        math(String.raw`\sigma := s_{\mathbb C}`),
        "、",
        math(String.raw`t := 2_{\mathbb C}\,\sigma \in \mathbb{C}`),
        "（",
        math(String.raw`2_{\mathbb C} := (2_{\mathbb R})_{\mathbb C}`),
        "、",
        ref("inclusion_rr_to_cc"),
        "）と置き、",
        math(String.raw`\lambda \in \check{\mathcal{M}}`),
        " について",
      ]),
      displayMath(
        String.raw`a_\lambda := \gamma_2(\tilde\theta_\lambda) \in \mathbb{C},\quad
b_\lambda := \gamma_2(-\tilde\theta_\lambda) \in \mathbb{C},\quad
r_\lambda := |a_\lambda| \in \mathbb{R}_{>0},\quad
\rho_\lambda := (r_\lambda)_{\mathbb C},\quad
d_\lambda := t\,b_\lambda \in \mathbb{C}`,
      ),
      paragraph([
        "と置く（",
        math(String.raw`r_\lambda > 0`),
        " は ",
        ref("def_check_fermi"),
        " の前置き）。",
        ref("def_check_fermi"),
        " の後段により ",
        math(String.raw`t \neq 0_{\mathbb C}`),
        "、",
        math(String.raw`d_\lambda \neq 0_{\mathbb C}`),
        " である。",
        math(String.raw`w \in \mathbb{C}`),
        "、",
        math(String.raw`w \neq 0_{\mathbb C}`),
        " の逆元 ",
        math(String.raw`w^{-1}`),
        " は ",
        ref("complex_numbers_form_a_field"),
        " のもので、商を ",
        math(String.raw`z/w := z\,w^{-1}`),
        " と書く。",
        math(String.raw`-z := (-1_{\mathbb C})z`),
        " は ",
        ref("multiply_by_minus_one"),
        " である。",
      ]),
      displayMath(
        String.raw`u^{-}_\lambda := (-\rho_\lambda)\,d_\lambda^{-1},\qquad
u^{+}_\lambda := \rho_\lambda\,d_\lambda^{-1},\qquad
h := 1_{\mathbb C}\,t^{-1}`,
      ),
      paragraph([
        "と置く。",
        ref("def_check_fermi"),
        " の係数 ",
        math(String.raw`\frac{\mp r}{2\sqrt{M_{\mathrm{col}}}\,b}`),
        "・",
        math(String.raw`\frac{1}{2\sqrt{M_{\mathrm{col}}}}`),
        " は、実数 ",
        math(String.raw`r_\lambda`),
        "・",
        math(String.raw`2`),
        "・",
        math(String.raw`\sqrt{M_{\mathrm{col}}} = s`),
        " を包含の像 ",
        math(String.raw`\rho_\lambda`),
        "・",
        math(String.raw`2_{\mathbb C}`),
        "・",
        math(String.raw`\sigma`),
        " と読んだ ",
        math(String.raw`u^{\mp}_\lambda`),
        "・",
        math(String.raw`h`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\psi_\lambda^\dagger &= u^{-}_\lambda\check{Z}_\lambda + h\,\check{Y}_\lambda
&&\bigl(\because\ \blkref{def_check_fermi}\bigr),\\
\check\psi_\lambda &= u^{+}_\lambda\check{Z}_\lambda + h\,\check{Y}_\lambda
&&\bigl(\because\ \blkref{def_check_fermi}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`\delta := \delta_{\nu,\,M_{\mathrm{col}}+1-\mu} \in \mathbb{C}`),
        "（",
        ref("def_kronecker_delta"),
        " を ",
        math(String.raw`n = M_{\mathrm{col}}`),
        " で。",
        ref("def_check_index_set"),
        " (2) により ",
        math(String.raw`\nu,\ M_{\mathrm{col}}+1-\mu \in \check{\mathcal M}`),
        "）、",
        math(String.raw`\omega := \left(2_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C}\right)\delta \in \mathbb{C}`),
        " と置く。",
        ref("anticommutator_of_check_Z_Y"),
        " の右辺の ",
        math(String.raw`2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I`),
        " は、その主張の後段のとおりスカラー倍 ",
        math(String.raw`\omega I`),
        " である。",
      ]),
      paragraph([
        "準備 1（",
        math(String.raw`\check{Y}`),
        " と ",
        math(String.raw`\check{Z}`),
        " の順の反交換子）。",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Y}_\mu, \check{Z}_\nu\right]_+
&= \check{Y}_\mu\check{Z}_\nu + \check{Z}_\nu\check{Y}_\mu
&&\bigl(\because\ \blkref{def_matrix_anticommutator}\bigr)\\
&= \check{Z}_\nu\check{Y}_\mu + \check{Y}_\mu\check{Z}_\nu
&&\bigl(\because\ \blkref{matrix_sum_is_commutative}\bigr)\\
&= \left[\check{Z}_\nu, \check{Y}_\mu\right]_+
&&\bigl(\because\ \blkref{def_matrix_anticommutator}\bigr)\\
&= O
&&\bigl(\because\ \blkref{anticommutator_of_check_Z_Y}\text{ の第 2 式を添字の組 }(\nu,\mu)\text{ で}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "準備 2（係数を残した展開）。",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        "、",
        math(String.raw`u, u' \in \mathbb{C}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[u\check{Z}_\mu + h\check{Y}_\mu,\ u'\check{Z}_\nu + h\check{Y}_\nu\right]_+
&= \Bigl[\sum_{j=1}^{2} x_jX_j,\ \sum_{k=1}^{2} y_kW_k\Bigr]_+
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\text{ を 2 箇所へ同時適用。}(x_1,x_2) := (u,h),\ (X_1,X_2) := (\check{Z}_\mu,\check{Y}_\mu),\ (y_1,y_2) := (u',h),\ (W_1,W_2) := (\check{Z}_\nu,\check{Y}_\nu)\bigr)\\
&= \sum_{j=1}^{2}\sum_{k=1}^{2} (x_jy_k)\left[X_j, W_k\right]_+
&&\bigl(\because\ \blkref{anticommutator_of_finite_sums_of_scalar_multiples}\ (n = 2^{N},\ r = s = 2)\bigr)\\
&= \Bigl((uu')\left[\check{Z}_\mu,\check{Z}_\nu\right]_+ + (uh)\left[\check{Z}_\mu,\check{Y}_\nu\right]_+\Bigr)
 + \Bigl((hu')\left[\check{Y}_\mu,\check{Z}_\nu\right]_+ + (hh)\left[\check{Y}_\mu,\check{Y}_\nu\right]_+\Bigr)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\text{ を内側の 2 つと外側の 1 つへ同時適用}\bigr)\\
&= \Bigl((uu')(\omega I) + (uh)O\Bigr)
 + \Bigl((hu')\left[\check{Y}_\mu,\check{Z}_\nu\right]_+ + (hh)(\omega I)\Bigr)
&&\bigl(\because\ \blkref{anticommutator_of_check_Z_Y}\text{ を 3 箇所へ同時適用}\bigr)\\
&= \Bigl((uu')(\omega I) + (uh)O\Bigr)
 + \Bigl((hu')O + (hh)(\omega I)\Bigr)
&&(\because\ \text{準備 1})\\
&= \Bigl((uu')(\omega I) + O\Bigr) + \Bigl(O + (hh)(\omega I)\Bigr)
&&\bigl(\because\ \blkref{scalar_multiple_of_zero_matrix}\text{ を 2 箇所へ同時適用}\bigr)\\
&= (uu')(\omega I) + \Bigl(O + (hh)(\omega I)\Bigr)
&&\bigl(\because\ \blkref{matrix_plus_zero_matrix}\bigr)\\
&= (uu')(\omega I) + (hh)(\omega I)
&&\bigl(\because\ \blkref{zero_matrix_plus_matrix}\bigr)\\
&= \bigl((uu')\omega\bigr)I + \bigl((hh)\omega\bigr)I
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\text{ を 2 箇所へ同時適用}\bigr)\\
&= \sum_{j=1}^{2} (c_jI)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\text{。}(c_1, c_2) := ((uu')\omega, (hh)\omega)\bigr)\\
&= \Bigl(\sum_{j=1}^{2} c_j\Bigr)I
&&\bigl(\because\ \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\ (r = 2)\bigr)\\
&= \bigl((uu')\omega + (hh)\omega\bigr)I
&&\bigl(\because\ \blkref{def_finite_sum_of_complex_numbers}\bigr)\\
&= \bigl((uu' + hh)\,\omega\bigr)I
&&\bigl(\because\ \mathbb{C}\text{ の分配法則。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。",
      ]),
      paragraph([
        "準備 3（",
        math(String.raw`\nu \neq M_{\mathrm{col}}+1-\mu`),
        " の場合）。このとき ",
        math(String.raw`\delta = 0_{\mathbb C}`),
        "（",
        ref("def_kronecker_delta"),
        "）なので、",
        math(String.raw`w \in \mathbb{C}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\bigl(w\,\omega\bigr)I
&= \Bigl(w\bigl(\left(2_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C}\right)0_{\mathbb C}\bigr)\Bigr)I
&&\bigl(\because\ \omega\text{ の定義と }\delta = 0_{\mathbb C}\bigr)\\
&= \bigl(w\,0_{\mathbb C}\bigr)I
&&\bigl(\because\ \blkref{complex_times_zero_is_zero}\bigr)\\
&= 0_{\mathbb C}\,I
&&\bigl(\because\ \blkref{complex_times_zero_is_zero}\bigr)\\
&= O
&&\bigl(\because\ \blkref{zero_scalar_multiple_is_zero_matrix}\bigr),\\[4pt]
\delta\,I
&= 0_{\mathbb C}\,I
&&(\because\ \delta = 0_{\mathbb C})\\
&= O
&&\bigl(\because\ \blkref{zero_scalar_multiple_is_zero_matrix}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "準備 4（",
        math(String.raw`\mathbb{C}`),
        " の符号と逆元の規則）。",
        math(String.raw`z, w \in \mathbb{C}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\text{(i)}\quad (-1_{\mathbb C})(-1_{\mathbb C})
= (-1_{\mathbb R}, 0_{\mathbb R})(-1_{\mathbb R}, 0_{\mathbb R})
&&\bigl(\because\ -1_{\mathbb C} = (-1_{\mathbb R})_{\mathbb C}\ (\blkref{inclusion_rr_to_cc})\bigr)\\
&\phantom{\text{(i)}\quad (-1_{\mathbb C})(-1_{\mathbb C})}
= \bigl((-1_{\mathbb R})(-1_{\mathbb R}) - 0_{\mathbb R}0_{\mathbb R},\ (-1_{\mathbb R})0_{\mathbb R} + 0_{\mathbb R}(-1_{\mathbb R})\bigr)
&&\bigl(\because\ \blkref{definition_of_cc}\text{ の積}\bigr)\\
&\phantom{\text{(i)}\quad (-1_{\mathbb C})(-1_{\mathbb C})}
= (1_{\mathbb R}, 0_{\mathbb R})
&&(\because\ \mathbb{R}\text{ の四則})\\
&\phantom{\text{(i)}\quad (-1_{\mathbb C})(-1_{\mathbb C})}
= 1_{\mathbb C}
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\bigr),\\[4pt]
&\text{(ii)}\quad z(-w)
= z\bigl((-1_{\mathbb C})w\bigr)
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&\phantom{\text{(ii)}\quad z(-w)}
= (-1_{\mathbb C})(zw)
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&\phantom{\text{(ii)}\quad z(-w)}
= -(zw)
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr),\\[4pt]
&\text{(iii)}\quad (-z)w
= \bigl((-1_{\mathbb C})z\bigr)w
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&\phantom{\text{(iii)}\quad (-z)w}
= (-1_{\mathbb C})(zw)
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&\phantom{\text{(iii)}\quad (-z)w}
= -(zw)
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr),\\[4pt]
&\text{(iv)}\quad -(-z)
= (-1_{\mathbb C})\bigl((-1_{\mathbb C})z\bigr)
&&\bigl(\because\ \blkref{multiply_by_minus_one}\text{ を 2 箇所へ同時適用}\bigr)\\
&\phantom{\text{(iv)}\quad -(-z)}
= \bigl((-1_{\mathbb C})(-1_{\mathbb C})\bigr)z
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&\phantom{\text{(iv)}\quad -(-z)}
= 1_{\mathbb C}\,z
&&(\because\ \text{(i)})\\
&\phantom{\text{(iv)}\quad -(-z)}
= z
&&\bigl(\because\ 1_{\mathbb C}\text{ は積の単位元。}\blkref{complex_numbers_form_a_field}\bigr),\\[4pt]
&\text{(v)}\quad (-z)(-w)
= -\bigl(z(-w)\bigr)
&&(\because\ \text{(iii)})\\
&\phantom{\text{(v)}\quad (-z)(-w)}
= -\bigl(-(zw)\bigr)
&&(\because\ \text{(ii)})\\
&\phantom{\text{(v)}\quad (-z)(-w)}
= zw
&&(\because\ \text{(iv)})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。さらに ",
        math(String.raw`z \neq 0_{\mathbb C}`),
        "、",
        math(String.raw`w \neq 0_{\mathbb C}`),
        " なら（逆元は ",
        ref("complex_numbers_form_a_field"),
        "）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\text{(vi)}\quad (zw)\bigl(z^{-1}w^{-1}\bigr)
= \bigl(zz^{-1}\bigr)\bigl(ww^{-1}\bigr)
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&\phantom{\text{(vi)}\quad (zw)\bigl(z^{-1}w^{-1}\bigr)}
= 1_{\mathbb C}1_{\mathbb C}
&&\bigl(\because\ \text{逆元を 2 箇所へ同時適用。}\blkref{complex_numbers_form_a_field}\bigr)\\
&\phantom{\text{(vi)}\quad (zw)\bigl(z^{-1}w^{-1}\bigr)}
= 1_{\mathbb C}
&&\bigl(\because\ 1_{\mathbb C}\text{ は積の単位元。}\blkref{complex_numbers_form_a_field}\bigr),\\[4pt]
&\text{(vii)}\quad (-z)\bigl(-(z^{-1})\bigr)
= zz^{-1}
&&(\because\ \text{(v)})\\
&\phantom{\text{(vii)}\quad (-z)\bigl(-(z^{-1})\bigr)}
= 1_{\mathbb C}
&&\bigl(\because\ \text{逆元。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`x \in \mathbb{C}`),
        " が ",
        math(String.raw`xy = 1_{\mathbb C}`),
        " となる ",
        math(String.raw`y \in \mathbb{C}`),
        " をもてば、",
        math(String.raw`x = 0_{\mathbb C}`),
        " とすると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
1_{\mathbb C}
&= x\,y
&&(\because\ xy = 1_{\mathbb C}\text{ を右辺から左辺へ})\\
&= 0_{\mathbb C}\,y
&&(\because\ x = 0_{\mathbb C})\\
&= 0_{\mathbb C}
&&\bigl(\because\ \blkref{complex_zero_times_is_zero}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "となり ",
        math(String.raw`1_{\mathbb C} \neq 0_{\mathbb C}`),
        "（",
        ref("complex_numbers_form_a_field"),
        "）に反するので ",
        math(String.raw`x \neq 0_{\mathbb C}`),
        " であり、逆元の一意性（",
        ref("complex_numbers_form_a_field"),
        "）より ",
        math(String.raw`x^{-1} = y`),
        " である。これを (vi)・(vii) に当てて、",
      ]),
      displayMath(
        String.raw`\text{(viii)}\quad zw \neq 0_{\mathbb C},\quad (zw)^{-1} = z^{-1}w^{-1},\qquad
\text{(ix)}\quad -z \neq 0_{\mathbb C},\quad (-z)^{-1} = -(z^{-1})`,
      ),
      paragraph([
        "を得る。",
      ]),
      paragraph([
        "準備 5（",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " の場合の係数）。このとき ",
        math(String.raw`\delta = 1_{\mathbb C}`),
        "（",
        ref("def_kronecker_delta"),
        "）であり、",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        " に絞ったので合同式を解く必要がない（",
        ref("def_check_index_set"),
        " (5)）。",
        math(String.raw`a_\mu = (x, y) \in \mathbb{C} = \mathbb{R}^2`),
        "（",
        math(String.raw`x, y \in \mathbb{R}`),
        "）と成分で書く。",
        math(String.raw`(-x)^2`),
        "・",
        math(String.raw`x^2`),
        "・",
        math(String.raw`y^2`),
        " は ",
        ref("def_power_of_real_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "）である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a_\nu
&= \gamma_2(\tilde\theta_{M_{\mathrm{col}}+1-\mu})
&&(\because\ a_\nu := \gamma_2(\tilde\theta_\nu),\ \nu = M_{\mathrm{col}}+1-\mu)\\
&= \gamma_2(-\tilde\theta_\mu)
&&\bigl(\because\ \blkref{periodicity_of_check_fermi}\ (3)\bigr)\\
&= b_\mu
&&(\because\ b_\mu\text{ の定義}),\\[4pt]
b_\nu
&= \gamma_2(-\tilde\theta_{M_{\mathrm{col}}+1-\mu})
&&(\because\ b_\nu := \gamma_2(-\tilde\theta_\nu),\ \nu = M_{\mathrm{col}}+1-\mu)\\
&= \gamma_2(\tilde\theta_\mu)
&&\bigl(\because\ \blkref{periodicity_of_check_fermi}\ (3)\bigr)\\
&= a_\mu
&&(\because\ a_\mu\text{ の定義}),\\[4pt]
r_\nu
&= |a_\nu|
&&(\because\ r_\nu\text{ の定義})\\
&= |b_\mu|
&&(\because\ \text{上の }a_\nu = b_\mu)\\
&= \left|-\overline{a_\mu}\right|
&&\bigl(\because\ \blkref{relation_of_gamma_2_theta_tilde}\ (1)\bigr)\\
&= \left|(-1_{\mathbb C})\,\overline{a_\mu}\right|
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= \left|(-1_{\mathbb C})\,(x, -y)\right|
&&\bigl(\because\ \blkref{def_complex_conjugate}\bigr)\\
&= \left|(-1_{\mathbb R}, 0_{\mathbb R})\,(x, -y)\right|
&&\bigl(\because\ -1_{\mathbb C} = (-1_{\mathbb R})_{\mathbb C} = (-1_{\mathbb R}, 0_{\mathbb R})\ (\blkref{inclusion_rr_to_cc})\bigr)\\
&= \left|(-x,\ y)\right|
&&\bigl(\because\ \blkref{definition_of_cc}\text{ の積：}\bigl((-1_{\mathbb R})x - 0_{\mathbb R}(-y),\ (-1_{\mathbb R})(-y) + 0_{\mathbb R}x\bigr) = (-x, y)\bigr)\\
&= \sqrt{(-x)^2 + y^2}^{(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{abs_basic_properties}\ (1)\bigr)\\
&= \sqrt{(-x)(-x) + y^2}^{(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to -x)\bigr)\\
&= \sqrt{x\,x + y^2}^{(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \mathbb{R}\ \text{の四則演算}\ (-a)(-b) = ab\ (a \to x,\ b \to x)\bigr)\\
&= \sqrt{x^2 + y^2}^{(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to x)\bigr)\\
&= |a_\mu|
&&\bigl(\because\ \blkref{abs_basic_properties}\ (1)\bigr)\\
&= r_\mu
&&(\because\ r_\mu\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "である。以下 ",
        math(String.raw`r := r_\mu = r_\nu \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`\rho := r_{\mathbb C} = \rho_\mu = \rho_\nu`),
        " と書く。",
        ref("relation_of_gamma_2_theta_tilde"),
        " (2) の等式の右辺は、実数 ",
        math(String.raw`-|a_\mu|^2`),
        " の包含の像 ",
        math(String.raw`(-|a_\mu|^2)_{\mathbb{C}}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
b_\mu b_\nu
&= b_\mu a_\mu
&&(\because\ \text{上の }b_\nu = a_\mu)\\
&= a_\mu b_\mu
&&\bigl(\because\ \mathbb{C}\text{ の積の交換律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl(-|a_\mu|^2\bigr)_{\mathbb C}
&&\bigl(\because\ \blkref{relation_of_gamma_2_theta_tilde}\ (2)\bigr)\\
&= \bigl(-r^2\bigr)_{\mathbb C}
&&(\because\ r\text{ と }r_\mu\text{ の定義：}r = r_\mu = |a_\mu|)\\
&= \bigl(-(r\,r)\bigr)_{\mathbb C}
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\bigr)\\
&= (-1_{\mathbb C})\,(r\,r)_{\mathbb C}
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\text{ と }\blkref{definition_of_cc}\text{ の積：}(-1_{\mathbb R}, 0_{\mathbb R})(rr, 0_{\mathbb R}) = (-(rr), 0_{\mathbb R})\bigr)\\
&= -\bigl((r\,r)_{\mathbb C}\bigr)
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= -(\rho\rho)
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\bigr),\\[4pt]
t\,t
&= (2_{\mathbb C}\sigma)(2_{\mathbb C}\sigma)
&&(\because\ t\text{ の定義})\\
&= (2_{\mathbb C}2_{\mathbb C})(\sigma\sigma)
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= (2_{\mathbb R}2_{\mathbb R})_{\mathbb C}\,(s\,s)_{\mathbb C}
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\text{ を 2 箇所へ同時適用}\bigr)\\
&= (4_{\mathbb R})_{\mathbb C}\,(s\,s)_{\mathbb C}
&&\bigl(\because\ \mathbb{R}\text{ で }2\cdot 2 = 4\bigr)\\
&= (4_{\mathbb R})_{\mathbb C}\,\bigl(s^2\bigr)_{\mathbb C}
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to s)\ \text{を右辺から左辺へ}\bigr)\\
&= (4_{\mathbb R})_{\mathbb C}\,\bigl((M_{\mathrm{col}})_{\mathbb R}\bigr)_{\mathbb C}
&&\bigl(\because\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ y^2 = x\ (x \to (M_{\mathrm{col}})_{\mathbb R} \in \mathbb{R}_{\ge 0})\bigr)\\
&= 4_{\mathbb C}\,(M_{\mathrm{col}})_{\mathbb C}
&&\bigl(\because\ 4_{\mathbb C} := (4_{\mathbb R})_{\mathbb C}\text{、}\blkref{antiperiodic_exp_sum}\text{ の像の記号}\bigr),\\[4pt]
d_\mu d_\nu
&= (t\,b_\mu)(t\,b_\nu)
&&(\because\ d_\lambda\text{ の定義を 2 箇所へ同時適用})\\
&= (t\,t)(b_\mu b_\nu)
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= (t\,t)\bigl(-(\rho\rho)\bigr)
&&(\because\ \text{上の }b_\mu b_\nu = -(\rho\rho))\\
&= -\bigl((t\,t)(\rho\rho)\bigr)
&&(\because\ \text{準備 4 (ii)})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`r \neq 0_{\mathbb R}`),
        " より ",
        math(String.raw`\rho = (r, 0_{\mathbb R}) \neq 0_{\mathbb C}`),
        "（",
        ref("inclusion_rr_to_cc"),
        "）、また ",
        math(String.raw`t \neq 0_{\mathbb C}`),
        " なので、準備 4 (viii) により ",
        math(String.raw`t\,t`),
        "、",
        math(String.raw`\rho\rho`),
        "、",
        math(String.raw`(t\,t)(\rho\rho)`),
        " は ",
        math(String.raw`0_{\mathbb C}`),
        " でなく、準備 4 (ix) により ",
        math(String.raw`-\bigl((t\,t)(\rho\rho)\bigr) \neq 0_{\mathbb C}`),
        " である。",
        math(String.raw`d_\mu^{-1}d_\nu^{-1}`),
        " を先に求める。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
d_\mu^{-1}d_\nu^{-1}
&= (d_\mu d_\nu)^{-1}
&&\bigl(\because\ \text{準備 4 (viii) を右辺から左辺へ}\bigr)\\
&= \Bigl(-\bigl((t\,t)(\rho\rho)\bigr)\Bigr)^{-1}
&&(\because\ \text{上の }d_\mu d_\nu = -((tt)(\rho\rho)))\\
&= -\Bigl(\bigl((t\,t)(\rho\rho)\bigr)^{-1}\Bigr)
&&\bigl(\because\ \text{準備 4 (ix)}\bigr)\\
&= -\bigl((t\,t)^{-1}(\rho\rho)^{-1}\bigr)
&&\bigl(\because\ \text{準備 4 (viii)}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "したがって三つの係数の組は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
u^{-}_\mu u^{-}_\nu
&= \bigl((-\rho)d_\mu^{-1}\bigr)\bigl((-\rho)d_\nu^{-1}\bigr)
&&(\because\ u^{-}_\lambda\text{ の定義と }\rho_\mu = \rho_\nu = \rho)\\
&= \bigl((-\rho)(-\rho)\bigr)\bigl(d_\mu^{-1}d_\nu^{-1}\bigr)
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= (\rho\rho)\bigl(d_\mu^{-1}d_\nu^{-1}\bigr)
&&(\because\ \text{準備 4 (v)})\\
&= (\rho\rho)\Bigl(-\bigl((t\,t)^{-1}(\rho\rho)^{-1}\bigr)\Bigr)
&&(\because\ \text{上の }d_\mu^{-1}d_\nu^{-1}\text{ の鎖})\\
&= -\Bigl((\rho\rho)\bigl((t\,t)^{-1}(\rho\rho)^{-1}\bigr)\Bigr)
&&(\because\ \text{準備 4 (ii)})\\
&= -\Bigl((t\,t)^{-1}\bigl((\rho\rho)(\rho\rho)^{-1}\bigr)\Bigr)
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= -\bigl((t\,t)^{-1}1_{\mathbb C}\bigr)
&&\bigl(\because\ \text{逆元。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= -\bigl((t\,t)^{-1}\bigr)
&&\bigl(\because\ 1_{\mathbb C}\text{ は積の単位元。}\blkref{complex_numbers_form_a_field}\bigr),\\[4pt]
u^{+}_\mu u^{+}_\nu
&= \bigl(\rho\,d_\mu^{-1}\bigr)\bigl(\rho\,d_\nu^{-1}\bigr)
&&(\because\ u^{+}_\lambda\text{ の定義と }\rho_\mu = \rho_\nu = \rho)\\
&= (\rho\rho)\bigl(d_\mu^{-1}d_\nu^{-1}\bigr)
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= (\rho\rho)\Bigl(-\bigl((t\,t)^{-1}(\rho\rho)^{-1}\bigr)\Bigr)
&&(\because\ \text{上の }d_\mu^{-1}d_\nu^{-1}\text{ の鎖})\\
&= -\Bigl((\rho\rho)\bigl((t\,t)^{-1}(\rho\rho)^{-1}\bigr)\Bigr)
&&(\because\ \text{準備 4 (ii)})\\
&= -\Bigl((t\,t)^{-1}\bigl((\rho\rho)(\rho\rho)^{-1}\bigr)\Bigr)
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= -\bigl((t\,t)^{-1}1_{\mathbb C}\bigr)
&&\bigl(\because\ \text{逆元。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= -\bigl((t\,t)^{-1}\bigr)
&&\bigl(\because\ 1_{\mathbb C}\text{ は積の単位元。}\blkref{complex_numbers_form_a_field}\bigr),\\[4pt]
u^{-}_\mu u^{+}_\nu
&= \bigl((-\rho)d_\mu^{-1}\bigr)\bigl(\rho\,d_\nu^{-1}\bigr)
&&(\because\ u^{\mp}_\lambda\text{ の定義と }\rho_\mu = \rho_\nu = \rho)\\
&= \bigl((-\rho)\rho\bigr)\bigl(d_\mu^{-1}d_\nu^{-1}\bigr)
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl(-(\rho\rho)\bigr)\bigl(d_\mu^{-1}d_\nu^{-1}\bigr)
&&(\because\ \text{準備 4 (iii)})\\
&= -\bigl((\rho\rho)(d_\mu^{-1}d_\nu^{-1})\bigr)
&&(\because\ \text{準備 4 (iii)})\\
&= -\Bigl(-\bigl((t\,t)^{-1}\bigr)\Bigr)
&&\bigl(\because\ u^{+}_\mu u^{+}_\nu\text{ の鎖の第 2 行から最後の行までの等号 }(\rho\rho)(d_\mu^{-1}d_\nu^{-1}) = -((tt)^{-1})\bigr)\\
&= (t\,t)^{-1}
&&(\because\ \text{準備 4 (iv)}),\\[4pt]
h\,h
&= \bigl(1_{\mathbb C}t^{-1}\bigr)\bigl(1_{\mathbb C}t^{-1}\bigr)
&&(\because\ h\text{ の定義})\\
&= t^{-1}t^{-1}
&&\bigl(\because\ 1_{\mathbb C}\text{ は積の単位元を 2 箇所へ同時適用}\bigr)\\
&= (t\,t)^{-1}
&&\bigl(\because\ \text{準備 4 (viii) を右辺から左辺へ}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "であり、これらから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
u^{-}_\mu u^{-}_\nu + h\,h
&= -\bigl((t\,t)^{-1}\bigr) + (t\,t)^{-1}
&&(\because\ \text{上の二つの鎖})\\
&= 0_{\mathbb C}
&&\bigl(\because\ \text{加法の逆元。}\blkref{complex_numbers_form_a_field}\bigr),\\[4pt]
u^{+}_\mu u^{+}_\nu + h\,h
&= -\bigl((t\,t)^{-1}\bigr) + (t\,t)^{-1}
&&(\because\ \text{上の二つの鎖})\\
&= 0_{\mathbb C}
&&\bigl(\because\ \text{加法の逆元。}\blkref{complex_numbers_form_a_field}\bigr),\\[4pt]
\bigl(u^{-}_\mu u^{+}_\nu + h\,h\bigr)\,\omega
&= \bigl((t\,t)^{-1} + (t\,t)^{-1}\bigr)\,\omega
&&(\because\ \text{上の二つの鎖})\\
&= \bigl(1_{\mathbb C}(t\,t)^{-1} + 1_{\mathbb C}(t\,t)^{-1}\bigr)\,\omega
&&\bigl(\because\ 1_{\mathbb C}\text{ は積の単位元を 2 箇所へ同時適用。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl((1_{\mathbb C} + 1_{\mathbb C})(t\,t)^{-1}\bigr)\,\omega
&&\bigl(\because\ \mathbb{C}\text{ の分配法則。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \bigl(2_{\mathbb C}(t\,t)^{-1}\bigr)\,\omega
&&\bigl(\because\ 1_{\mathbb C} + 1_{\mathbb C} = (1_{\mathbb R} + 1_{\mathbb R}, 0_{\mathbb R}) = 2_{\mathbb C}\ (\blkref{definition_of_cc}\text{ の和})\bigr)\\
&= \bigl(2_{\mathbb C}(t\,t)^{-1}\bigr)\Bigl(\bigl(2_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C}\bigr)1_{\mathbb C}\Bigr)
&&(\because\ \omega\text{ の定義と }\delta = 1_{\mathbb C})\\
&= \bigl(2_{\mathbb C}(t\,t)^{-1}\bigr)\bigl(2_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C}\bigr)
&&\bigl(\because\ 1_{\mathbb C}\text{ は積の単位元。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \Bigl((2_{\mathbb C}2_{\mathbb C})(M_{\mathrm{col}})_{\mathbb C}\Bigr)(t\,t)^{-1}
&&\bigl(\because\ \mathbb{C}\text{ の積の結合律と交換律。}\blkref{complex_numbers_form_a_field}\bigr)\\
&= \Bigl((2_{\mathbb R}2_{\mathbb R})_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C}\Bigr)(t\,t)^{-1}
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\bigr)\\
&= \Bigl(4_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C}\Bigr)(t\,t)^{-1}
&&\bigl(\because\ \mathbb{R}\text{ で }2\cdot 2 = 4\text{。}4_{\mathbb C} := (4_{\mathbb R})_{\mathbb C}\bigr)\\
&= (t\,t)(t\,t)^{-1}
&&(\because\ \text{上の }t\,t = 4_{\mathbb C}(M_{\mathrm{col}})_{\mathbb C})\\
&= 1_{\mathbb C}
&&\bigl(\because\ \text{逆元。}\blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "を得る。",
      ]),
      paragraph([
        "第 1 式。主張の左辺から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\mu^\dagger, \check\psi_\nu^\dagger\right]_+
&= \left[u^{-}_\mu\check{Z}_\mu + h\check{Y}_\mu,\ u^{-}_\nu\check{Z}_\nu + h\check{Y}_\nu\right]_+
&&\bigl(\because\ \blkref{def_check_fermi}\text{ を 2 箇所へ同時適用}\bigr)\\
&= \bigl((u^{-}_\mu u^{-}_\nu + h\,h)\,\omega\bigr)I
&&(\because\ \text{準備 2 を }u = u^{-}_\mu,\ u' = u^{-}_\nu\text{ で})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`\nu \neq M_{\mathrm{col}}+1-\mu`),
        " のとき",
      ]),
      displayMath(
        String.raw`\bigl((u^{-}_\mu u^{-}_\nu + h\,h)\,\omega\bigr)I = O
\quad (\because\ \text{準備 3 を }w = u^{-}_\mu u^{-}_\nu + hh\text{ で})`,
      ),
      paragraph([
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\bigl((u^{-}_\mu u^{-}_\nu + h\,h)\,\omega\bigr)I
&= \bigl(0_{\mathbb C}\,\omega\bigr)I
&&(\because\ \text{準備 5 の }u^{-}_\mu u^{-}_\nu + hh = 0_{\mathbb C})\\
&= 0_{\mathbb C}\,I
&&\bigl(\because\ \blkref{complex_zero_times_is_zero}\bigr)\\
&= O
&&\bigl(\because\ \blkref{zero_scalar_multiple_is_zero_matrix}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "である。どちらの場合も主張の右辺 ",
        math(String.raw`O`),
        " に着く。",
      ]),
      paragraph([
        "第 3 式。主張の左辺から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\mu, \check\psi_\nu\right]_+
&= \left[u^{+}_\mu\check{Z}_\mu + h\check{Y}_\mu,\ u^{+}_\nu\check{Z}_\nu + h\check{Y}_\nu\right]_+
&&\bigl(\because\ \blkref{def_check_fermi}\text{ を 2 箇所へ同時適用}\bigr)\\
&= \bigl((u^{+}_\mu u^{+}_\nu + h\,h)\,\omega\bigr)I
&&(\because\ \text{準備 2 を }u = u^{+}_\mu,\ u' = u^{+}_\nu\text{ で})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`\nu \neq M_{\mathrm{col}}+1-\mu`),
        " のとき",
      ]),
      displayMath(
        String.raw`\bigl((u^{+}_\mu u^{+}_\nu + h\,h)\,\omega\bigr)I = O
\quad (\because\ \text{準備 3 を }w = u^{+}_\mu u^{+}_\nu + hh\text{ で})`,
      ),
      paragraph([
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\bigl((u^{+}_\mu u^{+}_\nu + h\,h)\,\omega\bigr)I
&= \bigl(0_{\mathbb C}\,\omega\bigr)I
&&(\because\ \text{準備 5 の }u^{+}_\mu u^{+}_\nu + hh = 0_{\mathbb C})\\
&= 0_{\mathbb C}\,I
&&\bigl(\because\ \blkref{complex_zero_times_is_zero}\bigr)\\
&= O
&&\bigl(\because\ \blkref{zero_scalar_multiple_is_zero_matrix}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "である。どちらの場合も主張の右辺 ",
        math(String.raw`O`),
        " に着く。",
      ]),
      paragraph([
        "第 2 式。主張の左辺から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check\psi_\mu^\dagger, \check\psi_\nu\right]_+
&= \left[u^{-}_\mu\check{Z}_\mu + h\check{Y}_\mu,\ u^{+}_\nu\check{Z}_\nu + h\check{Y}_\nu\right]_+
&&\bigl(\because\ \blkref{def_check_fermi}\text{ を 2 箇所へ同時適用}\bigr)\\
&= \bigl((u^{-}_\mu u^{+}_\nu + h\,h)\,\omega\bigr)I
&&(\because\ \text{準備 2 を }u = u^{-}_\mu,\ u' = u^{+}_\nu\text{ で})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`\nu \neq M_{\mathrm{col}}+1-\mu`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\bigl((u^{-}_\mu u^{+}_\nu + h\,h)\,\omega\bigr)I
&= O
&&(\because\ \text{準備 3 を }w = u^{-}_\mu u^{+}_\nu + hh\text{ で})\\
&= \delta\,I
&&(\because\ \text{準備 3 の }\delta I = O\text{ を右辺から左辺へ})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\bigl((u^{-}_\mu u^{+}_\nu + h\,h)\,\omega\bigr)I
&= 1_{\mathbb C}\,I
&&(\because\ \text{準備 5 の }(u^{-}_\mu u^{+}_\nu + hh)\,\omega = 1_{\mathbb C})\\
&= \delta\,I
&&(\because\ \delta = 1_{\mathbb C})
\end{aligned}`,
      ),
      paragraph([
        "である。どちらの場合も主張の右辺 ",
        math(String.raw`\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I = \delta\,I`),
        " に一致する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の anticommutator_of_psi の半整数運動量版。008 章が Step 0（√ の分枝の一致）に費やしていた部分は、" +
          "係数が |γ_2|（非負実数）で書かれることにより絶対値の計算 1 行に置き換わった。",
        "数値検証: sagemath/check/anticommutator_of_check_psi/（証明の各行。厳密計算）。旧い sagemath/check/049_claim_even_sector_fermions/check_02 は主張だけを浮動小数点で確かめたもの。",
        "2026-08-19 の式変形統一で、行末根拠の機械識別子と「直前の displayMath」という指し方を人間可読な名前へ直し、" +
          "一行二等号（a_ν・b_ν の鎖と Step 4 の末尾）を一操作ずつに分け、根拠の無かった行（r_ν = r_μ、可換則、負号の移動、同類項の統合、約分）に行末根拠を補い、" +
          "散文に畳まれていた反交換子の双線型性の計算を鎖へ開いた。内容と参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-03（全証明の SageMath 検算）: 証明を書き直した。散文の「和についての加法性も分配法則から従う」を anticommutator_of_finite_sums_of_scalar_multiples による係数を残した展開（準備 2）に、反交換子の対称性を def_matrix_anticommutator と matrix_sum_is_commutative の鎖（準備 1）に、δ = 0 の場合の散文を準備 3 の鎖に、abs_basic_properties が述べていない |−z| = |z|・|z̄| = |z| を def_complex_conjugate と definition_of_cc の積・abs_basic_properties (1) の成分の鎖に、ℂ の符号と逆元の規則を準備 4 の鎖にした。係数を u^∓_λ := (∓ρ_λ)d_λ^{-1}、h := 1_C t^{-1} と置き（def_check_fermi の √M_col・r・2 を包含の像 σ・ρ・2_C で読む）、ℝ への脱出（ℝ_{≥0} の平方根 s・r）を明示した。主張の I と O を Mat(2^{(M_col)_ℕ},ℂ) の元と書いた（中身は不変）。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 準備 5 の二乗をその場の |a_μ|^2 := |a_μ||a_μ|・s^2 := ss から def_power_of_real_number の冪（m = 2）に替えた（記号の濫用の解消）。b_μ b_ν の鎖は r = |a_μ| の行と square_of_real_number_is_product の行に割り（7 行 → 8 行）、t t の鎖は ss = s^2 を square_of_real_number_is_product で引く行と definition_of_sqrt_r_positive の y^2 = x の行に割った（6 行 → 7 行）。準備の s の性質も s^2 = (M_col)_ℝ と書いた。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 準備 5 の r_ν の鎖の「ℝ で (−x)^2 = x^2」を、積へ開く行（square_of_real_number_is_product (r → −x)）・ℝ の四則演算 (−a)(−b) = ab の行・冪へ戻す行（square_of_real_number_is_product (r → x)）の 3 行に割った（11 行 → 13 行）。Lean は checkR_conj（DefinitionCheckFermi.lean）を同じ 13 行の calc にした。",
      ],
    },
  },
  {
    id: "evenfermi_004_claim_commutation_V_plus_psi",
    kind: "claim",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 6 },
    title: { tex: String.raw`V^{(+)} \text{ と } \check\psi \text{ の交換関係}` },
    labels: ["commutation_V_plus_check_psi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`T_{(V^{(+)})}\!\left(\check\psi_\mu^\dagger\right) = \left(\exp(+\gamma(\tilde\theta_\mu))\right)_{\mathbb{C}}\check\psi_\mu^\dagger,
\qquad
T_{(V^{(+)})}\!\left(\check\psi_\mu\right) = \left(\exp(-\gamma(\tilde\theta_\mu))\right)_{\mathbb{C}}\check\psi_\mu`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`T_{(V^{(+)})}`),
        " は ",
        ref("def_T_V_plus"),
        "、",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        " は ",
        ref("def_gamma_theta"),
        "、exp は実数の exp で、",
        math(String.raw`(\cdot)_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の像。右辺は ",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍）。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取った ",
        math(String.raw`R := \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と ",
        math(String.raw`R^\times`),
        " を用い、",
        math(String.raw`T := T_{(V^{(+)})} : R \to R`),
        " と書く。組 ",
        math(String.raw`(Y_1, Y_2) \in R \times R`),
        " と ",
        math(String.raw`l \in \{1, 2\}`),
        " について ",
        math(String.raw`\mathrm{pr}_l(Y_1, Y_2) := Y_l`),
        " と書く。",
        math(String.raw`G, H \in \mathrm{Mat}(2,\mathbb{C})`),
        " の成分を ",
        math(String.raw`g_{kl} := G_{kl}`),
        "、",
        math(String.raw`h_{kl} := H_{kl}`),
        "（",
        math(String.raw`k, l \in \{1,2\}`),
        "）と書く。組と ",
        math(String.raw`2\times 2`),
        " 行列の積は ",
        ref("def_pair_of_matrices_times_two_by_two_matrix"),
        "、組と数の列の積は ",
        ref("def_pair_of_matrices_times_column_of_numbers"),
        "、",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の積は ",
        ref("mat_mult"),
        "、有限和は ",
        ref("def_finite_sum_of_matrices"),
        " と ",
        ref("def_finite_sum_of_complex_numbers"),
        " による。",
      ]),
      paragraph([
        "準備 1（組と ",
        math(String.raw`2\times 2`),
        " 行列の積の成分）。",
        math(String.raw`X_1, X_2 \in R`),
        "、",
        math(String.raw`G \in \mathrm{Mat}(2,\mathbb{C})`),
        "、",
        math(String.raw`l \in \{1,2\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{pr}_l\!\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}G\right)
&= \mathrm{pr}_l\!\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}\begin{pmatrix}g_{11} \\ g_{21}\end{pmatrix},\
   \begin{pmatrix}X_1, & X_2\end{pmatrix}\begin{pmatrix}g_{12} \\ g_{22}\end{pmatrix}\right)
&&\bigl(\because\ \blkref{def_pair_of_matrices_times_two_by_two_matrix}\ (d \to 2^{M_{\mathrm{col}}},\ A \to X_1,\ B \to X_2,\ p, q, r, s \to g_{11}, g_{12}, g_{21}, g_{22})\bigr)\\
&= \begin{pmatrix}X_1, & X_2\end{pmatrix}\begin{pmatrix}g_{1l} \\ g_{2l}\end{pmatrix}
&&\bigl(\because\ \mathrm{pr}_l\text{ の定め方}\bigr)\\
&= g_{1l}X_1 + g_{2l}X_2
&&\bigl(\because\ \blkref{def_pair_of_matrices_times_column_of_numbers}\bigr)\\
&= \Bigl(\sum_{i=1}^{1} g_{il}X_i\Bigr) + g_{2l}X_2
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\text{ の }r = 1\text{ の式}\bigr)\\
&= \sum_{i=1}^{2} g_{il}X_i
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\text{ の }r+1\text{ の式}\ (r \to 1)\bigr)
\end{aligned}`),
      paragraph([
        "準備 2（結合律）。",
        math(String.raw`X_1, X_2 \in R`),
        "、",
        math(String.raw`G, H \in \mathrm{Mat}(2,\mathbb{C})`),
        "、",
        math(String.raw`l \in \{1,2\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{pr}_l\!\left(\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}G\right)H\right)
&= \sum_{k=1}^{2} h_{kl}\,\mathrm{pr}_k\!\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}G\right)
&&\bigl(\because\ \text{準備 1}\ \bigl(X_k \to \mathrm{pr}_k((X_1, X_2)G),\ G \to H\bigr)\bigr)\\
&= \sum_{k=1}^{2} h_{kl}\Bigl(\sum_{i=1}^{2} g_{ik}X_i\Bigr)
&&\bigl(\because\ \text{準備 1 を }k = 1, 2\text{ の 2 か所へ同時適用}\bigr)\\
&= \sum_{k=1}^{2} \sum_{i=1}^{2} h_{kl}\left(g_{ik}X_i\right)
&&\bigl(\because\ \blkref{finite_sum_of_scalar_multiples}\text{ を右辺から左辺へ、}k = 1, 2\text{ の 2 か所へ同時適用}\bigr)\\
&= \sum_{k=1}^{2} \sum_{i=1}^{2} \left(h_{kl}g_{ik}\right)X_i
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\text{ を 4 か所へ同時適用}\bigr)\\
&= \sum_{i=1}^{2} \sum_{k=1}^{2} \left(h_{kl}g_{ik}\right)X_i
&&\bigl(\because\ \blkref{finite_double_sum_of_matrices_interchange}\bigr)\\
&= \sum_{i=1}^{2} \Bigl(\sum_{k=1}^{2} h_{kl}g_{ik}\Bigr)X_i
&&\bigl(\because\ \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\text{ を }i = 1, 2\text{ の 2 か所へ同時適用}\bigr)\\
&= \sum_{i=1}^{2} \Bigl(\sum_{k=1}^{2} g_{ik}h_{kl}\Bigr)X_i
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の乗法の可換則を 4 か所へ同時適用}\bigr)\\
&= \sum_{i=1}^{2} (GH)_{il}\,X_i
&&\bigl(\because\ \blkref{mat_mult}\text{ を }i = 1, 2\text{ の 2 か所へ同時適用}\bigr)\\
&= \mathrm{pr}_l\!\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}\left(GH\right)\right)
&&\bigl(\because\ \text{準備 1 を右辺から左辺へ}\ (G \to GH)\bigr)
\end{aligned}`),
      paragraph(["であり、組は二つの成分で定まるので"]),
      displayMath(String.raw`\begin{aligned}
\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}G\right)H
&= \left(\mathrm{pr}_1\!\left(\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}G\right)H\right),\
   \mathrm{pr}_2\!\left(\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}G\right)H\right)\right)
&&\bigl(\because\ \mathrm{pr}_1, \mathrm{pr}_2\text{ の定め方}\bigr)\\
&= \left(\mathrm{pr}_1\!\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}\left(GH\right)\right),\
   \mathrm{pr}_2\!\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}\left(GH\right)\right)\right)
&&\bigl(\because\ \text{上の鎖を }l = 1, 2\text{ の 2 か所へ同時適用}\bigr)\\
&= \begin{pmatrix}X_1, & X_2\end{pmatrix}\left(GH\right)
&&\bigl(\because\ \mathrm{pr}_1, \mathrm{pr}_2\text{ の定め方}\bigr)
\end{aligned}`),
      paragraph([
        "準備 3（",
        math(String.raw`T`),
        " を組へ当てる）。",
        ref("V_plus_factors_invertible"),
        " により ",
        math(String.raw`V^{(+)} \in R^\times`),
        "、",
        ref("T_V_plus_is_conjugation"),
        " により写像として ",
        math(String.raw`T = T_{V^{(+)}}`),
        " である。",
        math(String.raw`X_1, X_2 \in R`),
        "、",
        math(String.raw`G \in \mathrm{Mat}(2,\mathbb{C})`),
        "、",
        math(String.raw`l \in \{1,2\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
T\!\left(\mathrm{pr}_l\!\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}G\right)\right)
&= T\!\left(g_{1l}X_1 + g_{2l}X_2\right)
&&\bigl(\because\ \text{準備 1 の第 1 式から第 4 式まで}\bigr)\\
&= T_{V^{(+)}}\!\left(g_{1l}X_1 + g_{2l}X_2\right)
&&\bigl(\because\ \blkref{T_V_plus_is_conjugation}\bigr)\\
&= g_{1l}\,T_{V^{(+)}}(X_1) + g_{2l}\,T_{V^{(+)}}(X_2)
&&\bigl(\because\ \blkref{linearity_of_T}\ (M \to M_{\mathrm{col}},\ g \to V^{(+)},\ a \to g_{1l},\ b \to g_{2l},\ X \to X_1,\ W \to X_2)\bigr)\\
&= g_{1l}\,T(X_1) + g_{2l}\,T(X_2)
&&\bigl(\because\ \blkref{T_V_plus_is_conjugation}\text{ を 2 か所へ同時適用}\bigr)\\
&= \mathrm{pr}_l\!\left(\begin{pmatrix}T(X_1), & T(X_2)\end{pmatrix}G\right)
&&\bigl(\because\ \text{準備 1 の第 1 式から第 4 式までを右辺から左辺へ}\ (X_i \to T(X_i))\bigr)
\end{aligned}`),
      paragraph(["であり、組は二つの成分で定まるので"]),
      displayMath(String.raw`\begin{aligned}
\left(T\!\left(\mathrm{pr}_1\!\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}G\right)\right),\
T\!\left(\mathrm{pr}_2\!\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}G\right)\right)\right)
&= \left(\mathrm{pr}_1\!\left(\begin{pmatrix}T(X_1), & T(X_2)\end{pmatrix}G\right),\
   \mathrm{pr}_2\!\left(\begin{pmatrix}T(X_1), & T(X_2)\end{pmatrix}G\right)\right)
&&\bigl(\because\ \text{上の鎖を }l = 1, 2\text{ の 2 か所へ同時適用}\bigr)\\
&= \begin{pmatrix}T(X_1), & T(X_2)\end{pmatrix}G
&&\bigl(\because\ \mathrm{pr}_1, \mathrm{pr}_2\text{ の定め方}\bigr)
\end{aligned}`),
      paragraph([
        "準備 4（",
        ref("diagonalization_check_P_D"),
        " の記号の読み方）。",
        math(String.raw`\check{P}_\mu^{-1}`),
        " は ",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`1`),
        " に取ったときの逆元（",
        math(String.raw`\mathrm{Mat}(2^1,\mathbb{C}) = \mathrm{Mat}(2,\mathbb{C})`),
        "）で、",
        math(String.raw`\check{P}_\mu^{-1}\check{P}_\mu = I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " を満たす。三つの積 ",
        math(String.raw`\check{P}_\mu\check{D}_\mu\check{P}_\mu^{-1}`),
        " は ",
        math(String.raw`(\check{P}_\mu\check{D}_\mu)\check{P}_\mu^{-1}`),
        " と読む（",
        ref("diagonalization_check_P_D"),
        " の証明の Step 4 の鎖の第 4 式）。",
        math(String.raw`\check{D}_\mu`),
        " の実数の成分 ",
        math(String.raw`\lambda_{\pm,\mu} \in \mathbb{R}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の像 ",
        math(String.raw`(\lambda_{\pm,\mu})_{\mathbb{C}}`),
        " と読む。すなわち ",
        math(String.raw`(\check{D}_\mu)_{11} = (\lambda_{+,\mu})_{\mathbb{C}}`),
        "、",
        math(String.raw`(\check{D}_\mu)_{21} = (\check{D}_\mu)_{12} = 0_{\mathbb{C}}`),
        "、",
        math(String.raw`(\check{D}_\mu)_{22} = (\lambda_{-,\mu})_{\mathbb{C}}`),
        " である（",
        ref("diagonalization_check_P_D"),
        " が非対角に書いた 0 は ",
        math(String.raw`0_{\mathbb{C}}`),
        " と読む）。以下の ",
        math(String.raw`O`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列 ",
        math(String.raw`O \in R`),
        " である。",
      ]),
      paragraph([
        "本体。",
        ref("def_check_fermi"),
        " の ",
        math(String.raw`\left(\check\psi_\mu^\dagger, \check\psi_\mu\right) := \left(\check{Z}_\mu, \check{Y}_\mu\right)\check{P}_\mu`),
        " から ",
        math(String.raw`\check\psi_\mu^\dagger = \mathrm{pr}_1\!\left((\check{Z}_\mu, \check{Y}_\mu)\check{P}_\mu\right)`),
        "、",
        math(String.raw`\check\psi_\mu = \mathrm{pr}_2\!\left((\check{Z}_\mu, \check{Y}_\mu)\check{P}_\mu\right)`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\begin{pmatrix}T(\check\psi_\mu^\dagger), & T(\check\psi_\mu)\end{pmatrix}
&= \left(T\!\left(\mathrm{pr}_1\!\left(\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu\right)\right),\
   T\!\left(\mathrm{pr}_2\!\left(\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu\right)\right)\right)
&&\bigl(\because\ \blkref{def_check_fermi}\bigr)\\
&= \begin{pmatrix}T(\check{Z}_\mu), & T(\check{Y}_\mu)\end{pmatrix}\check{P}_\mu
&&\bigl(\because\ \text{準備 3}\ (X_1 \to \check{Z}_\mu,\ X_2 \to \check{Y}_\mu,\ G \to \check{P}_\mu)\bigr)\\
&= \left(\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}A(\tilde\theta_\mu)\right)\check{P}_\mu
&&\bigl(\because\ \blkref{T_V_plus_check_Z_Y}\bigr)\\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\left(A(\tilde\theta_\mu)\check{P}_\mu\right)
&&\bigl(\because\ \text{準備 2}\ (G \to A(\tilde\theta_\mu),\ H \to \check{P}_\mu)\bigr)\\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \left(\left(\left(\check{P}_\mu\check{D}_\mu\right)\check{P}_\mu^{-1}\right)\check{P}_\mu\right)
&&\bigl(\because\ \blkref{diagonalization_check_P_D}\text{ と準備 4}\bigr)\\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \left(\left(\check{P}_\mu\check{D}_\mu\right)\left(\check{P}_\mu^{-1}\check{P}_\mu\right)\right)
&&\bigl(\because\ \blkref{mat_mult_associative}\ (m, n, p, q \to 2)\bigr)\\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \left(\left(\check{P}_\mu\check{D}_\mu\right)I_{\mathrm{Mat}(2,\mathbb{C})}\right)
&&\bigl(\because\ \blkref{def_invertible_elements_of_R}\ (M \to 1)\text{ と準備 4}\bigr)\\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\left(\check{P}_\mu\check{D}_\mu\right)
&&\bigl(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\ (m, n \to 2)\bigr)\\
&= \left(\begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu\right)\check{D}_\mu
&&\bigl(\because\ \text{準備 2}\ (G \to \check{P}_\mu,\ H \to \check{D}_\mu)\text{ を右辺から左辺へ}\bigr)\\
&= \begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix}\check{D}_\mu
&&\bigl(\because\ \blkref{def_check_fermi}\bigr)\\
&= \left(\mathrm{pr}_1\!\left(\begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix}\check{D}_\mu\right),\
   \mathrm{pr}_2\!\left(\begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix}\check{D}_\mu\right)\right)
&&\bigl(\because\ \mathrm{pr}_1, \mathrm{pr}_2\text{ の定め方}\bigr)\\
&= \left((\check{D}_\mu)_{11}\check\psi_\mu^\dagger + (\check{D}_\mu)_{21}\check\psi_\mu,\
   (\check{D}_\mu)_{12}\check\psi_\mu^\dagger + (\check{D}_\mu)_{22}\check\psi_\mu\right)
&&\bigl(\because\ \text{準備 1 の第 1 式から第 4 式までを }l = 1, 2\text{ の 2 か所へ同時適用}\ (X_1 \to \check\psi_\mu^\dagger,\ X_2 \to \check\psi_\mu,\ G \to \check{D}_\mu)\bigr)\\
&= \left((\lambda_{+,\mu})_{\mathbb{C}}\check\psi_\mu^\dagger + 0_{\mathbb{C}}\check\psi_\mu,\
   0_{\mathbb{C}}\check\psi_\mu^\dagger + (\lambda_{-,\mu})_{\mathbb{C}}\check\psi_\mu\right)
&&\bigl(\because\ \blkref{diagonalization_check_P_D}\text{ の }\check{D}_\mu\text{ と準備 4}\bigr)\\
&= \left((\lambda_{+,\mu})_{\mathbb{C}}\check\psi_\mu^\dagger + O,\
   O + (\lambda_{-,\mu})_{\mathbb{C}}\check\psi_\mu\right)
&&\bigl(\because\ \blkref{zero_scalar_multiple_is_zero_matrix}\ (m, n \to 2^{M_{\mathrm{col}}})\text{ を 2 か所へ同時適用}\bigr)\\
&= \left((\lambda_{+,\mu})_{\mathbb{C}}\check\psi_\mu^\dagger,\
   O + (\lambda_{-,\mu})_{\mathbb{C}}\check\psi_\mu\right)
&&\bigl(\because\ \blkref{matrix_plus_zero_matrix}\ (m, n \to 2^{M_{\mathrm{col}}})\bigr)\\
&= \left((\lambda_{+,\mu})_{\mathbb{C}}\check\psi_\mu^\dagger,\
   (\lambda_{-,\mu})_{\mathbb{C}}\check\psi_\mu\right)
&&\bigl(\because\ \blkref{zero_matrix_plus_matrix}\ (m, n \to 2^{M_{\mathrm{col}}})\bigr)
\end{aligned}`),
      paragraph(["両辺の第 1 成分と第 2 成分を取り出して"]),
      displayMath(String.raw`\begin{aligned}
T(\check\psi_\mu^\dagger)
&= \mathrm{pr}_1\!\left(T(\check\psi_\mu^\dagger), T(\check\psi_\mu)\right)
&&\bigl(\because\ \mathrm{pr}_1\text{ の定め方}\bigr)\\
&= \mathrm{pr}_1\!\left((\lambda_{+,\mu})_{\mathbb{C}}\check\psi_\mu^\dagger,\ (\lambda_{-,\mu})_{\mathbb{C}}\check\psi_\mu\right)
&&\bigl(\because\ \text{本体の鎖}\bigr)\\
&= (\lambda_{+,\mu})_{\mathbb{C}}\check\psi_\mu^\dagger
&&\bigl(\because\ \mathrm{pr}_1\text{ の定め方}\bigr)\\
&= \left(\exp(+\gamma(\tilde\theta_\mu))\right)_{\mathbb{C}}\check\psi_\mu^\dagger
&&\bigl(\because\ \blkref{lambda_eq_exp_gamma_theta_tilde}\bigr),\\[4pt]
T(\check\psi_\mu)
&= \mathrm{pr}_2\!\left(T(\check\psi_\mu^\dagger), T(\check\psi_\mu)\right)
&&\bigl(\because\ \mathrm{pr}_2\text{ の定め方}\bigr)\\
&= \mathrm{pr}_2\!\left((\lambda_{+,\mu})_{\mathbb{C}}\check\psi_\mu^\dagger,\ (\lambda_{-,\mu})_{\mathbb{C}}\check\psi_\mu\right)
&&\bigl(\because\ \text{本体の鎖}\bigr)\\
&= (\lambda_{-,\mu})_{\mathbb{C}}\check\psi_\mu
&&\bigl(\because\ \mathrm{pr}_2\text{ の定め方}\bigr)\\
&= \left(\exp(-\gamma(\tilde\theta_\mu))\right)_{\mathbb{C}}\check\psi_\mu
&&\bigl(\because\ \blkref{lambda_eq_exp_gamma_theta_tilde}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " を使うのは ",
        math(String.raw`\lambda_{\pm,\mu}`),
        " と ",
        math(String.raw`\exp(\pm\gamma(\tilde\theta_\mu))`),
        " が実数であるところだけで（",
        math(String.raw`\gamma`),
        " は ",
        ref("def_gamma_theta"),
        " の arccosh、exp は実数の指数評価）、どちらも ",
        ref("inclusion_rr_to_cc"),
        " の像として ",
        math(String.raw`\mathbb{C}`),
        " のスカラー倍に入る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の commutation_V_psi の半整数運動量版。008 章は行ベクトル×行列の結合律を暗黙に使っていたが、" +
          "本章では行ベクトル×行列の積を def_pair_of_matrices_times_two_by_two_matrix（当時は calc_of_TxT_check_Z_Y の主張の中）の定義で入れているので、結合律を proof の冒頭で明示的に確かめた。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_03（V^{(+)} を行列指数関数から直接構成して共役を計算）。",
        "2026-08-19 の式変形統一で、行ベクトルへの線型作用の一行二等号を定義と線型性の三段へ分け、" +
          "転送行列作用の鎖の機械識別子を人間可読な根拠へ直し、末尾の二等号と固有値の指数表示への代入を各列の一続きの鎖へ開いた。内容と参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-03（全証明の SageMath 検算）: 証明を書き直した。冒頭の結合律の散文を、組と 2×2 行列の積の成分（準備 1）から finite_sum_of_scalar_multiples・scalar_multiple_is_associative・finite_double_sum_of_matrices_interchange・finite_sum_of_scalar_multiples_of_one_matrix・mat_mult を引く鎖（準備 2）に、定義の無い「行ベクトルへの作用の定め方」を使っていた Step 1 を、射影 pr_l で成分ごとに T_V_plus_is_conjugation・linearity_of_T を引く鎖（準備 3）に直した。P̌^{-1} を def_invertible_elements_of_R（M → 1）の逆元と、P̌ĎP̌^{-1} を (P̌Ď)P̌^{-1} と、Ď の実数の成分を包含の像と読むことを準備 4 に書き、本体の鎖の P̌^{-1}P̌ = I・単位行列・Ď の成分・零行列の行に根拠のラベルを付けた。主張の右辺の実数 exp(±γ(θ̃_μ)) を包含の像 (·)_C と書いた（中身は不変）。検算は sagemath/check/commutation_V_plus_check_psi/。",
      ],
    },
  },
  {
    id: "evenfermi_005_definition_check_Vprime",
    kind: "definition",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 7 },
    title: { tex: String.raw`\check{V}' \text{ の定義}` },
    labels: ["def_check_Vprime"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        math(String.raw`I := I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "（",
        ref("def_identity_matrix"),
        "）と書く。",
      ]),
      displayMath(
        String.raw`\check{X} := \sum_{\mu \in \check{\mathcal{M}}} \left(\gamma(\tilde\theta_\mu)\right)_{\mathbb{C}}
\left(\check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu} - \left(\tfrac12\right)_{\mathbb{C}} I\right)
\ \in\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}),
\qquad
\check{V}' := \exp\!\left(\check{X}\right)`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`\gamma(\tilde\theta_\mu) \in \mathbb{R}_{\geq 0}`),
        " は ",
        ref("def_gamma_theta"),
        "（実対数による arccosh で定まるので、ここで ",
        math(String.raw`\mathbb{R}`),
        " へ脱出する）、",
        math(String.raw`(\cdot)_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の像、",
        math(String.raw`\check\psi_\mu^\dagger, \check\psi_\mu`),
        " は ",
        ref("def_check_fermi"),
        "、スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、差は ",
        ref("def_matrix_difference"),
        "、和は ",
        ref("def_finite_sum_of_matrices"),
        "、",
        math(String.raw`\exp`),
        " は ",
        ref("def_exp"),
        " である。",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取った ",
        math(String.raw`R := \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を用いる。",
        ref("inclusion_rr_to_cc"),
        " の略記に従い、以降の本文はこの ",
        math(String.raw`\check{X}`),
        " を ",
        math(String.raw`\sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu} - \tfrac12 I\right)`),
        " とも書く（実数 ",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        "・",
        math(String.raw`\tfrac12`),
        " によるスカラー倍は、像 ",
        math(String.raw`(\cdot)_{\mathbb{C}}`),
        " によるスカラー倍を表す）。次が成り立つ。",
      ]),
      list([
        [
          "(1) **和の範囲に例外は要らない。** ",
          ref("def_check_index_set"),
          " (2) より ",
          math(String.raw`\mu \in \check{\mathcal{M}} \implies M_{\mathrm{col}}+1-\mu \in \check{\mathcal{M}}`),
          " なので、",
          ref("def_check_fermi"),
          " により ",
          math(String.raw`\check\psi_\mu^\dagger`),
          " と ",
          math(String.raw`\check\psi_{M_{\mathrm{col}}+1-\mu}`),
          " はともに定義されており、",
          math(String.raw`\mu \in \check{\mathcal{M}}`),
          " のすべての項が ",
          math(String.raw`R`),
          " の元である。したがって ",
          math(String.raw`\check{X} \in R`),
          "。",
        ],
        [
          "(2) ",
          math(String.raw`\check{V}' \in R^\times`),
          " であり ",
          math(String.raw`\left(\check{V}'\right)^{-1} = \exp(-\check{X})`),
          "（",
          math(String.raw`-\check{X}`),
          " は ",
          ref("def_matrix_negation"),
          "）。したがって ",
          ref("def_T_g"),
          "（",
          math(String.raw`M \to M_{\mathrm{col}}`),
          "）の ",
          math(String.raw`T_{(\check{V}')}(W) := \check{V}'\,W\,\left(\check{V}'\right)^{-1}`),
          " が定義される。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " を任意に取り、",
        math(String.raw`\nu := M_{\mathrm{col}}+1-\mu \in \mathbb{Z}`),
        " と置く。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\nu \in \check{\mathcal{M}}
   &&\bigl(\because\ \blkref{def_check_index_set}\ (2)\bigr) \\
&\check\psi_\mu^\dagger \in R
   &&\bigl(\because\ \blkref{def_check_fermi}\ (\mu \in \check{\mathcal{M}})\bigr) \\
&\check\psi_\nu \in R
   &&\bigl(\because\ \blkref{def_check_fermi}\ (\mu \to \nu.\ \nu \in \check{\mathcal{M}}\ \text{は 1 行目})\bigr) \\
&\check\psi_\mu^\dagger\,\check\psi_\nu \in R
   &&\bigl(\because\ \blkref{mat_mult}\ (2^{M_{\mathrm{col}}} \times 2^{M_{\mathrm{col}}}\ \text{と}\ 2^{M_{\mathrm{col}}} \times 2^{M_{\mathrm{col}}}\ \text{の積})\bigr) \\
&I \in R
   &&\bigl(\because\ \blkref{def_identity_matrix}\bigr) \\
&\left(\tfrac12\right)_{\mathbb{C}} \in \mathbb{C}
   &&\bigl(\because\ \blkref{inclusion_rr_to_cc}\ (\tfrac12 \in \mathbb{R}\ \text{は}\ \mathbb{R}\ \text{における}\ 2\ \text{の逆元})\bigr) \\
&\left(\tfrac12\right)_{\mathbb{C}} I \in R
   &&\bigl(\because\ \blkref{def_matrix_scalar_multiple}\bigr) \\
&\check\psi_\mu^\dagger\,\check\psi_\nu - \left(\tfrac12\right)_{\mathbb{C}} I \in R
   &&\bigl(\because\ \blkref{def_matrix_difference}\bigr) \\
&\gamma(\tilde\theta_\mu) \in \mathbb{R}_{\geq 0}
   &&\bigl(\because\ \blkref{def_gamma_theta}\ (\theta \to \tilde\theta_\mu).\ \text{実対数の}\ \mathrm{arccosh}\ \text{で}\ \mathbb{R}\ \text{へ脱出}\bigr) \\
&\left(\gamma(\tilde\theta_\mu)\right)_{\mathbb{C}} \in \mathbb{C}
   &&\bigl(\because\ \blkref{inclusion_rr_to_cc}\bigr) \\
&\left(\gamma(\tilde\theta_\mu)\right)_{\mathbb{C}}
\left(\check\psi_\mu^\dagger\,\check\psi_\nu - \left(\tfrac12\right)_{\mathbb{C}} I\right) \in R
   &&\bigl(\because\ \blkref{def_matrix_scalar_multiple}\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " は任意だったので、",
      ]),
      displayMath(
        String.raw`\check{X} \in R
\qquad\bigl(\because\ \blkref{def_finite_sum_of_matrices}\ (m, n \to 2^{M_{\mathrm{col}}},\ r \to M_{\mathrm{col}},\ X_j \to \text{上の最終行の}\ \mu = j\ \text{の項})\bigr)`,
      ),
      paragraph([
        "(2) ",
        math(String.raw`-\check{X} \in R`),
        "（",
        ref("def_matrix_negation"),
        "）と ",
        math(String.raw`\exp(\pm\check{X}) \in R`),
        "（",
        ref("def_exp"),
        "）を用いる。",
        math(String.raw`\exp`),
        " は級数の極限なので、ここで ",
        math(String.raw`\mathbb{R}`),
        " へ脱出する（",
        ref("exp_of_negative_is_left_inverse"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\check{V}'\exp(-\check{X})
&=\exp(\check{X})\exp(-\check{X})
&&(\because\ \check{V}'\ \text{の定義})\\
&=\exp(-(-\check{X}))\exp(-\check{X})
&&\bigl(\because\ \blkref{matrix_double_negation}\ (m\to 2^{M_{\mathrm{col}}},\ n\to 2^{M_{\mathrm{col}}},\ A\to \check{X})\bigr)\\
&=I
&&\bigl(\because\ \blkref{exp_of_negative_is_left_inverse}\ (n\to 2^{M_{\mathrm{col}}},\ A\to -\check{X})\bigr),\\[2mm]
\exp(-\check{X})\,\check{V}'
&=\exp(-\check{X})\exp(\check{X})
&&(\because\ \check{V}'\ \text{の定義})\\
&=I
&&\bigl(\because\ \blkref{exp_of_negative_is_left_inverse}\ (n\to 2^{M_{\mathrm{col}}},\ A\to \check{X})\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
&\check{V}' \in R^\times
   &&\bigl(\because\ \text{上の二つの積},\ \blkref{def_invertible_elements_of_R}\ (M\to M_{\mathrm{col}},\ g\to \check{V}',\ h\to \exp(-\check{X}))\bigr) \\
&\left(\check{V}'\right)^{-1} = \exp(-\check{X})
   &&\bigl(\because\ \text{上の二つの積},\ \blkref{def_invertible_elements_of_R}\ (h\ \text{はただ 1 つに定まり}\ g^{-1}\ \text{と書く})\bigr) \\
&T_{(\check{V}')}:R\to R,\ W\mapsto \check{V}'\,W\,\left(\check{V}'\right)^{-1}\ \text{が定義される}
   &&\bigl(\because\ \blkref{def_T_g}\ (M\to M_{\mathrm{col}},\ g\to \check{V}')\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の def_Vprime の半整数運動量版。対になる添字は −μ ではなく M+1−μ である（conjugate_index_of_check_Z_Y、def_check_index_set (2)）。",
        "和の範囲が 𝓜̌ = {1,…,M} で尽きること（重複も数え落としも無いこと）は、anticommutator_of_check_psi の対 " +
          "ν = M+1−μ が 𝓜̌ 上の対合（involution）になることに対応する（def_check_index_set (2)(4)）。" +
          "数値では、この形の V̌' が T_{(V^{(+)})} と一致する（T_V_plus_eq_T_check_Vprime）ことで確認している" +
          "（sagemath/check/049_claim_even_sector_fermions/check_04, check_05）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-03（全証明の SageMath 検算）: 証明を書き直した。(1) の旧証明は分母 2√M_col γ_2(−θ̃_μ) ≠ 0 の根拠に gamma_2_theta_tilde_nonzero を引いていたが、そのブロックは γ_2(θ̃_μ) ≠ 0 だけを述べ、γ_2(−θ̃_μ) の非零性は relation_of_gamma_2_theta_tilde に回している。ψ̌ が 𝓜̌ の全添字で定まることは def_check_fermi の主張なので、(1) はそれと def_check_index_set (2) を引いて各項が R の元であることを 1 行 1 根拠で示す形にした。(2) は「正則」の定めの無い matrix_exp_conjugation (3) の当てはめを、V1_plus_half_invertible と同じく exp_of_negative_is_left_inverse の二つの積と def_invertible_elements_of_R の鎖に替えた。主張の実数 γ(θ̃_μ)・1/2 を包含の像 (·)_C と書き、下流（V_plus_exponential_form 等）が使う γ(θ̃_μ)(… − ½I) の書き方を inclusion_rr_to_cc の略記として宣言し、R と R^× の出所と ℝ への脱出（arccosh の実対数、exp の極限）を書いた（中身は不変）。検算は sagemath/check/def_check_Vprime/。",
      ],
    },
  },
  {
    id: "evenfermi_006_claim_action_T_check_Vprime",
    kind: "claim",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 8 },
    title: { tex: String.raw`T_{(\check{V}')} \text{ の } \check\psi \text{ への作用}` },
    labels: ["action_of_T_check_Vprime_on_check_psi"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`T_{(\check{V}')}\!\left(\check\psi_\mu^\dagger\right) = \left(\exp(+\gamma(\tilde\theta_\mu))\right)_{\mathbb{C}}\check\psi_\mu^\dagger,
\qquad
T_{(\check{V}')}\!\left(\check\psi_\mu\right) = \left(\exp(-\gamma(\tilde\theta_\mu))\right)_{\mathbb{C}}\check\psi_\mu`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`T_{(\check{V}')}`),
        " は ",
        ref("def_check_Vprime"),
        " (2)、",
        math(String.raw`\check\psi_\mu^\dagger, \check\psi_\mu`),
        " は ",
        ref("def_check_fermi"),
        "、",
        math(String.raw`\gamma(\tilde\theta_\mu) \in \mathbb{R}_{\geq 0}`),
        " は ",
        ref("def_gamma_theta"),
        "、exp は実数の exp（",
        ref("def_scalar_exp"),
        "）で、",
        math(String.raw`(\cdot)_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の像。右辺は ",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍）。",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        " は実対数による arccosh で、exp の値と ",
        math(String.raw`\exp(\pm\check{X})`),
        " は級数の極限で定まるので、ここで ",
        math(String.raw`\mathbb{R}`),
        " へ脱出している。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取った ",
        math(String.raw`R := \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を用い、",
        math(String.raw`I := I_{R}`),
        "（",
        ref("def_identity_matrix"),
        "）、",
        math(String.raw`O \in R`),
        "（",
        ref("def_zero_matrix"),
        "）、",
        math(String.raw`T := T_{(\check{V}')}`),
        " と書く。行列の積は ",
        ref("mat_mult"),
        "、和は ",
        ref("def_matrix_sum"),
        "、差は ",
        ref("def_matrix_difference"),
        "、符号反転は ",
        ref("def_matrix_negation"),
        "、スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "、",
        math(String.raw`\check{\mathcal{M}} = \{1,\dots,M_{\mathrm{col}}\}`),
        " 上の和は ",
        ref("def_finite_sum_of_matrices"),
        " の ",
        math(String.raw`r = M_{\mathrm{col}}`),
        " の有限和、交換子は ",
        ref("def_ad_X_matrix"),
        " の ",
        math(String.raw`[A, B] := AB - BA`),
        "、反交換子は ",
        ref("def_matrix_anticommutator"),
        "、",
        math(String.raw`\delta \in \mathbb{C}`),
        " は ",
        ref("def_kronecker_delta"),
        "、",
        math(String.raw`\mathbb{C}`),
        " の差は ",
        ref("def_complex_difference"),
        " による。",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " について ",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M_{\mathrm{col}}+1-\nu \in \check{\mathcal{M}}`),
        " であり、",
        math(String.raw`M_{\mathrm{col}}+1-(M_{\mathrm{col}}+1-\nu) = \nu`),
        " である。",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " について",
      ]),
      displayMath(String.raw`g_\nu := \left(\gamma(\tilde\theta_\nu)\right)_{\mathbb{C}} \in \mathbb{C},
\qquad
P_\nu := \check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu} \in R,
\qquad
U := \left(\tfrac12\right)_{\mathbb{C}} I \in R`),
      paragraph([
        "と置く。",
        ref("def_check_Vprime"),
        " より ",
        math(String.raw`\check{X} = \sum_{\nu \in \check{\mathcal{M}}} g_\nu\left(P_\nu - U\right)`),
        "、",
        math(String.raw`\check{V}' = \exp(\check{X})`),
        "、同 (2) より ",
        math(String.raw`\left(\check{V}'\right)^{-1} = \exp(-\check{X})`),
        "、",
        math(String.raw`T(W) = \left(\check{V}'W\right)\left(\check{V}'\right)^{-1}`),
        "（",
        math(String.raw`W \in R`),
        "）である。冪は ",
        ref("def_exp"),
        " (1) の ",
        math(String.raw`A^0 := I`),
        "、",
        math(String.raw`A^{m+1} := A^m A`),
        " により、",
        math(String.raw`A \in R`),
        "、",
        math(String.raw`N \in \mathbb{Z}_{\geq 0}`),
        " について部分和を ",
        math(String.raw`S_N(A) := \sum_{m=0}^{N}\left(\tfrac{1}{m!}\right)_{\mathbb{C}}A^m`),
        "（",
        ref("def_finite_sum_of_matrices_from_index_zero"),
        "）と置く。",
        ref("def_exp"),
        " (1) より ",
        math(String.raw`\exp(A)`),
        " は ",
        math(String.raw`S_N(A)`),
        " の ",
        math(String.raw`N \to \infty`),
        " での極限である。",
      ]),
      paragraph([
        "準備 1（スカラー行列は任意の元と可換）。",
        math(String.raw`c \in \mathbb{C}`),
        "、",
        math(String.raw`W \in R`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(cI)W - W(cI)
&= [cI, W]
&&\bigl(\because\ \blkref{def_ad_X_matrix}\bigr)\\
&= O
&&\bigl(\because\ \blkref{scalar_identity_commutes}\ (n \to 2^{M_{\mathrm{col}}},\ A \to W)\bigr)
\end{aligned}`),
      paragraph([
        "であるから、",
        ref("matrix_difference_zero_iff_equal"),
        " より ",
        math(String.raw`(cI)W = W(cI)`),
        " である。",
      ]),
      paragraph([
        "準備 2（差と積）。",
        math(String.raw`A, B, C \in R`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(A - B)C
&= \left(A + (-B)\right)C
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\bigr)\\
&= AC + (-B)C
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_left_factor}\bigr)\\
&= AC + \left(-(BC)\right)
&&\bigl(\because\ \blkref{negation_factors_out_of_left_factor}\bigr)\\
&= AC - BC
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
C(A - B)
&= C\left(A + (-B)\right)
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\bigr)\\
&= CA + C(-B)
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_right_factor}\bigr)\\
&= CA + \left(-(CB)\right)
&&\bigl(\because\ \blkref{negation_factors_out_of_right_factor}\bigr)\\
&= CA - CB
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\bigr)
\end{aligned}`),
      paragraph([
        "準備 3（差の打ち消し）。",
        math(String.raw`A, B, C \in R`),
        "、",
        math(String.raw`k, l \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\left((A - B) - (C - B)\right)_{kl}
&= (A - B)_{kl} - (C - B)_{kl}
&&\bigl(\because\ \blkref{def_matrix_difference}\bigr)\\
&= \left(A_{kl} - B_{kl}\right) - \left(C_{kl} - B_{kl}\right)
&&\bigl(\because\ \blkref{def_matrix_difference}\ \text{を 2 か所へ同時適用}\bigr)\\
&= A_{kl} - C_{kl}
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\ \text{と}\ \blkref{def_complex_difference}\bigr)\\
&= (A - C)_{kl}
&&\bigl(\because\ \blkref{def_matrix_difference}\bigr)
\end{aligned}`),
      paragraph([
        "であり、成分がすべて等しいので ",
        math(String.raw`(A - B) - (C - B) = A - C`),
        " である。",
      ]),
      paragraph([
        "準備 4（和の差）。",
        math(String.raw`A_\nu, B_\nu \in R`),
        "（",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        "）、",
        math(String.raw`k, l \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について、まず",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\sum_{\nu \in \check{\mathcal{M}}}\left(A_\nu + B_\nu\right)\Bigr)_{kl}
&= \sum_{\nu \in \check{\mathcal{M}}}\left(A_\nu + B_\nu\right)_{kl}
&&\bigl(\because\ \blkref{finite_sum_of_matrices_entrywise}\bigr)\\
&= \sum_{\nu \in \check{\mathcal{M}}}\left((A_\nu)_{kl} + (B_\nu)_{kl}\right)
&&\bigl(\because\ \blkref{def_matrix_sum}\ \text{を各項へ同時適用}\bigr)\\
&= \Bigl(\sum_{\nu \in \check{\mathcal{M}}}(A_\nu)_{kl}\Bigr) + \Bigl(\sum_{\nu \in \check{\mathcal{M}}}(B_\nu)_{kl}\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_complex_sums}\bigr)\\
&= \Bigl(\sum_{\nu \in \check{\mathcal{M}}}A_\nu\Bigr)_{kl} + \Bigl(\sum_{\nu \in \check{\mathcal{M}}}B_\nu\Bigr)_{kl}
&&\bigl(\because\ \blkref{finite_sum_of_matrices_entrywise}\ \text{を 2 か所へ同時適用}\bigr)\\
&= \Bigl(\sum_{\nu \in \check{\mathcal{M}}}A_\nu + \sum_{\nu \in \check{\mathcal{M}}}B_\nu\Bigr)_{kl}
&&\bigl(\because\ \blkref{def_matrix_sum}\bigr)
\end{aligned}`),
      paragraph([
        "であり、成分がすべて等しいので ",
        math(String.raw`\sum_{\nu}\left(A_\nu + B_\nu\right) = \sum_{\nu}A_\nu + \sum_{\nu}B_\nu`),
        " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{\nu \in \check{\mathcal{M}}}\left(A_\nu - B_\nu\right)
&= \sum_{\nu \in \check{\mathcal{M}}}\left(A_\nu + (-B_\nu)\right)
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\ \text{を各項へ同時適用}\bigr)\\
&= \sum_{\nu \in \check{\mathcal{M}}}A_\nu + \sum_{\nu \in \check{\mathcal{M}}}(-B_\nu)
&&\bigl(\because\ \text{直前の和の等式}\ (B_\nu \to -B_\nu)\bigr)\\
&= \sum_{\nu \in \check{\mathcal{M}}}A_\nu + \Bigl(-\sum_{\nu \in \check{\mathcal{M}}}B_\nu\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_negated_matrices}\bigr)\\
&= \sum_{\nu \in \check{\mathcal{M}}}A_\nu - \sum_{\nu \in \check{\mathcal{M}}}B_\nu
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\bigr)
\end{aligned}`),
      paragraph([
        "準備 5（",
        math(String.raw`\check{X}`),
        " との交換子の展開）。",
        math(String.raw`W \in R`),
        "、",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " について ",
        math(String.raw`C_\nu := g_\nu\left(P_\nu - U\right) \in R`),
        " と置くと",
      ]),
      displayMath(String.raw`\begin{aligned}
[C_\nu, W]
&= \left(g_\nu\left(P_\nu - U\right)\right)W - W\left(g_\nu\left(P_\nu - U\right)\right)
&&\bigl(\because\ \blkref{def_ad_X_matrix}\bigr)\\
&= g_\nu\left(\left(P_\nu - U\right)W\right) - W\left(g_\nu\left(P_\nu - U\right)\right)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\bigr)\\
&= g_\nu\left(\left(P_\nu - U\right)W\right) - g_\nu\left(W\left(P_\nu - U\right)\right)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\bigr)\\
&= g_\nu\left(P_\nu W - UW\right) - g_\nu\left(W\left(P_\nu - U\right)\right)
&&\bigl(\because\ \text{準備 2 の第 1 式}\bigr)\\
&= g_\nu\left(P_\nu W - UW\right) - g_\nu\left(WP_\nu - WU\right)
&&\bigl(\because\ \text{準備 2 の第 2 式}\bigr)\\
&= g_\nu\left(P_\nu W - UW\right) - g_\nu\left(WP_\nu - UW\right)
&&\bigl(\because\ \text{準備 1}\ \bigl(c \to \left(\tfrac12\right)_{\mathbb{C}}\bigr)\ \text{を右辺から左辺へ}\bigr)\\
&= g_\nu\left(\left(P_\nu W - UW\right) - \left(WP_\nu - UW\right)\right)
&&\bigl(\because\ \blkref{scalar_multiple_distributes_over_matrix_difference}\ \text{を右辺から左辺へ}\bigr)\\
&= g_\nu\left(P_\nu W - WP_\nu\right)
&&\bigl(\because\ \text{準備 3}\bigr)\\
&= g_\nu[P_\nu, W]
&&\bigl(\because\ \blkref{def_ad_X_matrix}\bigr)
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(String.raw`\begin{aligned}
[\check{X}, W]
&= \check{X}W - W\check{X}
&&\bigl(\because\ \blkref{def_ad_X_matrix}\bigr)\\
&= \Bigl(\sum_{\nu \in \check{\mathcal{M}}} C_\nu\Bigr)W - W\Bigl(\sum_{\nu \in \check{\mathcal{M}}} C_\nu\Bigr)
&&\bigl(\because\ \blkref{def_check_Vprime}\ \text{の}\ \check{X}\ \text{を 2 か所へ同時適用}\bigr)\\
&= \sum_{\nu \in \check{\mathcal{M}}}\left(C_\nu W\right) - W\Bigl(\sum_{\nu \in \check{\mathcal{M}}} C_\nu\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_distributes_in_left_factor}\bigr)\\
&= \sum_{\nu \in \check{\mathcal{M}}}\left(C_\nu W\right) - \sum_{\nu \in \check{\mathcal{M}}}\left(WC_\nu\right)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_distributes_in_right_factor}\bigr)\\
&= \sum_{\nu \in \check{\mathcal{M}}}\left(C_\nu W - WC_\nu\right)
&&\bigl(\because\ \text{準備 4 を右辺から左辺へ}\bigr)\\
&= \sum_{\nu \in \check{\mathcal{M}}}[C_\nu, W]
&&\bigl(\because\ \blkref{def_ad_X_matrix}\ \text{を各項へ同時適用}\bigr)\\
&= \sum_{\nu \in \check{\mathcal{M}}} g_\nu[P_\nu, W]
&&\bigl(\because\ \text{直前の}\ [C_\nu, W]\ \text{の式を各項へ同時適用}\bigr)
\end{aligned}`),
      paragraph([
        "準備 6（",
        math(String.raw`cI`),
        " の成分）。",
        math(String.raw`c \in \mathbb{C}`),
        "、",
        math(String.raw`k, l \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(cI)_{kl}
&= c\,I_{kl}
&&\bigl(\because\ \blkref{def_matrix_scalar_multiple}\bigr)\\
&= c\,\delta_{kl}
&&\bigl(\because\ \blkref{def_identity_matrix}\bigr)
\end{aligned}`),
      paragraph(["であり、",]),
      displayMath(String.raw`\begin{aligned}
c\,\delta_{kk}
&= c\,1_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_kronecker_delta}\bigr)\\
&= c
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\ \text{の乗法の単位元}\bigr)
\end{aligned}
\qquad
\begin{aligned}
c\,\delta_{kl}
&= c\,0_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_kronecker_delta}\ (k \neq l)\bigr)\\
&= 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\bigr)
\end{aligned}`),
      paragraph([
        "である。よって ",
        math(String.raw`cI`),
        " は ",
        ref("def_diagonal_matrix"),
        " の対角行列で、対角成分は ",
        math(String.raw`c`),
        " である。",
      ]),
      paragraph([
        "準備 7（",
        math(String.raw`\exp(cI) = \exp(c)\,I`),
        "）。",
        math(String.raw`c \in \mathbb{C}`),
        "、",
        math(String.raw`k, l \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について（",
        math(String.raw`\exp(c)`),
        " は ",
        ref("def_scalar_exp"),
        " の複素数の exp）",
      ]),
      displayMath(String.raw`\begin{aligned}
\exp(cI)_{kl}
&= \begin{cases} \exp\!\left((cI)_{kk}\right) & (k = l) \\ 0_{\mathbb{C}} & (k \neq l) \end{cases}
&&\bigl(\because\ \blkref{exp_of_diagonal_matrix}\ (n \to 2^{M_{\mathrm{col}}},\ D \to cI)\bigr)\\
&= \begin{cases} \exp(c) & (k = l) \\ 0_{\mathbb{C}} & (k \neq l) \end{cases}
&&\bigl(\because\ \text{準備 6 の対角成分}\bigr)\\
&= \begin{cases} \exp(c)\,1_{\mathbb{C}} & (k = l) \\ \exp(c)\,0_{\mathbb{C}} & (k \neq l) \end{cases}
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\bigr)\\
&= \exp(c)\,\delta_{kl}
&&\bigl(\because\ \blkref{def_kronecker_delta}\bigr)\\
&= \left(\exp(c)\,I\right)_{kl}
&&\bigl(\because\ \text{準備 6 の第 1 の鎖}\ (c \to \exp(c))\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "であり、成分がすべて等しいので ",
        math(String.raw`\exp(cI) = \exp(c)\,I`),
        " である（",
        math(String.raw`\exp(cI)`),
        " と ",
        math(String.raw`\exp(c)`),
        " は級数の極限で定まるので、ここで ",
        math(String.raw`\mathbb{R}`),
        " へ脱出している）。",
      ]),
      paragraph([
        "準備 8（",
        math(String.raw`\check{X} + cI`),
        " と ",
        math(String.raw`-\check{X}`),
        " の可換性と和）。",
        math(String.raw`c \in \mathbb{C}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\check{X} + cI\right)\left(-\check{X}\right)
&= \check{X}\left(-\check{X}\right) + (cI)\left(-\check{X}\right)
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_left_factor}\bigr)\\
&= -\left(\check{X}\check{X}\right) + (cI)\left(-\check{X}\right)
&&\bigl(\because\ \blkref{negation_factors_out_of_right_factor}\bigr)\\
&= -\left(\check{X}\check{X}\right) + \left(-\check{X}\right)(cI)
&&\bigl(\because\ \text{準備 1}\ (W \to -\check{X})\bigr)\\
&= \left(-\check{X}\right)\check{X} + \left(-\check{X}\right)(cI)
&&\bigl(\because\ \blkref{negation_factors_out_of_left_factor}\ \text{を右辺から左辺へ}\bigr)\\
&= \left(-\check{X}\right)\left(\check{X} + cI\right)
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_right_factor}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(String.raw`\begin{aligned}
\left(\check{X} + cI\right) + \left(-\check{X}\right)
&= \left(-\check{X}\right) + \left(\check{X} + cI\right)
&&\bigl(\because\ \blkref{matrix_sum_is_commutative}\bigr)\\
&= \left(-\check{X}\right) + \left(cI + \check{X}\right)
&&\bigl(\because\ \blkref{matrix_sum_is_commutative}\bigr)\\
&= \left(-\check{X}\right) + \left(cI + \left(-\left(-\check{X}\right)\right)\right)
&&\bigl(\because\ \blkref{matrix_double_negation}\ \text{を右辺から左辺へ}\bigr)\\
&= \left(-\check{X}\right) + \left(cI - \left(-\check{X}\right)\right)
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\ \text{を右辺から左辺へ}\bigr)\\
&= cI
&&\bigl(\because\ \blkref{matrix_plus_difference_cancels}\ (A \to -\check{X},\ B \to cI)\bigr)
\end{aligned}`),
      paragraph(["である。"]),
      paragraph([
        "Step 1（1 項ぶんの交換子、",
        math(String.raw`\check\psi_\mu^\dagger`),
        " 側）。",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " について、",
        math(String.raw`\delta_{M_{\mathrm{col}}+1-\nu,\,M_{\mathrm{col}}+1-\mu} = \delta_{\mu,\nu}`),
        " である（",
        ref("def_kronecker_delta"),
        " と、",
        math(String.raw`\mathbb{Z}`),
        " で ",
        math(String.raw`M_{\mathrm{col}}+1-\nu = M_{\mathrm{col}}+1-\mu \iff \mu = \nu`),
        "）。",
        ref("commutator_via_anticommutators"),
        " の交換子・反交換子は ",
        ref("def_ad_X_matrix"),
        "・",
        ref("def_matrix_anticommutator"),
        " のものと同じ式である。",
      ]),
      displayMath(String.raw`\begin{aligned}
[P_\nu, \check\psi_\mu^\dagger]
&= \left[\check\psi_\nu^\dagger\check\psi_{M_{\mathrm{col}}+1-\nu},\ \check\psi_\mu^\dagger\right]
&&\bigl(\because\ P_\nu\ \text{の定め方}\bigr)\\
&= \check\psi_\nu^\dagger\left[\check\psi_{M_{\mathrm{col}}+1-\nu}, \check\psi_\mu^\dagger\right]_+
   - \left[\check\psi_\nu^\dagger, \check\psi_\mu^\dagger\right]_+\check\psi_{M_{\mathrm{col}}+1-\nu}
&&\bigl(\because\ \blkref{commutator_via_anticommutators}\ (a \to \check\psi_\nu^\dagger,\ b \to \check\psi_{M_{\mathrm{col}}+1-\nu},\ c \to \check\psi_\mu^\dagger)\bigr)\\
&= \check\psi_\nu^\dagger\left(\check\psi_{M_{\mathrm{col}}+1-\nu}\check\psi_\mu^\dagger + \check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\nu}\right)
   - \left[\check\psi_\nu^\dagger, \check\psi_\mu^\dagger\right]_+\check\psi_{M_{\mathrm{col}}+1-\nu}
&&\bigl(\because\ \blkref{def_matrix_anticommutator}\bigr)\\
&= \check\psi_\nu^\dagger\left(\check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\nu} + \check\psi_{M_{\mathrm{col}}+1-\nu}\check\psi_\mu^\dagger\right)
   - \left[\check\psi_\nu^\dagger, \check\psi_\mu^\dagger\right]_+\check\psi_{M_{\mathrm{col}}+1-\nu}
&&\bigl(\because\ \blkref{matrix_sum_is_commutative}\bigr)\\
&= \check\psi_\nu^\dagger\left[\check\psi_\mu^\dagger, \check\psi_{M_{\mathrm{col}}+1-\nu}\right]_+
   - \left[\check\psi_\nu^\dagger, \check\psi_\mu^\dagger\right]_+\check\psi_{M_{\mathrm{col}}+1-\nu}
&&\bigl(\because\ \blkref{def_matrix_anticommutator}\bigr)\\
&= \check\psi_\nu^\dagger\left(\delta_{M_{\mathrm{col}}+1-\nu,\,M_{\mathrm{col}}+1-\mu}\,I\right)
   - \left[\check\psi_\nu^\dagger, \check\psi_\mu^\dagger\right]_+\check\psi_{M_{\mathrm{col}}+1-\nu}
&&\bigl(\because\ \blkref{anticommutator_of_check_psi}\ \text{の第 2 式}\ (\nu \to M_{\mathrm{col}}+1-\nu)\bigr)\\
&= \check\psi_\nu^\dagger\left(\delta_{M_{\mathrm{col}}+1-\nu,\,M_{\mathrm{col}}+1-\mu}\,I\right) - O\,\check\psi_{M_{\mathrm{col}}+1-\nu}
&&\bigl(\because\ \blkref{anticommutator_of_check_psi}\ \text{の第 1 式}\ ((\mu, \nu) \to (\nu, \mu))\bigr)\\
&= \check\psi_\nu^\dagger\left(\delta_{M_{\mathrm{col}}+1-\nu,\,M_{\mathrm{col}}+1-\mu}\,I\right) - O
&&\bigl(\because\ \blkref{zero_matrix_is_left_zero_of_mat_mult}\bigr)\\
&= \check\psi_\nu^\dagger\left(\delta_{M_{\mathrm{col}}+1-\nu,\,M_{\mathrm{col}}+1-\mu}\,I\right)
&&\bigl(\because\ \blkref{matrix_minus_zero_matrix}\bigr)\\
&= \check\psi_\nu^\dagger\left(\delta_{\mu,\nu}\,I\right)
&&\bigl(\because\ \delta_{M_{\mathrm{col}}+1-\nu,\,M_{\mathrm{col}}+1-\mu} = \delta_{\mu,\nu}\bigr)\\
&= \delta_{\mu,\nu}\left(\check\psi_\nu^\dagger I\right)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\bigr)\\
&= \delta_{\mu,\nu}\,\check\psi_\nu^\dagger
&&\bigl(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\bigr)
\end{aligned}`),
      paragraph([
        "Step 1'（1 項ぶんの交換子、",
        math(String.raw`\check\psi_\mu`),
        " 側）。",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
[P_\nu, \check\psi_\mu]
&= \left[\check\psi_\nu^\dagger\check\psi_{M_{\mathrm{col}}+1-\nu},\ \check\psi_\mu\right]
&&\bigl(\because\ P_\nu\ \text{の定め方}\bigr)\\
&= \check\psi_\nu^\dagger\left[\check\psi_{M_{\mathrm{col}}+1-\nu}, \check\psi_\mu\right]_+
   - \left[\check\psi_\nu^\dagger, \check\psi_\mu\right]_+\check\psi_{M_{\mathrm{col}}+1-\nu}
&&\bigl(\because\ \blkref{commutator_via_anticommutators}\ (a \to \check\psi_\nu^\dagger,\ b \to \check\psi_{M_{\mathrm{col}}+1-\nu},\ c \to \check\psi_\mu)\bigr)\\
&= \check\psi_\nu^\dagger\,O - \left[\check\psi_\nu^\dagger, \check\psi_\mu\right]_+\check\psi_{M_{\mathrm{col}}+1-\nu}
&&\bigl(\because\ \blkref{anticommutator_of_check_psi}\ \text{の第 3 式}\ ((\mu, \nu) \to (M_{\mathrm{col}}+1-\nu, \mu))\bigr)\\
&= O - \left[\check\psi_\nu^\dagger, \check\psi_\mu\right]_+\check\psi_{M_{\mathrm{col}}+1-\nu}
&&\bigl(\because\ \blkref{zero_matrix_is_right_zero_of_mat_mult}\bigr)\\
&= O - \left(\delta_{\mu,\,M_{\mathrm{col}}+1-\nu}\,I\right)\check\psi_{M_{\mathrm{col}}+1-\nu}
&&\bigl(\because\ \blkref{anticommutator_of_check_psi}\ \text{の第 2 式}\ ((\mu, \nu) \to (\nu, \mu))\bigr)\\
&= O - \delta_{\mu,\,M_{\mathrm{col}}+1-\nu}\left(I\check\psi_{M_{\mathrm{col}}+1-\nu}\right)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\bigr)\\
&= O - \delta_{\mu,\,M_{\mathrm{col}}+1-\nu}\,\check\psi_{M_{\mathrm{col}}+1-\nu}
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)\\
&= O + \left(-\left(\delta_{\mu,\,M_{\mathrm{col}}+1-\nu}\,\check\psi_{M_{\mathrm{col}}+1-\nu}\right)\right)
&&\bigl(\because\ \blkref{matrix_difference_is_sum_with_negation}\bigr)\\
&= -\left(\delta_{\mu,\,M_{\mathrm{col}}+1-\nu}\,\check\psi_{M_{\mathrm{col}}+1-\nu}\right)
&&\bigl(\because\ \blkref{zero_matrix_plus_matrix}\bigr)
\end{aligned}`),
      paragraph([
        "Step 2（",
        math(String.raw`[\check{X}, \check\psi_\mu^\dagger] = g_\mu\check\psi_\mu^\dagger`),
        "）。",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        "、",
        math(String.raw`\nu \neq \mu`),
        " の項は",
      ]),
      displayMath(String.raw`\begin{aligned}
g_\nu\left(\delta_{\mu,\nu}\,\check\psi_\nu^\dagger\right)
&= g_\nu\left(0_{\mathbb{C}}\,\check\psi_\nu^\dagger\right)
&&\bigl(\because\ \blkref{def_kronecker_delta}\ (\nu \neq \mu)\bigr)\\
&= g_\nu\,O
&&\bigl(\because\ \blkref{zero_scalar_multiple_is_zero_matrix}\bigr)\\
&= O
&&\bigl(\because\ \blkref{scalar_multiple_of_zero_matrix}\bigr)
\end{aligned}`),
      paragraph(["なので、"]),
      displayMath(String.raw`\begin{aligned}
[\check{X}, \check\psi_\mu^\dagger]
&= \sum_{\nu \in \check{\mathcal{M}}} g_\nu[P_\nu, \check\psi_\mu^\dagger]
&&\bigl(\because\ \text{準備 5}\ (W \to \check\psi_\mu^\dagger)\bigr)\\
&= \sum_{\nu \in \check{\mathcal{M}}} g_\nu\left(\delta_{\mu,\nu}\,\check\psi_\nu^\dagger\right)
&&\bigl(\because\ \text{Step 1 を各項へ同時適用}\bigr)\\
&= g_\mu\left(\delta_{\mu,\mu}\,\check\psi_\mu^\dagger\right)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_with_single_nonzero_term}\ (r \to M_{\mathrm{col}},\ q \to \mu)\bigr)\\
&= g_\mu\left(1_{\mathbb{C}}\,\check\psi_\mu^\dagger\right)
&&\bigl(\because\ \blkref{def_kronecker_delta}\bigr)\\
&= g_\mu\,\check\psi_\mu^\dagger
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)
\end{aligned}`),
      paragraph([
        "Step 2'（",
        math(String.raw`[\check{X}, \check\psi_\mu] = (-g_\mu)\check\psi_\mu`),
        "）。",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " で ",
        math(String.raw`\delta_{\mu,\,M_{\mathrm{col}}+1-\nu} \neq 0_{\mathbb{C}}`),
        " となるのは ",
        math(String.raw`M_{\mathrm{col}}+1-\nu = \mu`),
        "、すなわち ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu \in \check{\mathcal{M}}`),
        " だけである。それ以外の ",
        math(String.raw`\nu`),
        " の項は",
      ]),
      displayMath(String.raw`\begin{aligned}
g_\nu\left(-\left(\delta_{\mu,\,M_{\mathrm{col}}+1-\nu}\,\check\psi_{M_{\mathrm{col}}+1-\nu}\right)\right)
&= g_\nu\left(-\left(0_{\mathbb{C}}\,\check\psi_{M_{\mathrm{col}}+1-\nu}\right)\right)
&&\bigl(\because\ \blkref{def_kronecker_delta}\ (M_{\mathrm{col}}+1-\nu \neq \mu)\bigr)\\
&= g_\nu\left(-O\right)
&&\bigl(\because\ \blkref{zero_scalar_multiple_is_zero_matrix}\bigr)\\
&= g_\nu\left((-1_{\mathbb{C}})\,O\right)
&&\bigl(\because\ \blkref{negation_is_scalar_multiple_by_minus_one}\bigr)\\
&= g_\nu\,O
&&\bigl(\because\ \blkref{scalar_multiple_of_zero_matrix}\bigr)\\
&= O
&&\bigl(\because\ \blkref{scalar_multiple_of_zero_matrix}\bigr)
\end{aligned}`),
      paragraph(["なので、"]),
      displayMath(String.raw`\begin{aligned}
[\check{X}, \check\psi_\mu]
&= \sum_{\nu \in \check{\mathcal{M}}} g_\nu[P_\nu, \check\psi_\mu]
&&\bigl(\because\ \text{準備 5}\ (W \to \check\psi_\mu)\bigr)\\
&= \sum_{\nu \in \check{\mathcal{M}}} g_\nu\left(-\left(\delta_{\mu,\,M_{\mathrm{col}}+1-\nu}\,\check\psi_{M_{\mathrm{col}}+1-\nu}\right)\right)
&&\bigl(\because\ \text{Step 1' を各項へ同時適用}\bigr)\\
&= g_{M_{\mathrm{col}}+1-\mu}\left(-\left(\delta_{\mu,\,M_{\mathrm{col}}+1-(M_{\mathrm{col}}+1-\mu)}\,\check\psi_{M_{\mathrm{col}}+1-(M_{\mathrm{col}}+1-\mu)}\right)\right)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_with_single_nonzero_term}\ (r \to M_{\mathrm{col}},\ q \to M_{\mathrm{col}}+1-\mu)\bigr)\\
&= g_{M_{\mathrm{col}}+1-\mu}\left(-\left(\delta_{\mu,\mu}\,\check\psi_\mu\right)\right)
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ M_{\mathrm{col}}+1-(M_{\mathrm{col}}+1-\mu) = \mu\bigr)\\
&= g_{M_{\mathrm{col}}+1-\mu}\left(-\left(1_{\mathbb{C}}\,\check\psi_\mu\right)\right)
&&\bigl(\because\ \blkref{def_kronecker_delta}\bigr)\\
&= g_{M_{\mathrm{col}}+1-\mu}\left(-\check\psi_\mu\right)
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\bigr)\\
&= -\left(g_{M_{\mathrm{col}}+1-\mu}\,\check\psi_\mu\right)
&&\bigl(\because\ \blkref{scalar_multiple_of_negated_matrix}\bigr)\\
&= -\left(g_\mu\,\check\psi_\mu\right)
&&\bigl(\because\ g_\nu\ \text{の定め方と}\ \blkref{periodicity_of_check_fermi}\ (3)\ \text{の}\ \gamma(\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \gamma(\tilde\theta_\mu)\ \text{から}\ g_{M_{\mathrm{col}}+1-\mu} = g_\mu\bigr)\\
&= (-1_{\mathbb{C}})\left(g_\mu\,\check\psi_\mu\right)
&&\bigl(\because\ \blkref{negation_is_scalar_multiple_by_minus_one}\bigr)\\
&= \left((-1_{\mathbb{C}})\,g_\mu\right)\check\psi_\mu
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\bigr)\\
&= (-g_\mu)\,\check\psi_\mu
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)
\end{aligned}`),
      paragraph([
        "Step 3（移項）。以下 Step 6 まで、",
        math(String.raw`W \in R`),
        " と ",
        math(String.raw`c \in \mathbb{C}`),
        " が ",
        math(String.raw`[\check{X}, W] = cW`),
        " を満たすとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
\check{X}W
&= W\check{X} + \left(\check{X}W - W\check{X}\right)
&&\bigl(\because\ \blkref{matrix_plus_difference_cancels}\ (A \to W\check{X},\ B \to \check{X}W)\ \text{を右辺から左辺へ}\bigr)\\
&= W\check{X} + [\check{X}, W]
&&\bigl(\because\ \blkref{def_ad_X_matrix}\bigr)\\
&= W\check{X} + cW
&&\bigl(\because\ \text{仮定}\ [\check{X}, W] = cW\bigr)\\
&= W\check{X} + c\left(WI\right)
&&\bigl(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\ \text{を右辺から左辺へ}\bigr)\\
&= W\check{X} + W(cI)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\ \text{を右辺から左辺へ}\bigr)\\
&= W\left(\check{X} + cI\right)
&&\bigl(\because\ \blkref{mat_mult_distributes_over_sum_in_right_factor}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "Step 4（帰納法）。",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`\check{X}^n W = W\left(\check{X} + cI\right)^n`),
        " を ",
        math(String.raw`n`),
        " についての帰納法で示す。",
        math(String.raw`n = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\check{X}^0 W
&= IW
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\bigr)\\
&= W
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)\\
&= WI
&&\bigl(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\ \text{を右辺から左辺へ}\bigr)\\
&= W\left(\check{X} + cI\right)^0
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`n`),
        " で成り立つとすると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\check{X}^{n+1} W
&= \left(\check{X}^{n}\check{X}\right)W
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^m A\bigr)\\
&= \check{X}^{n}\left(\check{X}W\right)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= \check{X}^{n}\left(W\left(\check{X} + cI\right)\right)
&&\bigl(\because\ \text{Step 3}\bigr)\\
&= \left(\check{X}^{n}W\right)\left(\check{X} + cI\right)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= \left(W\left(\check{X} + cI\right)^{n}\right)\left(\check{X} + cI\right)
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= W\left(\left(\check{X} + cI\right)^{n}\left(\check{X} + cI\right)\right)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= W\left(\check{X} + cI\right)^{n+1}
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^m A\bigr)
\end{aligned}`),
      paragraph([
        "Step 5（部分和と極限）。",
        math(String.raw`N \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`a_m := \left(\tfrac{1}{m!}\right)_{\mathbb{C}}`),
        " と書くと",
      ]),
      displayMath(String.raw`\begin{aligned}
S_N(\check{X})\,W
&= \Bigl(\sum_{m=0}^{N} a_m\check{X}^m\Bigr)W
&&\bigl(\because\ S_N\ \text{の定め方}\bigr)\\
&= \Bigl(\sum_{j=1}^{N+1} a_{j-1}\check{X}^{j-1}\Bigr)W
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices_from_index_zero}\bigr)\\
&= \sum_{j=1}^{N+1} \left(\left(a_{j-1}\check{X}^{j-1}\right)W\right)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_distributes_in_left_factor}\bigr)\\
&= \sum_{j=1}^{N+1} a_{j-1}\left(\check{X}^{j-1} W\right)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\ \text{を各項へ同時適用}\bigr)\\
&= \sum_{j=1}^{N+1} a_{j-1}\left(W\left(\check{X} + cI\right)^{j-1}\right)
&&\bigl(\because\ \text{Step 4 を各項へ同時適用}\bigr)\\
&= \sum_{j=1}^{N+1} \left(W\left(a_{j-1}\left(\check{X} + cI\right)^{j-1}\right)\right)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\ \text{を右辺から左辺へ、各項へ同時適用}\bigr)\\
&= W\Bigl(\sum_{j=1}^{N+1} a_{j-1}\left(\check{X} + cI\right)^{j-1}\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_matrices_distributes_in_right_factor}\ \text{を右辺から左辺へ}\bigr)\\
&= W\Bigl(\sum_{m=0}^{N} a_m\left(\check{X} + cI\right)^m\Bigr)
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices_from_index_zero}\ \text{を右辺から左辺へ}\bigr)\\
&= W\,S_N\!\left(\check{X} + cI\right)
&&\bigl(\because\ S_N\ \text{の定め方}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        ref("def_exp"),
        " (1) より ",
        math(String.raw`S_N(\check{X}) \to \exp(\check{X})`),
        "、",
        math(String.raw`S_N(\check{X} + cI) \to \exp(\check{X} + cI)`),
        " であるから、",
        ref("matrix_multiplication_continuity"),
        "（",
        math(String.raw`A_N`),
        " を ",
        math(String.raw`S_N(\check{X})`),
        " に、",
        math(String.raw`A`),
        " を ",
        math(String.raw`\exp(\check{X})`),
        " に、",
        math(String.raw`B`),
        " を ",
        math(String.raw`W`),
        " に取る）より ",
        math(String.raw`S_N(\check{X})\,W \to \exp(\check{X})\,W`),
        "、",
        ref("matrix_multiplication_continuity_in_right_factor"),
        "（",
        math(String.raw`A_N`),
        " を ",
        math(String.raw`S_N(\check{X} + cI)`),
        " に、",
        math(String.raw`A`),
        " を ",
        math(String.raw`\exp(\check{X} + cI)`),
        " に、",
        math(String.raw`B`),
        " を ",
        math(String.raw`W`),
        " に取る）より ",
        math(String.raw`W\,S_N(\check{X} + cI) \to W\exp(\check{X} + cI)`),
        " である。直前の等式より二つの列は同じ列なので、",
        ref("matrix_norm_triangle_inequality"),
        " (4)（極限の一意性）より",
      ]),
      displayMath(String.raw`\exp(\check{X})\,W = W\exp\!\left(\check{X} + cI\right)`),
      paragraph([
        "である（極限をとるので、ここで ",
        math(String.raw`\mathbb{R}`),
        " へ脱出している）。",
      ]),
      paragraph([
        "Step 6（結論の一般形）。",
        ref("theorem_exp_product"),
        " の両辺の exp は級数の極限で定まる量であり、ここでも ",
        math(String.raw`\mathbb{R}`),
        " へ脱出している。",
      ]),
      displayMath(String.raw`\begin{aligned}
T(W)
&= \left(\check{V}'W\right)\left(\check{V}'\right)^{-1}
&&\bigl(\because\ \blkref{def_check_Vprime}\ (2)\ \text{の}\ T_{(\check{V}')}\ (\text{三つの積は左から読む。}\blkref{mat_mult_associative}\ \text{より読み方に依らない})\bigr)\\
&= \left(\exp(\check{X})\,W\right)\left(\check{V}'\right)^{-1}
&&\bigl(\because\ \blkref{def_check_Vprime}\ \text{の}\ \check{V}' := \exp(\check{X})\bigr)\\
&= \left(\exp(\check{X})\,W\right)\exp(-\check{X})
&&\bigl(\because\ \blkref{def_check_Vprime}\ (2)\ \text{の}\ \left(\check{V}'\right)^{-1} = \exp(-\check{X})\bigr)\\
&= \left(W\exp\!\left(\check{X} + cI\right)\right)\exp(-\check{X})
&&\bigl(\because\ \text{Step 5}\bigr)\\
&= W\left(\exp\!\left(\check{X} + cI\right)\exp(-\check{X})\right)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&= W\exp\!\left(\left(\check{X} + cI\right) + \left(-\check{X}\right)\right)
&&\bigl(\because\ \blkref{theorem_exp_product}\ (A \to \check{X} + cI,\ B \to -\check{X}),\ \text{準備 8 の可換性}\bigr)\\
&= W\exp(cI)
&&\bigl(\because\ \text{準備 8 の和}\bigr)\\
&= W\left(\exp(c)\,I\right)
&&\bigl(\because\ \text{準備 7}\bigr)\\
&= \exp(c)\left(WI\right)
&&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\bigr)\\
&= \exp(c)\,W
&&\bigl(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\bigr)
\end{aligned}`),
      paragraph([
        "結論。Step 2 より ",
        math(String.raw`W \to \check\psi_\mu^\dagger`),
        "、",
        math(String.raw`c \to g_\mu`),
        " で Step 3〜6 の仮定が成り立つので",
      ]),
      displayMath(String.raw`\begin{aligned}
T\!\left(\check\psi_\mu^\dagger\right)
&= \exp(g_\mu)\,\check\psi_\mu^\dagger
&&\bigl(\because\ \text{Step 6}\ (W \to \check\psi_\mu^\dagger,\ c \to g_\mu)\bigr)\\
&= \exp\!\left(\left(\gamma(\tilde\theta_\mu)\right)_{\mathbb{C}}\right)\check\psi_\mu^\dagger
&&\bigl(\because\ g_\mu\ \text{の定め方}\bigr)\\
&= \left(\exp(+\gamma(\tilde\theta_\mu))\right)_{\mathbb{C}}\check\psi_\mu^\dagger
&&\bigl(\because\ \blkref{complex_exp_of_real_argument}\ (x \to \gamma(\tilde\theta_\mu))\bigr)
\end{aligned}`),
      paragraph([
        "である。また Step 2' より ",
        math(String.raw`W \to \check\psi_\mu`),
        "、",
        math(String.raw`c \to -g_\mu`),
        " で Step 3〜6 の仮定が成り立ち、",
      ]),
      displayMath(String.raw`\begin{aligned}
-g_\mu
&= -\left(\gamma(\tilde\theta_\mu)\right)_{\mathbb{C}}
&&\bigl(\because\ g_\mu\ \text{の定め方}\bigr)\\
&= (-1_{\mathbb{C}})\left(\gamma(\tilde\theta_\mu)\right)_{\mathbb{C}}
&&\bigl(\because\ \blkref{multiply_by_minus_one}\bigr)\\
&= (-1)_{\mathbb{C}}\left(\gamma(\tilde\theta_\mu)\right)_{\mathbb{C}}
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\ \text{の}\ -1_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(-1) = (-1)_{\mathbb{C}}\bigr)\\
&= \left((-1)\,\gamma(\tilde\theta_\mu)\right)_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\bigr)\\
&= \left(-\gamma(\tilde\theta_\mu)\right)_{\mathbb{C}}
&&\bigl(\because\ \mathbb{R}\ \text{の}\ (-1)x = -x\bigr)
\end{aligned}`),
      paragraph(["であるから"]),
      displayMath(String.raw`\begin{aligned}
T\!\left(\check\psi_\mu\right)
&= \exp(-g_\mu)\,\check\psi_\mu
&&\bigl(\because\ \text{Step 6}\ (W \to \check\psi_\mu,\ c \to -g_\mu)\bigr)\\
&= \exp\!\left(\left(-\gamma(\tilde\theta_\mu)\right)_{\mathbb{C}}\right)\check\psi_\mu
&&\bigl(\because\ \text{直前の等式}\bigr)\\
&= \left(\exp(-\gamma(\tilde\theta_\mu))\right)_{\mathbb{C}}\check\psi_\mu
&&\bigl(\because\ \blkref{complex_exp_of_real_argument}\ (x \to -\gamma(\tilde\theta_\mu))\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の action_of_T_Vprime_on_psi の半整数運動量版。008 章にあった μ の符号による 3 通りの場合分け" +
          "（a) μ ∈ {1..M}、b) μ = -k、c) μ = -M）は、添字を μ ∈ Z で扱い periodicity_of_check_fermi を先に" +
          "用意したことで不要になった。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_04（V̌' を行列指数関数から直接構成して共役を計算）。式変形の行ごとの検算は sagemath/check/action_of_T_check_Vprime_on_check_psi/。",
        "2026-08-19 の式変形統一で、Step 1・1' の移項と交換子への回収の散文を鎖へ開き、Step 2 末尾に同居していた移項を独立の鎖へ分け、" +
          "Step 2' の一行三操作を Step 2 と同形の一操作ずつへ分け、Step 3 の一行二等号と根拠の無い行を直し、" +
          "Step 5 の exp(γI)=e^γ I の後置きの注記を準備の等式へ移し、Steps 3'〜5' の「置き換えるだけで同じ計算」を Step 3〜5 と同形の鎖へ開いた。" +
          "機械識別子の行末根拠は人間可読な名前へ直した。内容と参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-03（全証明の SageMath 検算）: 証明を書き直した。旧証明は「交換子の第 1 引数についての C 線型性」「反交換子の対称性」「exp(cI) = exp(c)I（級数定義から）」「部分和が収束するので極限をとる」を引くブロックなしで使い、交換子の定義も引いていなかった。交換子の展開を準備 1〜5（スカラー行列の可換性、差と積、差の打ち消し、和の差、[X̌, W] = Σ g_ν[P_ν, W]）として本文のブロックで示し、Step 1・1' を commutator_via_anticommutators（Lean の lie_creAnn_cre・lie_creAnn_ann と同じ手順）から反交換子の値へ 1 行 1 根拠で運ぶ鎖に、Step 2・2' の和を finite_sum_of_matrices_with_single_nonzero_term で一項に絞る鎖にした。旧 Step 3〜5 と 3'〜5' は同じ計算の繰り返しだったので、[X̌, W] = cW を満たす一般の W・c について Step 3〜6 で一度だけ示し（Lean の matExp_conj_eigen と同じ形）、ψ̌^† と ψ̌ に当てはめた。極限の一意性は matrix_norm_triangle_inequality (4) で、cI の成分（準備 6）、exp(cI) = exp(c)I（準備 7、exp_of_diagonal_matrix）、X̌ + cI と −X̌ の可換性と和（準備 8）は冒頭の準備に鎖で示した。主張の右辺を commutation_V_plus_check_psi と同じ (exp(±γ(θ̃_μ)))_C に書き、ℝ への脱出を書いた（中身は不変）。検算は sagemath/check/action_of_T_check_Vprime_on_check_psi/。",
      ],
    },
  },
  {
    id: "evenfermi_007_claim_T_eq_on_check_Z_Y",
    kind: "claim",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 9 },
    title: {
      tex: String.raw`T_{(V^{(+)})} \text{ と } T_{(\check{V}')} \text{ は } \check{Z}, \check{Y} \text{ 上で一致する}`,
    },
    labels: ["T_V_plus_eq_T_check_Vprime_on_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。すべての ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`T_{(V^{(+)})}\!\left(\check{Z}_\mu\right) = T_{(\check{V}')}\!\left(\check{Z}_\mu\right),
\qquad
T_{(V^{(+)})}\!\left(\check{Y}_\mu\right) = T_{(\check{V}')}\!\left(\check{Y}_\mu\right)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`T_{(V^{(+)})}`),
        " は ",
        ref("def_T_V_plus"),
        "、",
        math(String.raw`T_{(\check{V}')}`),
        " は ",
        ref("def_check_Vprime"),
        " (2)、",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " は ",
        ref("def_half_integer_checkZ"),
        "・",
        ref("def_half_integer_checkY"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " を固定する。",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取った ",
        math(String.raw`R := \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と ",
        math(String.raw`R^\times`),
        " を用いる。",
        math(String.raw`X_1 := \check{Z}_\mu`),
        "、",
        math(String.raw`X_2 := \check{Y}_\mu`),
        "、",
        math(String.raw`\Psi_1 := \check\psi_\mu^\dagger`),
        "、",
        math(String.raw`\Psi_2 := \check\psi_\mu`),
        "（いずれも ",
        math(String.raw`R`),
        " の元）と書き、",
        math(String.raw`k, l \in \{1,2\}`),
        " について ",
        math(String.raw`p_{kl} := (\check{P}_\mu)_{kl} \in \mathbb{C}`),
        "、",
        math(String.raw`q_{kl} := (\check{P}_\mu^{-1})_{kl} \in \mathbb{C}`),
        " と書く。",
        math(String.raw`\check{P}_\mu^{-1}`),
        " は ",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`1`),
        " に取ったときの逆元（",
        math(String.raw`\mathrm{Mat}(2^1,\mathbb{C}) = \mathrm{Mat}(2,\mathbb{C})`),
        "。",
        ref("diagonalization_check_P_D"),
        " の主張に現れるもの）で、",
        math(String.raw`\check{P}_\mu\check{P}_\mu^{-1} = I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " を満たす。組 ",
        math(String.raw`(W_1, W_2) \in R \times R`),
        " について ",
        math(String.raw`\mathrm{pr}_k(W_1, W_2) := W_k`),
        " と書く。組と ",
        math(String.raw`2\times 2`),
        " 行列の積は ",
        ref("def_pair_of_matrices_times_two_by_two_matrix"),
        "、組と数の列の積は ",
        ref("def_pair_of_matrices_times_column_of_numbers"),
        "、",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の積は ",
        ref("mat_mult"),
        "、有限和は ",
        ref("def_finite_sum_of_matrices"),
        " と ",
        ref("def_finite_sum_of_complex_numbers"),
        " による。",
      ]),
      paragraph([
        "準備 1（",
        math(String.raw`\check\psi_\mu^\dagger, \check\psi_\mu`),
        " を ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " で書く）。",
        math(String.raw`k \in \{1,2\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi_k
&= \mathrm{pr}_k\!\left(\Psi_1, \Psi_2\right)
&&\bigl(\because\ \mathrm{pr}_k\text{ の定め方}\bigr)\\
&= \mathrm{pr}_k\!\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}\check{P}_\mu\right)
&&\bigl(\because\ \blkref{def_check_fermi}\bigr)\\
&= \mathrm{pr}_k\!\left(\begin{pmatrix}X_1, & X_2\end{pmatrix}\begin{pmatrix}p_{11} \\ p_{21}\end{pmatrix},\
   \begin{pmatrix}X_1, & X_2\end{pmatrix}\begin{pmatrix}p_{12} \\ p_{22}\end{pmatrix}\right)
&&\bigl(\because\ \blkref{def_pair_of_matrices_times_two_by_two_matrix}\ (d \to 2^{M_{\mathrm{col}}},\ A \to X_1,\ B \to X_2,\ p, q, r, s \to p_{11}, p_{12}, p_{21}, p_{22})\bigr)\\
&= \begin{pmatrix}X_1, & X_2\end{pmatrix}\begin{pmatrix}p_{1k} \\ p_{2k}\end{pmatrix}
&&\bigl(\because\ \mathrm{pr}_k\text{ の定め方}\bigr)\\
&= p_{1k}X_1 + p_{2k}X_2
&&\bigl(\because\ \blkref{def_pair_of_matrices_times_column_of_numbers}\bigr)\\
&= \Bigl(\sum_{i=1}^{1} p_{ik}X_i\Bigr) + p_{2k}X_2
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\text{ の }r = 1\text{ の式を右辺から左辺へ}\bigr)\\
&= \sum_{i=1}^{2} p_{ik}X_i
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\text{ の }r+1\text{ の式}\ (r \to 1)\text{ を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "準備 2（",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " を ",
        math(String.raw`\check\psi_\mu^\dagger, \check\psi_\mu`),
        " で書く）。",
        math(String.raw`i, l \in \{1,2\}`),
        " で ",
        math(String.raw`i \neq l`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
\delta_{il}X_i
&= 0_{\mathbb{C}}X_i
&&\bigl(\because\ \blkref{def_kronecker_delta}\ (n \to 2)\bigr)\\
&= O
&&\bigl(\because\ \blkref{zero_scalar_multiple_is_zero_matrix}\ (m, n \to 2^{M_{\mathrm{col}}})\bigr)
\end{aligned}`),
      paragraph([
        "である（",
        math(String.raw`O`),
        " は ",
        ref("def_zero_matrix"),
        " の零行列 ",
        math(String.raw`O \in R`),
        "）。これを使って、",
        math(String.raw`l \in \{1,2\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
X_l
&= 1_{\mathbb{C}}X_l
&&\bigl(\because\ \blkref{scalar_multiple_by_one}\text{ を右辺から左辺へ}\bigr)\\
&= \delta_{ll}X_l
&&\bigl(\because\ \blkref{def_kronecker_delta}\ (n \to 2)\text{ を右辺から左辺へ}\bigr)\\
&= \sum_{i=1}^{2} \delta_{il}X_i
&&\bigl(\because\ \blkref{finite_sum_of_matrices_with_single_nonzero_term}\text{（和の添字 }a\text{ を }i\text{ に、項 }X_a\text{ を }\delta_{al}X_a\text{ に、定理の }r, q\text{ を }2, l\text{ に取る）を右辺から左辺へ。}i \neq l\text{ の項が }O\text{ であることは上の鎖}\bigr)\\
&= \sum_{i=1}^{2} \left(I_{\mathrm{Mat}(2,\mathbb{C})}\right)_{il}X_i
&&\bigl(\because\ \blkref{def_identity_matrix}\ (n \to 2)\text{ を右辺から左辺へ、}i = 1, 2\text{ の 2 か所へ同時適用}\bigr)\\
&= \sum_{i=1}^{2} \left(\check{P}_\mu\check{P}_\mu^{-1}\right)_{il}X_i
&&\bigl(\because\ \blkref{def_invertible_elements_of_R}\ (M \to 1)\text{ の }\check{P}_\mu\check{P}_\mu^{-1} = I_{\mathrm{Mat}(2,\mathbb{C})}\text{ を右辺から左辺へ、}i = 1, 2\text{ の 2 か所へ同時適用}\bigr)\\
&= \sum_{i=1}^{2} \Bigl(\sum_{k=1}^{2} p_{ik}q_{kl}\Bigr)X_i
&&\bigl(\because\ \blkref{mat_mult}\text{ を }i = 1, 2\text{ の 2 か所へ同時適用}\bigr)\\
&= \sum_{i=1}^{2} \Bigl(\sum_{k=1}^{2} q_{kl}p_{ik}\Bigr)X_i
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\text{ の乗法の可換則を 4 か所へ同時適用}\bigr)\\
&= \sum_{i=1}^{2} \sum_{k=1}^{2} \left(q_{kl}p_{ik}\right)X_i
&&\bigl(\because\ \blkref{finite_sum_of_scalar_multiples_of_one_matrix}\text{ を右辺から左辺へ、}i = 1, 2\text{ の 2 か所へ同時適用}\bigr)\\
&= \sum_{i=1}^{2} \sum_{k=1}^{2} q_{kl}\left(p_{ik}X_i\right)
&&\bigl(\because\ \blkref{scalar_multiple_is_associative}\text{ を右辺から左辺へ、4 か所へ同時適用}\bigr)\\
&= \sum_{k=1}^{2} \sum_{i=1}^{2} q_{kl}\left(p_{ik}X_i\right)
&&\bigl(\because\ \blkref{finite_double_sum_of_matrices_interchange}\bigr)\\
&= \sum_{k=1}^{2} q_{kl}\Bigl(\sum_{i=1}^{2} p_{ik}X_i\Bigr)
&&\bigl(\because\ \blkref{finite_sum_of_scalar_multiples}\text{ を }k = 1, 2\text{ の 2 か所へ同時適用}\bigr)\\
&= \sum_{k=1}^{2} q_{kl}\Psi_k
&&\bigl(\because\ \text{準備 1 を右辺から左辺へ、}k = 1, 2\text{ の 2 か所へ同時適用}\bigr)\\
&= \Bigl(\sum_{k=1}^{1} q_{kl}\Psi_k\Bigr) + q_{2l}\Psi_2
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\text{ の }r+1\text{ の式}\ (r \to 1)\bigr)\\
&= q_{1l}\Psi_1 + q_{2l}\Psi_2
&&\bigl(\because\ \blkref{def_finite_sum_of_matrices}\text{ の }r = 1\text{ の式}\bigr)
\end{aligned}`),
      paragraph([
        "準備 3（二つの写像を共役として読む）。",
        ref("V_plus_factors_invertible"),
        " により ",
        math(String.raw`V^{(+)} \in R^\times`),
        " で、",
        ref("T_V_plus_is_conjugation"),
        " により写像として ",
        math(String.raw`T_{(V^{(+)})} = T_{V^{(+)}}`),
        " である。",
        ref("def_check_Vprime"),
        " (2) により ",
        math(String.raw`\check{V}' \in R^\times`),
        " で、",
        math(String.raw`T_{(\check{V}')}`),
        " は ",
        ref("def_T_g"),
        "（",
        math(String.raw`M \to M_{\mathrm{col}}`),
        "）の ",
        math(String.raw`\check{V}'`),
        " による共役 ",
        math(String.raw`T_{\check{V}'}`),
        " そのもの（",
        math(String.raw`T_{(\check{V}')} = T_{\check{V}'}`),
        "）である。",
      ]),
      paragraph([
        "本体。",
        math(String.raw`l \in \{1,2\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
T_{(V^{(+)})}\!\left(X_l\right)
&= T_{(V^{(+)})}\!\left(q_{1l}\Psi_1 + q_{2l}\Psi_2\right)
&&\bigl(\because\ \text{準備 2}\bigr)\\
&= T_{V^{(+)}}\!\left(q_{1l}\Psi_1 + q_{2l}\Psi_2\right)
&&\bigl(\because\ \blkref{T_V_plus_is_conjugation}\bigr)\\
&= q_{1l}\,T_{V^{(+)}}\!\left(\Psi_1\right) + q_{2l}\,T_{V^{(+)}}\!\left(\Psi_2\right)
&&\bigl(\because\ \blkref{linearity_of_T}\ (M \to M_{\mathrm{col}},\ g \to V^{(+)},\ a \to q_{1l},\ b \to q_{2l},\ X \to \Psi_1,\ W \to \Psi_2)\bigr)\\
&= q_{1l}\,T_{(V^{(+)})}\!\left(\Psi_1\right) + q_{2l}\,T_{(V^{(+)})}\!\left(\Psi_2\right)
&&\bigl(\because\ \blkref{T_V_plus_is_conjugation}\text{ を右辺から左辺へ、2 か所へ同時適用}\bigr)\\
&= q_{1l}\left(\left(\exp(+\gamma(\tilde\theta_\mu))\right)_{\mathbb{C}}\Psi_1\right)
   + q_{2l}\left(\left(\exp(-\gamma(\tilde\theta_\mu))\right)_{\mathbb{C}}\Psi_2\right)
&&\bigl(\because\ \blkref{commutation_V_plus_check_psi}\text{ の二つの式}\bigr)\\
&= q_{1l}\,T_{(\check{V}')}\!\left(\Psi_1\right) + q_{2l}\,T_{(\check{V}')}\!\left(\Psi_2\right)
&&\bigl(\because\ \blkref{action_of_T_check_Vprime_on_check_psi}\text{ の二つの式を右辺から左辺へ}\bigr)\\
&= q_{1l}\,T_{\check{V}'}\!\left(\Psi_1\right) + q_{2l}\,T_{\check{V}'}\!\left(\Psi_2\right)
&&\bigl(\because\ \blkref{def_check_Vprime}\ (2)\text{ の }T_{(\check{V}')} = T_{\check{V}'}\text{ を 2 か所へ同時適用}\bigr)\\
&= T_{\check{V}'}\!\left(q_{1l}\Psi_1 + q_{2l}\Psi_2\right)
&&\bigl(\because\ \blkref{linearity_of_T}\ (M \to M_{\mathrm{col}},\ g \to \check{V}',\ a \to q_{1l},\ b \to q_{2l},\ X \to \Psi_1,\ W \to \Psi_2)\text{ を右辺から左辺へ}\bigr)\\
&= T_{(\check{V}')}\!\left(q_{1l}\Psi_1 + q_{2l}\Psi_2\right)
&&\bigl(\because\ \blkref{def_check_Vprime}\ (2)\text{ の }T_{(\check{V}')} = T_{\check{V}'}\text{ を右辺から左辺へ}\bigr)\\
&= T_{(\check{V}')}\!\left(X_l\right)
&&\bigl(\because\ \text{準備 2 を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`l = 1`),
        " が第 1 の式（",
        math(String.raw`X_1 = \check{Z}_\mu`),
        "）、",
        math(String.raw`l = 2`),
        " が第 2 の式（",
        math(String.raw`X_2 = \check{Y}_\mu`),
        "）である。この証明は新たに ",
        math(String.raw`\mathbb{R}`),
        " を持ち込まない。",
        math(String.raw`\mathbb{R}`),
        " を経て作られた値は、引くブロックが宣言した脱出をそのまま引き継ぐ。",
        math(String.raw`p_{kl}, q_{kl}`),
        " は ",
        math(String.raw`|\gamma_2(\tilde\theta_\mu)|`),
        " と ",
        math(String.raw`\sqrt{M_{\mathrm{col}}}`),
        " を通して ",
        ref("diagonalization_check_P_D"),
        "・",
        ref("def_check_fermi"),
        " から、本体の第 5 式の ",
        math(String.raw`\exp(\pm\gamma(\tilde\theta_\mu))`),
        " は実対数による arccosh（",
        ref("def_gamma_theta"),
        "）と実数の指数評価を通して ",
        ref("commutation_V_plus_check_psi"),
        "・",
        ref("action_of_T_check_Vprime_on_check_psi"),
        " から、",
        math(String.raw`\check{V}' = \exp(\check{X})`),
        " は ",
        ref("def_exp"),
        " の極限を通して ",
        ref("def_check_Vprime"),
        " から引き継ぐ。この証明の中の計算は ",
        math(String.raw`\mathbb{C}`),
        " と ",
        math(String.raw`R`),
        " の演算だけで閉じる。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の T_V_eq_T_Vprime_on_hatZ_hatY の半整数運動量版。008 章は γ_2(θ_μ) = 0 のとき ψ が存在しないため" +
          "「場合 2」（A(θ_μ) = I と T_Vprime_fixes_hatZ_hatY_when_gamma2_zero を経由）を必要としたが、" +
          "gamma_2_theta_tilde_nonzero によりその場合は起こらないので、008 章の「場合 1」に相当する議論だけで尽きる。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_05。",
        "2026-08-19 の式変形統一で、Step 1 の行末根拠を人間可読な名前へ直し、成分表示に根拠を補い、" +
          "Step 2 の二つの一致を各作用の固有値表示を介する鎖へ開き、Step 3 の鎖の両端に根拠を補って、" +
          "Y 成分の「同じ計算」を Z 成分と同形の鎖へ開いた。内容と参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-11-03: 全証明の SageMath 検算（sagemath/check/T_V_plus_eq_T_check_Vprime_on_check_Z_Y）を付けるにあたり、" +
          "Step 1 が commutation_V_plus_check_psi の証明の中の結合律と名前だけの「行ベクトルと 2×2 行列の積の結合法則」・" +
          "未証明の (A, B)I = (A, B) を使っていたのを、準備 1（ψ̌ の成分表示）と準備 2（P̌P̌^{-1} = I から Ž, Y̌ を ψ̌ で書く 14 個の等号の鎖）に替え、" +
          "Step 2・Step 3 を一本の鎖（本体）にまとめた。Step 2 の旧い exp(±γ) を (exp(±γ))_C にそろえ、T_{(V̌')} = T_{V̌'} を def_check_Vprime (2) から引き、" +
          "ℝ への脱出がどのブロックから引き継がれるかを書いた。主張の中身は変えていない。",
      ],
    },
  },
  {
    id: "evenfermi_008_claim_T_eq",
    kind: "claim",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 10 },
    title: { tex: String.raw`T_{(V^{(+)})} = T_{(\check{V}')}` },
    labels: ["T_V_plus_eq_T_check_Vprime"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。すべての ",
        math(String.raw`x \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`T_{(V^{(+)})}(x) = T_{(\check{V}')}(x)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取った ",
        math(String.raw`R := \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と ",
        math(String.raw`R^\times`),
        "、",
        math(String.raw`I := I_{R}`),
        "（",
        ref("def_identity_matrix"),
        "）を用いる。",
        ref("V_plus_factors_invertible"),
        " により ",
        math(String.raw`V^{(+)} \in R^\times`),
        "、",
        ref("def_check_Vprime"),
        " (2) により ",
        math(String.raw`\check{V}' \in R^\times`),
        " である。",
        math(String.raw`g \in R^\times`),
        " について、",
        ref("mat_conj"),
        " の ",
        math(String.raw`n`),
        " を ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        "、その変数 ",
        math(String.raw`B`),
        " を ",
        math(String.raw`g`),
        " に取った写像を ",
        math(String.raw`T'_g : R \to R`),
        "、",
        math(String.raw`T'_g(X) := (gX)g^{-1}`),
        " と書く（",
        ref("def_T_g"),
        " の ",
        math(String.raw`T_g`),
        " と記号で区別するため）。",
        math(String.raw`g^{-1}`),
        " は ",
        ref("def_invertible_elements_of_R"),
        " の逆元で ",
        math(String.raw`gg^{-1} = I`),
        " かつ ",
        math(String.raw`g^{-1}g = I`),
        " を満たすので、",
        math(String.raw`g`),
        " は ",
        ref("mat_conj"),
        "・",
        ref("conjugation_is_ring_homomorphism"),
        " の意味で正則であり、",
        math(String.raw`g^{-1}`),
        " はそこでの逆行列でもある。",
        ref("def_T_g"),
        " の ",
        math(String.raw`g \cdot h \cdot g^{-1}`),
        " と ",
        ref("def_check_Vprime"),
        " (2) の ",
        math(String.raw`\check{V}'\,W\,(\check{V}')^{-1}`),
        " は、",
        ref("linearity_of_T"),
        " の証明と同じく左から順に ",
        math(String.raw`(gh)g^{-1}`),
        "・",
        math(String.raw`(\check{V}'W)(\check{V}')^{-1}`),
        " と読む。",
      ]),
      paragraph([
        "準備 1（二つの写像を ",
        ref("mat_conj"),
        " の共役として読む）。任意の ",
        math(String.raw`X \in R`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
T_{(V^{(+)})}(X)
&= T_{V^{(+)}}(X)
&&\bigl(\because\ \blkref{T_V_plus_is_conjugation}\bigr)\\
&= \left(V^{(+)}X\right)\left(V^{(+)}\right)^{-1}
&&\bigl(\because\ \blkref{def_T_g}\ (M \to M_{\mathrm{col}},\ g \to V^{(+)})\bigr)\\
&= T'_{V^{(+)}}(X)
&&\bigl(\because\ T'_g\text{ の定め方}\ (g \to V^{(+)})\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
T_{(\check{V}')}(X)
&= \left(\check{V}'X\right)\left(\check{V}'\right)^{-1}
&&\bigl(\because\ \blkref{def_check_Vprime}\ (2)\ (W \to X)\bigr)\\
&= T'_{\check{V}'}(X)
&&\bigl(\because\ T'_g\text{ の定め方}\ (g \to \check{V}')\bigr)
\end{aligned}`),
      paragraph([
        "準備 2（復元公式の記号）。",
        ref("recover_Z_Y_from_check_Z_Y"),
        " の ",
        math(String.raw`N := (M_{\mathrm{col}})_{\mathbb N} \in \mathbb{N}_{\geq 2}`),
        "、像の記号 ",
        math(String.raw`j_{\mathbb Z}, j_{\mathbb R}, \mu_{\mathbb Z}`),
        "、",
        math(String.raw`\tilde\theta_{\mu_{\mathbb Z}} \in \mathbb{R}`),
        " と ",
        math(String.raw`(M_{\mathrm{col}})_{\mathbb C}^{-1} \in \mathbb{C}`),
        " を用いる。",
        math(String.raw`j, \mu \in \{1,\dots,N\}`),
        " について ",
        math(String.raw`c := (M_{\mathrm{col}})_{\mathbb C}^{-1} \in \mathbb{C}`),
        "、",
        math(String.raw`a_{j\mu} := \exp\!\left(i\,(j_{\mathbb R}\tilde\theta_{\mu_{\mathbb Z}})_{\mathbb C}\right) \in \mathbb{C}`),
        " と置く（",
        math(String.raw`\tilde\theta_{\mu_{\mathbb Z}}`),
        " は ",
        math(String.raw`\pi`),
        " を含む実数で、",
        math(String.raw`\exp`),
        " は ",
        ref("def_scalar_exp"),
        " の級数の極限なので、ここで ",
        math(String.raw`\mathbb{R}`),
        " を使う。値はすでに ",
        ref("recover_Z_Y_from_check_Z_Y"),
        " が定めたものをそのまま使う）。",
        math(String.raw`\mu \in \{1,\dots,N\}`),
        " のとき ",
        math(String.raw`\mu_{\mathbb Z} \in \{1,\dots,M_{\mathrm{col}}\} = \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）である。",
        math(String.raw`W \in \{\check{Z}, \check{Y}\}`),
        "、",
        math(String.raw`U \in \{Z, Y\}`),
        " を対応させて（",
        math(String.raw`W = \check{Z}`),
        " のとき ",
        math(String.raw`U = Z`),
        "、",
        math(String.raw`W = \check{Y}`),
        " のとき ",
        math(String.raw`U = Y`),
        "）、",
        ref("recover_Z_Y_from_check_Z_Y"),
        " の二つの式を一つに",
      ]),
      displayMath(String.raw`c\sum_{\mu=1}^{N} a_{j\mu}W_{\mu_{\mathbb Z}} = U_{j_{\mathbb Z}}`),
      paragraph(["と書く（以下「復元公式」）。"]),
      paragraph([
        "Step 1（",
        math(String.raw`Z_{j_{\mathbb Z}}, Y_{j_{\mathbb Z}}`),
        " 上で一致）。",
        math(String.raw`j \in \{1,\dots,N\}`),
        " と、準備 2 の対応する組 ",
        math(String.raw`(W, U)`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
T_{(V^{(+)})}\!\left(U_{j_{\mathbb Z}}\right)
&= T_{(V^{(+)})}\!\left(c\sum_{\mu=1}^{N} a_{j\mu}W_{\mu_{\mathbb Z}}\right)
&&\bigl(\because\ \text{復元公式を右辺から左辺へ}\bigr)\\
&= T'_{V^{(+)}}\!\left(c\sum_{\mu=1}^{N} a_{j\mu}W_{\mu_{\mathbb Z}}\right)
&&\bigl(\because\ \text{準備 1 の第 1 の鎖}\bigr)\\
&= c\,T'_{V^{(+)}}\!\left(\sum_{\mu=1}^{N} a_{j\mu}W_{\mu_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{mat_conj}\text{ のスカラー倍の式}\ (\alpha \to c)\bigr)\\
&= c\sum_{\mu=1}^{N} T'_{V^{(+)}}\!\left(a_{j\mu}W_{\mu_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{matrix_conjugation_preserves_finite_sum}\ (n \to 2^{M_{\mathrm{col}}},\ B \to V^{(+)},\ r \to N,\ (X_1,\dots,X_r) \to (a_{j1}W_{1_{\mathbb Z}},\dots,a_{jN}W_{N_{\mathbb Z}}))\bigr)\\
&= c\sum_{\mu=1}^{N} a_{j\mu}\,T'_{V^{(+)}}\!\left(W_{\mu_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{mat_conj}\text{ のスカラー倍の式を }N\text{ 個の項へ同時適用}\bigr)\\
&= c\sum_{\mu=1}^{N} a_{j\mu}\,T_{(V^{(+)})}\!\left(W_{\mu_{\mathbb Z}}\right)
&&\bigl(\because\ \text{準備 1 の第 1 の鎖を右辺から左辺へ、}N\text{ 個の項へ同時適用}\bigr)\\
&= c\sum_{\mu=1}^{N} a_{j\mu}\,T_{(\check{V}')}\!\left(W_{\mu_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{T_V_plus_eq_T_check_Vprime_on_check_Z_Y}\ (\mu \to \mu_{\mathbb Z} \in \check{\mathcal{M}})\text{ を }N\text{ 個の項へ同時適用}\bigr)\\
&= c\sum_{\mu=1}^{N} a_{j\mu}\,T'_{\check{V}'}\!\left(W_{\mu_{\mathbb Z}}\right)
&&\bigl(\because\ \text{準備 1 の第 2 の鎖を }N\text{ 個の項へ同時適用}\bigr)\\
&= c\sum_{\mu=1}^{N} T'_{\check{V}'}\!\left(a_{j\mu}W_{\mu_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{mat_conj}\text{ のスカラー倍の式を右辺から左辺へ、}N\text{ 個の項へ同時適用}\bigr)\\
&= c\,T'_{\check{V}'}\!\left(\sum_{\mu=1}^{N} a_{j\mu}W_{\mu_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{matrix_conjugation_preserves_finite_sum}\ (n \to 2^{M_{\mathrm{col}}},\ B \to \check{V}',\ r \to N,\ (X_1,\dots,X_r) \to (a_{j1}W_{1_{\mathbb Z}},\dots,a_{jN}W_{N_{\mathbb Z}}))\text{ を右辺から左辺へ}\bigr)\\
&= T'_{\check{V}'}\!\left(c\sum_{\mu=1}^{N} a_{j\mu}W_{\mu_{\mathbb Z}}\right)
&&\bigl(\because\ \blkref{mat_conj}\text{ のスカラー倍の式}\ (\alpha \to c)\text{ を右辺から左辺へ}\bigr)\\
&= T_{(\check{V}')}\!\left(c\sum_{\mu=1}^{N} a_{j\mu}W_{\mu_{\mathbb Z}}\right)
&&\bigl(\because\ \text{準備 1 の第 2 の鎖を右辺から左辺へ}\bigr)\\
&= T_{(\check{V}')}\!\left(U_{j_{\mathbb Z}}\right)
&&\bigl(\because\ \text{復元公式}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`(W, U) = (\check{Z}, Z)`),
        " が ",
        math(String.raw`Z_{j_{\mathbb Z}}`),
        " での一致、",
        math(String.raw`(W, U) = (\check{Y}, Y)`),
        " が ",
        math(String.raw`Y_{j_{\mathbb Z}}`),
        " での一致である。",
        math(String.raw`j`),
        " が ",
        math(String.raw`\{1,\dots,N\}`),
        " を動くとき ",
        math(String.raw`j_{\mathbb Z}`),
        " は ",
        math(String.raw`\{1,\dots,M_{\mathrm{col}}\}`),
        " を動く。",
      ]),
      paragraph(["Step 2（一致する元の集合は閉じている）。"]),
      displayMath(
        String.raw`\mathcal{E} := \left\{\,x \in R\ :\ T_{(V^{(+)})}(x) = T_{(\check{V}')}(x)\,\right\}`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`x, y \in \mathcal{E}`),
        "、",
        math(String.raw`\alpha \in \mathbb{C}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
T_{(V^{(+)})}(x + y)
&= T'_{V^{(+)}}(x + y)
&&\bigl(\because\ \text{準備 1 の第 1 の鎖}\bigr)\\
&= T'_{V^{(+)}}(x) + T'_{V^{(+)}}(y)
&&\bigl(\because\ \blkref{mat_conj}\text{ の和の式}\bigr)\\
&= T_{(V^{(+)})}(x) + T_{(V^{(+)})}(y)
&&\bigl(\because\ \text{準備 1 の第 1 の鎖を右辺から左辺へ、2 か所へ同時適用}\bigr)\\
&= T_{(\check{V}')}(x) + T_{(\check{V}')}(y)
&&\bigl(\because\ x, y \in \mathcal{E}\bigr)\\
&= T'_{\check{V}'}(x) + T'_{\check{V}'}(y)
&&\bigl(\because\ \text{準備 1 の第 2 の鎖を 2 か所へ同時適用}\bigr)\\
&= T'_{\check{V}'}(x + y)
&&\bigl(\because\ \blkref{mat_conj}\text{ の和の式を右辺から左辺へ}\bigr)\\
&= T_{(\check{V}')}(x + y)
&&\bigl(\because\ \text{準備 1 の第 2 の鎖を右辺から左辺へ}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
T_{(V^{(+)})}(\alpha x)
&= T'_{V^{(+)}}(\alpha x)
&&\bigl(\because\ \text{準備 1 の第 1 の鎖}\bigr)\\
&= \alpha\,T'_{V^{(+)}}(x)
&&\bigl(\because\ \blkref{mat_conj}\text{ のスカラー倍の式}\bigr)\\
&= \alpha\,T_{(V^{(+)})}(x)
&&\bigl(\because\ \text{準備 1 の第 1 の鎖を右辺から左辺へ}\bigr)\\
&= \alpha\,T_{(\check{V}')}(x)
&&\bigl(\because\ x \in \mathcal{E}\bigr)\\
&= \alpha\,T'_{\check{V}'}(x)
&&\bigl(\because\ \text{準備 1 の第 2 の鎖}\bigr)\\
&= T'_{\check{V}'}(\alpha x)
&&\bigl(\because\ \blkref{mat_conj}\text{ のスカラー倍の式を右辺から左辺へ}\bigr)\\
&= T_{(\check{V}')}(\alpha x)
&&\bigl(\because\ \text{準備 1 の第 2 の鎖を右辺から左辺へ}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
T_{(V^{(+)})}(xy)
&= T'_{V^{(+)}}(xy)
&&\bigl(\because\ \text{準備 1 の第 1 の鎖}\bigr)\\
&= T'_{V^{(+)}}(x)\,T'_{V^{(+)}}(y)
&&\bigl(\because\ \blkref{conjugation_is_ring_homomorphism}\text{ の乗法性}\ (B \to V^{(+)})\bigr)\\
&= T_{(V^{(+)})}(x)\,T_{(V^{(+)})}(y)
&&\bigl(\because\ \text{準備 1 の第 1 の鎖を右辺から左辺へ、2 か所へ同時適用}\bigr)\\
&= T_{(\check{V}')}(x)\,T_{(\check{V}')}(y)
&&\bigl(\because\ x, y \in \mathcal{E}\bigr)\\
&= T'_{\check{V}'}(x)\,T'_{\check{V}'}(y)
&&\bigl(\because\ \text{準備 1 の第 2 の鎖を 2 か所へ同時適用}\bigr)\\
&= T'_{\check{V}'}(xy)
&&\bigl(\because\ \blkref{conjugation_is_ring_homomorphism}\text{ の乗法性}\ (B \to \check{V}')\text{ を右辺から左辺へ}\bigr)\\
&= T_{(\check{V}')}(xy)
&&\bigl(\because\ \text{準備 1 の第 2 の鎖を右辺から左辺へ}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
T_{(V^{(+)})}(I)
&= T'_{V^{(+)}}(I)
&&\bigl(\because\ \text{準備 1 の第 1 の鎖}\bigr)\\
&= I
&&\bigl(\because\ \blkref{conjugation_is_ring_homomorphism}\text{ の単位性}\ (B \to V^{(+)})\bigr)\\
&= T'_{\check{V}'}(I)
&&\bigl(\because\ \blkref{conjugation_is_ring_homomorphism}\text{ の単位性}\ (B \to \check{V}')\text{ を右辺から左辺へ}\bigr)\\
&= T_{(\check{V}')}(I)
&&\bigl(\because\ \text{準備 1 の第 2 の鎖を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "よって ",
        math(String.raw`x + y,\ \alpha x,\ xy,\ I \in \mathcal{E}`),
        " である。Step 1 より ",
        math(String.raw`Z_1,\dots,Z_{M_{\mathrm{col}}},Y_1,\dots,Y_{M_{\mathrm{col}}} \in \mathcal{E}`),
        " でもあるから、",
        math(String.raw`\mathcal{E}`),
        " は ",
        ref("Z_Y_generate_algebra"),
        " の意味で閉じている（(i) は Step 1、(ii) は ",
        math(String.raw`I \in \mathcal{E}`),
        "、(iii) は ",
        math(String.raw`x + y, \alpha x \in \mathcal{E}`),
        "、(iv) は ",
        math(String.raw`xy \in \mathcal{E}`),
        "）。",
      ]),
      paragraph([
        "Step 3（結論）。",
        ref("Z_Y_generate_algebra"),
        " の ",
        math(String.raw`\mathcal{A}`),
        " は閉じている部分集合のうち最小のものなので、Step 2 より ",
        math(String.raw`\mathcal{A} \subseteq \mathcal{E}`),
        " である。",
        ref("Z_Y_generate_algebra"),
        " より ",
        math(String.raw`\mathcal{A} = R`),
        " であり、",
        math(String.raw`\mathcal{E}`),
        " の定め方より ",
        math(String.raw`\mathcal{E} \subseteq R`),
        " であるから",
      ]),
      displayMath(String.raw`R = \mathcal{A} \subseteq \mathcal{E} \subseteq R`),
      paragraph([
        "すなわち ",
        math(String.raw`\mathcal{E} = R`),
        "。これが主張である。この証明は新たに ",
        math(String.raw`\mathbb{R}`),
        " を持ち込まない。",
        math(String.raw`\tilde\theta_{\mu_{\mathbb Z}} \in \mathbb{R}`),
        " と ",
        math(String.raw`\exp`),
        " の値は ",
        ref("recover_Z_Y_from_check_Z_Y"),
        " から、",
        math(String.raw`\check{V}' = \exp(\check{X})`),
        " は ",
        ref("def_exp"),
        " の極限と実対数による arccosh を通して ",
        ref("def_check_Vprime"),
        " から、",
        math(String.raw`\mathbb{R}`),
        " への脱出を引き継ぐ。この証明の中の計算は ",
        math(String.raw`\mathbb{C}`),
        " と ",
        math(String.raw`R`),
        " の演算だけで閉じる。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の T_V_eq_T_Vprime の半整数運動量版。復元公式が recover_Z_Y_from_hatZ_hatY から " +
          "recover_Z_Y_from_check_Z_Y（半整数運動量版）へ差し替わるほかは同じ議論である。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_05（Z_m, Y_m だけでなく、" +
          "行列単位 e_{ij} 全体（2^M × 2^M 個）についても両者の共役が一致することを直接確認）。",
        "2026-11-03: 全証明の SageMath 検算（sagemath/check/T_V_plus_eq_T_check_Vprime/）を付けるにあたり、証明を一ステップ一定理の鎖にした。" +
          "旧 Step 1 の「単位的環準同型かつ線型」を、def_T_g の T_g・def_check_Vprime (2) の T_{(V̌')} と mat_conj の T'_g を記号で分けて結ぶ準備 1 の二つの鎖に替えた" +
          "（mat_conj・matrix_conjugation_preserves_finite_sum・conjugation_is_ring_homomorphism は T'_g についての主張なので）。" +
          "復元公式を recover_Z_Y_from_check_Z_Y の主張の形（(M_col)_C^{-1} を左から掛け、係数 exp(i(j_R θ̃_{μ_Z})_C) を左に置く）にそろえ、" +
          "旧 Step 2 の「Step 1 の線型性」1 行に束ねていた (M_col)_C^{-1} 倍・有限和・各項のスカラー倍を 13 個の等号の鎖に開いた。" +
          "旧 Step 3 の αx + βy の閉包を、Z_Y_generate_algebra の (iii) に合わせて和とスカラー倍の二つの鎖に分け、各行の根拠を準備 1 と mat_conj・conjugation_is_ring_homomorphism から引いた。" +
          "Step 4 の「Step 3 より A ⊆ E」に、E が Z_Y_generate_algebra の意味で閉じていることと A の最小性を書き、ℝ への脱出の引き継ぎ元を書いた。主張の中身は変えていない。",
      ],
    },
  },
  {
    id: "evenfermi_009_claim_V_plus_eq_c_Vprime",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/016_even_sector_fermions.ts", ordinal: 11 },
    title: { tex: String.raw`V^{(+)} = c\,\check{V}' \text{（定数倍を除いて一致）}` },
    labels: ["V_plus_eq_c_check_Vprime"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。ある ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " が存在して",
      ]),
      displayMath(String.raw`V^{(+)} = c\,\check{V}'`),
      paragraph([
        "が成り立つ（",
        math(String.raw`V^{(+)}`),
        " は ",
        ref("def_V_plus"),
        "、",
        math(String.raw`\check{V}'`),
        " は ",
        ref("def_check_Vprime"),
        "）。**",
        math(String.raw`c`),
        " の値の決定はここでは行わない。**",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`W := \left(\check{V}'\right)^{-1}V^{(+)}`),
        " は可逆）。",
        ref("V_plus_factors_invertible"),
        " より ",
        math(String.raw`V^{(+)}`),
        " は可逆、",
        ref("def_check_Vprime"),
        " (2) より ",
        math(String.raw`\check{V}'`),
        " は可逆であり、可逆行列の逆行列も可逆である（",
        ref("def_invertible_elements_of_R"),
        "）。可逆行列の積は可逆なので ",
        math(String.raw`W`),
        " は可逆であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{V}'\,W
&= \check{V}'\left(\left(\check{V}'\right)^{-1}V^{(+)}\right)
   \quad (\because W := \left(\check{V}'\right)^{-1}V^{(+)}) \\
&= \left(\check{V}'\left(\check{V}'\right)^{-1}\right)V^{(+)}
   \quad (\because \text{行列の積の結合律}) \\
&= I\,V^{(+)}
   \quad (\because \text{可逆元の定義}) \\
&= V^{(+)}
   \quad (\because \text{行列積の単位元})
\end{aligned}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`W`),
        " はすべての元と可換）。",
        ref("T_V_plus_eq_T_check_Vprime"),
        "、",
        ref("T_V_plus_is_conjugation"),
        "、",
        ref("def_check_Vprime"),
        " (2)、",
        ref("def_T_g"),
        " より、任意の ",
        math(String.raw`x \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}\,x\,\left(V^{(+)}\right)^{-1}
&= T_{(V^{(+)})}(x)
   \quad (\because \text{転送行列が定める共役作用}) \\
&= T_{(\check{V}')}(x)
   \quad (\because \text{二つの共役作用の一致}) \\
&= \check{V}'\,x\,\left(\check{V}'\right)^{-1}
   \quad (\because \text{転送行列が定める共役作用})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("conjugation_is_ring_homomorphism"),
        " の ",
        math(String.raw`(AB)^{-1} = B^{-1}A^{-1}`),
        " より Step 1 の ",
        math(String.raw`V^{(+)} = \check{V}'W`),
        " から ",
        math(String.raw`\left(V^{(+)}\right)^{-1} = W^{-1}\left(\check{V}'\right)^{-1}`),
        " である。したがって、左辺は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}x\left(V^{(+)}\right)^{-1}
&= \left(\check{V}'W\right)x\left(W^{-1}\left(\check{V}'\right)^{-1}\right)
   \quad (\because \text{Step 1 と積の逆元の公式}) \\
&= \check{V}'\left(W x W^{-1}\right)\left(\check{V}'\right)^{-1}
   \quad (\because \text{行列の積の結合律})
\end{aligned}`,
      ),
      paragraph([
        "と書ける。したがって ",
        math(String.raw`\check{V}'\left(WxW^{-1}\right)\left(\check{V}'\right)^{-1} = \check{V}'x\left(\check{V}'\right)^{-1}`),
        " である。可逆な ",
        math(String.raw`\check V'`),
        " と ",
        math(String.raw`W`),
        " を順に消去すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{V}'\left(WxW^{-1}\right)\left(\check{V}'\right)^{-1}
&= \check{V}'x\left(\check{V}'\right)^{-1}
   \quad (\because \text{上の二つの共役作用の一致}) \\
WxW^{-1}
&= x
   \quad (\because \check V' \text{ の可逆性}) \\
Wx
&= xW
   \quad (\because W \text{ の可逆性})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（スカラーであること）。Step 2 と ",
        ref("centralizer_is_scalar"),
        " より、ある ",
        math(String.raw`c \in \mathbb{C}`),
        " が存在して ",
        math(String.raw`W = c\,I`),
        "。",
      ]),
      paragraph([
        "Step 4（",
        math(String.raw`c \neq 0`),
        "）。仮に ",
        math(String.raw`c = 0`),
        " なら ",
        math(String.raw`W = O`),
        "（零行列）だが、任意の ",
        math(String.raw`A`),
        " について ",
        math(String.raw`OA = O \neq I`),
        " なので ",
        math(String.raw`O`),
        " は可逆でなく、Step 1 に矛盾する。よって ",
        math(String.raw`c \in \mathbb{C}^\times`),
        "。",
      ]),
      paragraph([
        "Step 5（結論）。Step 1 と Step 3、およびスカラー行列との積の可換性（",
        ref("scalar_identity_commutes"),
        "）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}
&= \check{V}'W
   \quad (\because \text{Step 1}) \\
&= \check{V}'\left(c\,I\right)
   \quad (\because \text{Step 3}) \\
&= c\left(\check{V}'I\right)
   \quad (\because \text{スカラー行列との積の可換性}) \\
&= c\,\check{V}'
   \quad (\because \text{行列積の単位元 } \check{V}'I = \check{V}')
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の V_eq_Vprime の半整数運動量版。008 章と同じく centralizer_is_scalar を用いる筋であり、" +
          "クリフォード群（def_clifford_group / V2_not_in_clifford_group）には依存しない。",
        "数値検証: sagemath/check/049_claim_even_sector_fermions/check_06（W = (V̌')^{-1} V^{(+)} がスカラー行列に" +
          "なることを確認し、その c が (2 sinh 2K_2)^{M/2} に一致することも併せて確認した。" +
          "ただし c の値そのものの証明は本章では行わない）。",
      ],
    },
  },
  {
    id: "evenEigen_001_definition_check_number_operator",
    kind: "definition",
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 3 },
    title: { tex: String.raw`\check{n}_\mu := \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu} \text{ の定義}` },
    labels: ["def_check_number_operator"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）とする。",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M_{\mathrm{col}}+1-\mu \in \check{\mathcal{M}}`),
        " なので、",
        ref("def_check_fermi"),
        " により ",
        math(String.raw`\check\psi_\mu^\dagger`),
        " と ",
        math(String.raw`\check\psi_{M_{\mathrm{col}}+1-\mu}`),
        " は**ともに定義されている**。そこで",
      ]),
      displayMath(
        String.raw`\check{n}_\mu := \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}
\ \in\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})
\qquad (\mu \in \check{\mathcal{M}})`,
      ),
      paragraph([
        "と定める。以下、",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 次の単位行列 ",
        math(String.raw`I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        " を単に ",
        math(String.raw`I`),
        " と書く。次が成り立つ。",
      ]),
      list([
        [
          "(1) 共役添字の対応 ",
          math(String.raw`\mu \mapsto M_{\mathrm{col}}+1-\mu`),
          " は ",
          math(String.raw`\check{\mathcal{M}}`),
          " から ",
          math(String.raw`\check{\mathcal{M}}`),
          " への写像であり（",
          ref("def_check_index_set"),
          " (2)）、",
          math(String.raw`\check{\mathcal{M}}`),
          " 上の対合である：",
          math(String.raw`M_{\mathrm{col}}+1-(M_{\mathrm{col}}+1-\mu) = \mu`),
          "。",
          math(String.raw`\check{n}_\mu`),
          " は ",
          math(String.raw`\mu \in \check{\mathcal{M}} = \{1, \dots, M_{\mathrm{col}}\}`),
          " の ",
          math(String.raw`M_{\mathrm{col}}`),
          " 個であり、その定義に現れる添字 ",
          math(String.raw`\mu`),
          "・",
          math(String.raw`M_{\mathrm{col}}+1-\mu`),
          " はどちらも ",
          math(String.raw`\check{\mathcal{M}}`),
          " に入る（",
          math(String.raw`\check{\mathcal{M}}`),
          " の外の添字は要らない）。",
        ],
        [
          "(2) ",
          ref("def_check_Vprime"),
          " の ",
          math(String.raw`\check{X}`),
          " と ",
          math(String.raw`\check{V}'`),
          " はこの記号で",
        ],
      ]),
      displayMath(
        String.raw`\check{X} = \sum_{\mu \in \check{\mathcal{M}}} \left(\gamma(\tilde\theta_\mu)\right)_{\mathbb{C}}
\left(\check{n}_\mu - \left(\tfrac12\right)_{\mathbb{C}} I\right),
\qquad
\check{V}' = \exp\!\left(\check{X}\right)`,
      ),
      paragraph([
        "と書ける（",
        math(String.raw`(\cdot)_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の像。",
        ref("def_check_Vprime"),
        " と同じく、以降の本文はこの式を ",
        math(String.raw`\check{X} = \sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check{n}_\mu - \tfrac12 I\right)`),
        " とも書く）。",
        "**",
        math(String.raw`\mu`),
        " は ",
        math(String.raw`\check{\mathcal{M}}`),
        " を例外なく走る**（",
        ref("gamma_2_theta_tilde_nonzero"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) 写像 ",
        math(String.raw`\sigma: \check{\mathcal{M}} \to \check{\mathcal{M}},\ \mu \mapsto M_{\mathrm{col}}+1-\mu`),
        " を置く。",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " の像 ",
        math(String.raw`M_{\mathrm{col}}+1-\mu \in \mathbb{Z}`),
        " は ",
        math(String.raw`\check{\mathcal{M}}`),
        " に入るので、",
        math(String.raw`\sigma`),
        " は写像として定まる。",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " を任意に取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma(\sigma(\mu))
&= M_{\mathrm{col}}+1-\sigma(\mu)
&&(\because\ \sigma\ \text{の定義}\ (\mu \to \sigma(\mu))) \\
&= M_{\mathrm{col}}+1-\left(M_{\mathrm{col}}+1-\mu\right)
&&(\because\ \sigma\ \text{の定義}) \\
&= \left(M_{\mathrm{col}}+1\right)-\left(M_{\mathrm{col}}+1\right)+\mu
&&(\because\ \mathbb{Z}\ \text{の減法}\ a-(b-c) = a-b+c) \\
&= 0+\mu
&&(\because\ \mathbb{Z}\ \text{の加法の逆元}\ a-a = 0) \\
&= \mu
&&(\because\ \mathbb{Z}\ \text{の加法の単位元}\ 0+a = a)
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`\sigma \circ \sigma`),
        " は ",
        math(String.raw`\check{\mathcal{M}}`),
        " 上の恒等写像である。これから ",
        math(String.raw`\sigma`),
        " が全単射であることを示す。単射: ",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        " が ",
        math(String.raw`\sigma(\mu) = \sigma(\nu)`),
        " を満たすとき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mu
&= \sigma(\sigma(\mu))
&&(\because\ \text{上の鎖}) \\
&= \sigma(\sigma(\nu))
&&(\because\ \sigma(\mu) = \sigma(\nu)) \\
&= \nu
&&(\because\ \text{上の鎖}\ (\mu \to \nu))
\end{aligned}`,
      ),
      paragraph([
        "全射: ",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " に対し ",
        math(String.raw`\sigma(\nu) \in \check{\mathcal{M}}`),
        " であり、上の鎖（",
        math(String.raw`\mu \to \nu`),
        "）より ",
        math(String.raw`\sigma(\sigma(\nu)) = \nu`),
        " なので、",
        math(String.raw`\nu`),
        " は ",
        math(String.raw`\sigma(\nu)`),
        " の像である。よって ",
        math(String.raw`\sigma`),
        " は ",
        math(String.raw`\check{\mathcal{M}}`),
        " 上の対合（2 回施すと恒等写像になる全単射）である。",
      ]),
      paragraph([
        "主張 (1) の残りの二つ（",
        math(String.raw`\check{n}_\mu`),
        " の個数と、その添字が ",
        math(String.raw`\check{\mathcal{M}}`),
        " に入ること）は、対合であることではなく ",
        ref("def_check_index_set"),
        " から従う。",
        math(String.raw`\check{\mathcal{M}} = \{1, \dots, M_{\mathrm{col}}\}`),
        " は ",
        math(String.raw`M_{\mathrm{col}}`),
        " 個の元を持つ（",
        ref("def_check_index_set"),
        " の定義）ので、",
        math(String.raw`\check{n}_\mu`),
        "（",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "）は ",
        math(String.raw`M_{\mathrm{col}}`),
        " 個である。",
        math(String.raw`\check{n}_\mu = \check\psi_\mu^\dagger\,\check\psi_{\sigma(\mu)}`),
        " に現れる添字は ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " と、冒頭で ",
        ref("def_check_index_set"),
        " (2) により ",
        math(String.raw`\check{\mathcal{M}}`),
        " に入ると確かめた ",
        math(String.raw`\sigma(\mu)`),
        " である。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " のすべてについて ",
        math(String.raw`\check{n}_\mu`),
        " は定義されている（主張の前置き）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{X}
&= \sum_{\mu \in \check{\mathcal{M}}} \left(\gamma(\tilde\theta_\mu)\right)_{\mathbb{C}}
\left(\check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu} - \left(\tfrac12\right)_{\mathbb{C}} I\right)
&&(\because\ \blkref{def_check_Vprime}\ \text{の}\ \check{X}\ \text{の定義}) \\
&= \sum_{\mu \in \check{\mathcal{M}}} \left(\gamma(\tilde\theta_\mu)\right)_{\mathbb{C}}
\left(\check{n}_\mu - \left(\tfrac12\right)_{\mathbb{C}} I\right)
&&(\because\ \text{各項へ}\ \check{n}_\mu := \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}\ \text{の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\check{V}' = \exp\!\left(\check{X}\right)
\qquad (\because\ \blkref{def_check_Vprime}\ \text{の}\ \check{V}'\ \text{の定義})`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の def_number_operator の半整数運動量版。対になる添字は −μ ではなく M+1−μ である（conjugate_index_of_check_Z_Y、def_check_index_set (2)）。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_01。対を −μ に取り違えると冪等性が残差 2.59 で破れることも対照として確認した。",
        "2026-11-03: 全証明の SageMath 検算で、証明の (1) を σ(σ(μ)) = μ の等号の鎖と単射・全射の鎖に、(2) を def_check_Vprime の X̌ から始まる鎖に書き直し、主張 (2) の実数係数を包含の像 (·)_C で書いた（中身は不変）。検算は sagemath/check/def_check_number_operator/。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "diagonalization_and_exponential_form_claim_V_plus_eq_c_exp_check_number_operators",
    kind: "claim",
    standing: "mainTheorem",
    title: { tex: String.raw`V^{(+)} = c\,\exp\!\left(\sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check{n}_\mu - \tfrac12 I\right)\right)` },
    labels: ["V_plus_eq_c_exp_sum_gamma_check_number_operator"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_V_plus"),
        " の ",
        math(String.raw`V^{(+)} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "、",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma(\tilde\theta_\mu) \in \mathbb{R}`),
        "（",
        math(String.raw`\mathbb{R}`),
        " に住むのは、",
        ref("def_arccosh"),
        " が逆双曲線余弦を実対数で定めるため）、",
        ref("def_check_number_operator"),
        " の ",
        math(String.raw`\check{n}_\mu \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "（",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "、",
        ref("def_check_index_set"),
        "）と ",
        math(String.raw`I := I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        " について、ある ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " が存在して",
      ]),
      displayMath(
        String.raw`V^{(+)} = c\,\exp\!\left(\sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check{n}_\mu - \tfrac12 I\right)\right)`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`c`),
        " の値の決定はここでは行わない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("V_plus_eq_c_check_Vprime"),
        " により、",
        math(String.raw`V^{(+)} = c\,\check{V}'`),
        " を満たす ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " を取る（",
        math(String.raw`\check{V}'`),
        " は ",
        ref("def_check_Vprime"),
        "）。この ",
        math(String.raw`c`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}
&= c\,\check{V}'
&&(\because\ \blkref{V_plus_eq_c_check_Vprime}) \\
&= c\,\exp\!\left(\check{X}\right)
&&(\because\ \blkref{def_check_Vprime}\ \text{の}\ \check{V}' := \exp(\check{X})) \\
&= c\,\exp\!\left(\sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu} - \tfrac12 I\right)\right)
&&(\because\ \blkref{def_check_Vprime}\ \text{の}\ \check{X}\ \text{の定義}) \\
&= c\,\exp\!\left(\sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check{n}_\mu - \tfrac12 I\right)\right)
&&(\because\ \blkref{def_check_number_operator}\ \text{の}\ \check{n}_\mu := \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、A(θ̃_μ) の対角化と V^{(+)} の指数表示の章のゴールの式を一つの主張として立てた。既存の主張 V_plus_eq_c_check_Vprime に、V̌'・X̌・ň_μ の定義を順に代入するだけで、新しい証明は無い。",
      ],
    },
  },
  {
    id: "diagonalization_and_exponential_form_claim_A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form",
    kind: "claim",
    standing: "mainTheorem",
    title: { tex: String.raw`A(\tilde\theta_\mu)\text{ の対角化、}\lambda_{\pm,\mu} = \exp(\pm\gamma(\tilde\theta_\mu))\text{ と }V^{(+)}\text{ の指数表示}` },
    labels: ["A_theta_tilde_diagonalization_lambda_exp_gamma_and_V_plus_exponential_form"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta) \in \mathrm{Mat}(2,\mathbb{C})`),
        "（",
        math(String.raw`\theta \in \mathbb{R}`),
        "）、",
        ref("eigenvector_of_A_theta_tilde"),
        " の ",
        math(String.raw`\lambda_{\pm,\mu} \in \mathbb{R}`),
        "（",
        math(String.raw`\mathbb{R}`),
        " に住むのは、",
        ref("eigenvector_of_A_theta_tilde"),
        " が ",
        math(String.raw`\lambda_{\pm,\mu}`),
        " を実数の ",
        math(String.raw`\gamma_1(\tilde\theta_\mu)`),
        " と絶対値 ",
        math(String.raw`\left|\gamma_2(\tilde\theta_\mu)\right|`),
        " の和・差で与えるため）、",
        ref("diagonalization_check_P_D"),
        " の ",
        math(String.raw`\check{P}_\mu \in \mathrm{Mat}(2,\mathbb{C})`),
        "、",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma(\theta) \in \mathbb{R}_{\geq 0}`),
        "（",
        math(String.raw`\mathbb{R}`),
        " に住むのは、",
        ref("def_arccosh"),
        " が逆双曲線余弦を実対数で定めるため）、",
        ref("def_second_dual_coupling_constant"),
        " の ",
        math(String.raw`K_2^* \in \mathbb{R}_{>0}`),
        "（",
        math(String.raw`\mathbb{R}`),
        " に住むのは、",
        ref("def_second_dual_coupling_constant"),
        " が ",
        math(String.raw`K_2^*`),
        " を実対数で定めるため）、",
        ref("def_half_integer_checkZ"),
        "・",
        ref("def_half_integer_checkY"),
        " の ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        "、",
        ref("def_check_fermi"),
        " の ",
        math(String.raw`\check\psi_\mu^\dagger, \check\psi_\mu`),
        "、",
        ref("def_check_number_operator"),
        " の ",
        math(String.raw`\check{n}_\mu`),
        "、",
        ref("def_V_plus"),
        " の ",
        math(String.raw`V^{(+)}`),
        "（",
        math(String.raw`\check{Z}_\mu`),
        " 以下はいずれも ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の元）と ",
        math(String.raw`I := I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        " について、次の五つが成り立つ。(1)(2)(4) は任意の ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について、(3) は任意の ",
        math(String.raw`\theta \in \mathbb{R}`),
        " について述べる。(4) は二つの定義の再掲である。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad A(\tilde\theta_\mu) = \check{P}_\mu \begin{pmatrix} \lambda_{+,\mu} & 0 \\ 0 & \lambda_{-,\mu} \end{pmatrix} \check{P}_\mu^{-1}`),
          "（",
          math(String.raw`\check{P}_\mu`),
          " は可逆）",
        ],
        [math(String.raw`\text{(2)}\quad \lambda_{\pm,\mu} = \exp\left(\pm\gamma(\tilde\theta_\mu)\right)`)],
        [
          math(String.raw`\text{(3)}\quad \gamma(\theta) = \mathrm{arccosh}\left(\cosh 2K_1 \cosh 2K_2^* - \sinh 2K_1 \sinh 2K_2^* \cos\theta\right)`),
        ],
        [
          math(String.raw`\text{(4)}\quad \begin{pmatrix}\check\psi_\mu^\dagger, & \check\psi_\mu\end{pmatrix} = \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}\check{P}_\mu,\qquad \check{n}_\mu = \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}`),
        ],
        [
          math(String.raw`\text{(5)}\quad`),
          " ある ",
          math(String.raw`c \in \mathbb{C}^\times`),
          " が存在して ",
          math(String.raw`V^{(+)} = c\,\exp\!\left(\sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check{n}_\mu - \tfrac12 I\right)\right)`),
        ],
      ]),
      paragraph([
        math(String.raw`c`),
        " の値の決定はここでは行わない。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("diagonalization_check_P_D"),
        " により ",
        math(String.raw`\det\check{P}_\mu \neq 0_{\mathbb{C}}`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A(\tilde\theta_\mu)
&= \check{P}_\mu\,\check{D}_\mu\,\check{P}_\mu^{-1}
&&(\because\ \blkref{diagonalization_check_P_D}) \\
&= \check{P}_\mu \begin{pmatrix} \lambda_{+,\mu} & 0 \\ 0 & \lambda_{-,\mu} \end{pmatrix} \check{P}_\mu^{-1}
&&(\because\ \blkref{diagonalization_check_P_D}\ \text{の}\ \check{D}_\mu\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "(2) ",
        ref("lambda_eq_exp_gamma_theta_tilde"),
        " の ",
        math(String.raw`\lambda_{+,\mu} = \exp(+\gamma(\tilde\theta_\mu))`),
        " と ",
        math(String.raw`\lambda_{-,\mu} = \exp(-\gamma(\tilde\theta_\mu))`),
        " そのものである。",
      ]),
      paragraph(["(3) ", math(String.raw`\theta \in \mathbb{R}`), " について"]),
      displayMath(
        String.raw`\begin{aligned}
\gamma(\theta)
&= \mathrm{arccosh}\left(\gamma_1(\theta)\right)
&&(\because\ \blkref{def_gamma_theta}) \\
&= \mathrm{arccosh}\left(c_1 c_2^* - s_1 s_2^* \cos\theta\right)
&&(\because\ \blkref{def_gamma1_gamma2_of_theta}\ \text{の}\ \gamma_1(\theta)\ \text{の定義}) \\
&= \mathrm{arccosh}\left(\cosh 2K_1 \cosh 2K_2^* - \sinh 2K_1 \sinh 2K_2^* \cos\theta\right)
&&(\because\ \blkref{def_indexed_hyperbolic_abbreviations}\ \text{の}\ c_i, s_i, c_i^*, s_i^*\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "(4) 一つ目の式は ",
        ref("def_check_fermi"),
        " の ",
        math(String.raw`\check\psi_\mu^\dagger, \check\psi_\mu`),
        " の定義、二つ目の式は ",
        ref("def_check_number_operator"),
        " の ",
        math(String.raw`\check{n}_\mu`),
        " の定義そのものである。",
      ]),
      paragraph([
        "(5) ",
        ref("V_plus_eq_c_exp_sum_gamma_check_number_operator"),
        " そのものである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、章立て案のこの章のゴールの式（A(θ̃_μ) の対角化、λ_{±,μ} = exp(±γ(θ̃_μ))、γ(θ) の明示形、ψ̌_μ と ň_μ の定義、V^{(+)} の指数表示）を一つの主張として立てた。既存の主張と定義を挙げるだけで、新しい証明は無い。",
      ],
    },
  },
]);
