import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_linear_space_general",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 3 },
    title: { text: "線型空間の一般論" },
    labels: [],
  },
  {
    id: "linear_space_general_000_definition_kronecker_product",
    kind: "definition",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "クロネッカー積（2 次の複素行列・2 次元数ベクトルの M 個の積）" },
    labels: ["def_kronecker"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とする。各成分が ",
        math(String.raw`1`),
        " か ",
        math(String.raw`2`),
        " である ",
        math(String.raw`M`),
        " 個組の全体",
      ]),
      displayMath(
        String.raw`\mathcal{I}_M := \{1,2\}^M
= \left\{\,(i_1,\dots,i_M) \;\middle|\; i_1,\dots,i_M \in \{1,2\}\,\right\}`,
      ),
      paragraph([
        "を添字集合とする。",
        math(String.raw`\#\mathcal{I}_M = 2^M`),
        " である（下の Step 1）。写像",
      ]),
      displayMath(
        String.raw`\nu : \mathcal{I}_M \to \{1,2,\dots,2^M\},\qquad
\nu(I) := 1 + \sum_{k=1}^{M} (i_k - 1)\,2^{M-k}
\quad (I = (i_1,\dots,i_M))`,
      ),
      paragraph([
        "は全単射である（下の Step 2・Step 3）。以後、",
        math(String.raw`\mathcal{I}_M`),
        " の元 ",
        math(String.raw`I`),
        " を、行番号・列番号 ",
        math(String.raw`\nu(I) \in \{1,\dots,2^M\}`),
        " と同一視して使う。",
      ]),
      paragraph([
        "（1）数ベクトルのクロネッカー積。",
        math(String.raw`v_1,\dots,v_M \in \mathbb{C}^2`),
        " に対し、",
        math(String.raw`v_1 \boxtimes \cdots \boxtimes v_M \in \mathbb{C}^{2^M}`),
        " を成分で",
      ]),
      displayMath(
        String.raw`\left(v_1 \boxtimes \cdots \boxtimes v_M\right)_{\nu(I)}
:= \prod_{k=1}^{M} (v_k)_{i_k}
\qquad (I = (i_1,\dots,i_M) \in \mathcal{I}_M)`,
      ),
      paragraph([
        "と定める（右辺は複素数の有限個の積であり、",
        math(String.raw`(v_k)_{i_k}\in\mathbb{C}`),
        " は ",
        math(String.raw`v_k`),
        " の第 ",
        math(String.raw`i_k`),
        " 成分）。",
        math(String.raw`\nu`),
        " が全単射だから、これで ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の元が 1 つ確定する。",
      ]),
      paragraph([
        "（2）行列のクロネッカー積。",
        math(String.raw`A_1,\dots,A_M \in \mathrm{Mat}(2,\mathbb{C})`),
        " に対し、",
        math(String.raw`A_1 \boxtimes \cdots \boxtimes A_M \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " を成分で",
      ]),
      displayMath(
        String.raw`\left(A_1 \boxtimes \cdots \boxtimes A_M\right)_{\nu(I),\,\nu(J)}
:= \prod_{k=1}^{M} (A_k)_{i_k j_k}
\qquad (I = (i_1,\dots,i_M),\ J = (j_1,\dots,j_M) \in \mathcal{I}_M)`,
      ),
      paragraph([
        "と定める。これは ",
        math(String.raw`2^M`),
        " 行 ",
        math(String.raw`2^M`),
        " 列の複素行列であって、抽象的なテンソル積ではない。",
      ]),
      paragraph([
        "（3）これらが住む空間。",
        math(String.raw`A_1 \boxtimes \cdots \boxtimes A_M`),
        " は ",
        math(String.raw`2^M`),
        " 次の複素正方行列全体 ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の元、",
        math(String.raw`v_1 \boxtimes \cdots \boxtimes v_M`),
        " は ",
        math(String.raw`2^M`),
        " 次元数ベクトル全体 ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の元である。基底と単位行列に関する帰結は、定義後の成分計算で別に示す。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\nu`),
        " が定義どおりの写像であり全単射であること（定義が意味をもつために必要な事項）を確かめる。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`\#\mathcal{I}_M = 2^M`),
        "。",
        math(String.raw`M`),
        " についての帰納法による。",
        math(String.raw`M=1`),
        " のとき ",
        math(String.raw`\mathcal{I}_1=\{(1),(2)\}`),
        " で元数は ",
        math(String.raw`2=2^1`),
        "。",
        math(String.raw`M`),
        " で ",
        math(String.raw`\#\mathcal{I}_M=2^M`),
        " とすると、",
        math(String.raw`\mathcal{I}_{M+1}`),
        " の元は ",
        math(String.raw`(I, i_{M+1})`),
        "（",
        math(String.raw`I\in\mathcal{I}_M`),
        "、",
        math(String.raw`i_{M+1}\in\{1,2\}`),
        "）と一対一に対応するから、次の一続きで ",
        math(String.raw`M+1`),
        " でも成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\#\mathcal{I}_{M+1}
&=\#\mathcal{I}_M\cdot 2
   &&(\because \text{一対一対応で }I\text{ が }\#\mathcal{I}_M\text{ 通り、}i_{M+1}\text{ が }2\text{ 通り}) \\
&=2^M\cdot 2
   &&(\because \text{帰納法の仮定}\ \#\mathcal{I}_M=2^M) \\
&=2^{M+1}
   &&(\because \text{指数法則}\ 2^M\cdot 2=2^{M+1})
\end{aligned}`,
      ),
      paragraph([
        "Step 2: 値域。まず ",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`\sum_{t=0}^{n-1}2^{t}=2^{n}-1`),
        "（",
        math(String.raw`n=0`),
        " のときは空和で ",
        math(String.raw`0=2^0-1`),
        "、",
        math(String.raw`n`),
        " で成り立てば次の一続きで ",
        math(String.raw`n+1`),
        " でも成り立つ）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{t=0}^{n}2^t
&=\sum_{t=0}^{n-1}2^t+2^n
   &&(\because \text{有限和の最後の項を分ける}) \\
&=(2^n-1)+2^n
   &&(\because \text{帰納法の仮定}\ \textstyle\sum_{t=0}^{n-1}2^{t}=2^{n}-1) \\
&=2\cdot 2^n-1
   &&(\because \text{加法の結合則と }2^n+2^n=2\cdot 2^n) \\
&=2^{n+1}-1
   &&(\because \text{指数法則}\ 2\cdot 2^n=2^{n+1})
\end{aligned}`,
      ),
      paragraph([
        "各 ",
        math(String.raw`k`),
        " について ",
        math(String.raw`i_k-1\in\{0,1\}`),
        " であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le \sum_{k=1}^{M}(i_k-1)2^{M-k}
   &&(\because \text{各項は }0\le i_k-1\text{ と }2^{M-k}>0\text{ の積で非負}) \\
&\le \sum_{k=1}^{M}2^{M-k}
   &&(\because \text{各項で }i_k-1\le 1\text{ かつ }2^{M-k}>0) \\
&= \sum_{t=0}^{M-1}2^{t}
   &&(\because \text{添字の置き換え }t:=M-k) \\
&= 2^{M}-1
   &&(\because \text{上の }\textstyle\sum_{t=0}^{n-1}2^{t}=2^{n}-1\text{ を }n:=M\text{ で})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`1\le\nu(I)\le 2^M`),
        "。よって ",
        math(String.raw`\nu`),
        " は ",
        math(String.raw`\mathcal{I}_M`),
        " から ",
        math(String.raw`\{1,\dots,2^M\}`),
        " への写像である。",
      ]),
      paragraph([
        "Step 3: 単射性、および全単射性。",
        math(String.raw`I=(i_1,\dots,i_M)\neq J=(j_1,\dots,j_M)`),
        " とし、",
        math(String.raw`i_k\neq j_k`),
        " となる最小の ",
        math(String.raw`k`),
        " をとる。必要なら ",
        math(String.raw`I`),
        " と ",
        math(String.raw`J`),
        " を入れ替えて ",
        math(String.raw`i_k=2,\ j_k=1`),
        " としてよい。",
        math(String.raw`l<k`),
        " では ",
        math(String.raw`i_l=j_l`),
        " だから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\nu(I)-\nu(J)
&= \Bigl(1+\sum_{l=1}^{M}(i_l-1)2^{M-l}\Bigr)-\Bigl(1+\sum_{l=1}^{M}(j_l-1)2^{M-l}\Bigr)
   &&(\because \nu\text{ の定義}) \\
&= \sum_{l=1}^{M}(i_l-j_l)2^{M-l}
   &&(\because \text{和の差を項ごとに取る。}(i_l-1)-(j_l-1)=i_l-j_l) \\
&= \sum_{l=k}^{M}(i_l-j_l)2^{M-l}
   &&(\because l<k\text{ では }i_l=j_l\text{ で項が }0) \\
&= 2^{M-k} + \sum_{l=k+1}^{M}(i_l-j_l)2^{M-l}
   &&(\because l=k\text{ の項を分ける。}i_k-j_k=2-1=1)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`i_l-j_l\in\{-1,0,1\}`),
        " より次の一続きが成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\sum_{l=k+1}^{M}(i_l-j_l)2^{M-l}\right|
&\le \sum_{l=k+1}^{M}\left|i_l-j_l\right|2^{M-l}
   &&(\because \text{三角不等式と }2^{M-l}>0) \\
&\le \sum_{l=k+1}^{M}2^{M-l}
   &&(\because \text{各項で }|i_l-j_l|\le 1\text{ かつ }2^{M-l}>0) \\
&= \sum_{t=0}^{M-k-1}2^{t}
   &&(\because \text{添字の置き換え }t:=M-l) \\
&= 2^{M-k}-1
   &&(\because \text{Step 2 の }\textstyle\sum_{t=0}^{n-1}2^{t}=2^{n}-1\text{ を }n:=M-k\text{ で}) \\
&< 2^{M-k}
   &&(\because 2^{M-k}-1<2^{M-k})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\nu(I)-\nu(J)\neq 0`),
        " すなわち ",
        math(String.raw`\nu`),
        " は単射である。Step 1 より ",
        math(String.raw`\#\mathcal{I}_M=2^M=\#\{1,\dots,2^M\}`),
        " であり、有限集合の間の単射で元数が等しいものは全射でもあるから（像は ",
        math(String.raw`2^M`),
        " 個の元をもつ ",
        math(String.raw`\{1,\dots,2^M\}`),
        " の部分集合、すなわち全体）、",
        math(String.raw`\nu`),
        " は全単射である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、(C^2)^{⊗M} を数ベクトル空間 C^{2^M} へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "2026-09-01 の式変形統一で、全五本の aligned 鎖にある根拠 20 行を" +
          "行中の \\quad (\\because …) から行末の根拠列（aligned の &&）へ揃えた。" +
          "式変形・根拠・段数・参照は変えていない。",
        "2026-08-17: 式変形の書き方の統一。Step 3（単射性）の二つの式（ν(I)−ν(J) の分解と、残りの和の絶対値の評価）を、" +
          "1 行 1 等号の一続きの鎖と行末の (∵ …) へ揃えた（ν の定義から始め、和の差・l<k の項の消去・l=k の項の分離、" +
          "三角不等式・各項の評価・添字の置き換え・Step 2 の等比和・最後の狭義不等号）。内容は不変で、段は増えており減った段は無い。",
        "2026-08-09: 式変形の書き方の統一。Step 0〜3 という番号での区切りを、" +
          "それぞれの中間目標の名前（多重添字の和を各因子ごとの和の積へ直すこと・" +
          "(1) の証明・(2) の証明・(3) の証明）へ変えた（リポジトリの規約「番号や記号で管理しない」）。" +
          "(2) は式のあとに置かれていた日本語の説明（積が 1 になる条件、ν の単射性）を、" +
          "3 段の一続きの鎖の各行末の (∵ …) へ移した。段は増えており、減った段は無い。",
        "原文（Typst）に対応ブロックは無い。原文および旧構造化テキストは ⊗ を抽象テンソル積の記号として" +
          "定義せずに使っていたため、README のゴール設定（M 個の 2×2 行列の積は具体的な 2^M × 2^M の" +
          "複素行列として専用記号で定義する）に従い、成分の式によるクロネッカー積 ⊠ を本文に置いた。" +
          "移行期には既存章の ⊗ をこの ⊠ の別記法として同一視する注記を置いていたが、" +
          "本文全章の書き換えが完了したので同一視の注記は削除した（本文に ⊗ はもう現れない）。",
      ],
    },
  },
  {
    id: "linear_space_general_000b_claim_kronecker_product_rule",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "クロネッカー積の積の規則（各因子ごとの積になること）" },
    labels: ["kronecker_product_rule"],
    statement: [
      paragraph([
        ref("def_kronecker"),
        " の記号のもと、",
        math(String.raw`A_1,\dots,A_M,B_1,\dots,B_M \in \mathrm{Mat}(2,\mathbb{C})`),
        "、",
        math(String.raw`v_1,\dots,v_M \in \mathbb{C}^2`),
        " について次が成り立つ。",
      ]),
      list([
        [
          "(1) ",
          math(
            String.raw`\left(A_1\boxtimes\cdots\boxtimes A_M\right)\left(B_1\boxtimes\cdots\boxtimes B_M\right)
= (A_1B_1)\boxtimes\cdots\boxtimes(A_MB_M)`,
          ),
          "（左辺は ",
          math(String.raw`2^M`),
          " 次の行列の積、右辺の各 ",
          math(String.raw`A_kB_k`),
          " は ",
          math(String.raw`2`),
          " 次の行列の積）。",
        ],
        [
          "(2) ",
          math(
            String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}
= I_{\mathrm{Mat}(2^M,\mathbb{C})}`,
          ),
          "。",
        ],
        [
          "(3) ",
          math(
            String.raw`\left(A_1\boxtimes\cdots\boxtimes A_M\right)\left(v_1\boxtimes\cdots\boxtimes v_M\right)
= (A_1v_1)\boxtimes\cdots\boxtimes(A_Mv_M)`,
          ),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph(["行列積と列ベクトルへの作用は ", ref("mat_mult"), " に従い、複素数の結合律・可換律・分配律は ", ref("complex_numbers_form_a_field"), " を用いる。"]),
      paragraph([
        "多重添字についての和を、各因子ごとの和の積へ直すこと。",
        math(String.raw`M\in\mathbb{Z}_{\ge 1}`),
        " と、各 ",
        math(String.raw`k\in\{1,\dots,M\}`),
        " ごとに与えられた複素数 ",
        math(String.raw`c_k(1),c_k(2)\in\mathbb{C}`),
        " について",
      ]),
      displayMath(
        String.raw`\sum_{K\in\mathcal{I}_M}\ \prod_{k=1}^{M}c_k(t_k)
= \prod_{k=1}^{M}\left(\sum_{t=1}^{2}c_k(t)\right)
\qquad (K=(t_1,\dots,t_M))`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`M`),
        " についての帰納法で示す。",
        math(String.raw`M=1`),
        " のときは両辺とも ",
        math(String.raw`c_1(1)+c_1(2)`),
        "。",
        math(String.raw`M`),
        " で成り立つとすると、",
        math(String.raw`\mathcal{I}_{M+1}`),
        " の元は ",
        math(String.raw`(K,t)`),
        "（",
        math(String.raw`K\in\mathcal{I}_M,\ t\in\{1,2\}`),
        "）と一対一に対応するから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{(t_1,\dots,t_{M+1})\in\mathcal{I}_{M+1}}\prod_{k=1}^{M+1}c_k(t_k)
&= \sum_{t=1}^{2}\sum_{K\in\mathcal{I}_M}\left(\prod_{k=1}^{M}c_k(t_k)\right)c_{M+1}(t)
   &&(\because \text{最後の成分 } t_{M+1}=t \text{ で場合分けした有限和の分割}) \\
&= \left(\sum_{K\in\mathcal{I}_M}\prod_{k=1}^{M}c_k(t_k)\right)\left(\sum_{t=1}^{2}c_{M+1}(t)\right)
   &&(\because \text{分配律}) \\
&= \left(\prod_{k=1}^{M}\left(\sum_{s=1}^{2}c_k(s)\right)\right)\left(\sum_{t=1}^{2}c_{M+1}(t)\right)
   &&(\because \text{帰納法の仮定}) \\
&= \prod_{k=1}^{M+1}\left(\sum_{t=1}^{2}c_k(t)\right)
   &&(\because \text{有限積の最後の因子を戻した（積の定義）})
\end{aligned}`,
      ),
      paragraph([
        "(1) の証明。",
        math(String.raw`I=(i_1,\dots,i_M),\ L=(l_1,\dots,l_M)\in\mathcal{I}_M`),
        " を任意に取る。行列の積の定義と、",
        ref("def_kronecker"),
        " の ",
        math(String.raw`\nu`),
        " が全単射であること（和の変数 ",
        math(String.raw`p\in\{1,\dots,2^M\}`),
        " を ",
        math(String.raw`p=\nu(K),\ K=(t_1,\dots,t_M)\in\mathcal{I}_M`),
        " と書き換えてよい）より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\left(A_1\boxtimes\cdots\boxtimes A_M\right)\left(B_1\boxtimes\cdots\boxtimes B_M\right)\right)_{\nu(I),\nu(L)}
&= \sum_{p=1}^{2^M}
\left(A_1\boxtimes\cdots\boxtimes A_M\right)_{\nu(I),p}
\left(B_1\boxtimes\cdots\boxtimes B_M\right)_{p,\nu(L)}
   &&(\because \text{行列の積の定義}) \\
&= \sum_{K\in\mathcal{I}_M}
\left(\prod_{k=1}^{M}(A_k)_{i_kt_k}\right)\left(\prod_{k=1}^{M}(B_k)_{t_kl_k}\right)
   &&(\because \nu \text{ は全単射、} \boxtimes \text{ の定義}) \\
&= \sum_{K\in\mathcal{I}_M}\prod_{k=1}^{M}\left((A_k)_{i_kt_k}(B_k)_{t_kl_k}\right)
   &&(\because \text{複素数の積の可換律・結合律}) \\
&= \prod_{k=1}^{M}\left(\sum_{t=1}^{2}(A_k)_{i_kt}(B_k)_{tl_k}\right)
   &&(\because \text{多重添字の和を各因子ごとの和の積へ直す段を } c_k(t)=(A_k)_{i_kt}(B_k)_{tl_k} \text{ に適用}) \\
&= \prod_{k=1}^{M}(A_kB_k)_{i_kl_k}
   &&(\because \text{行列の積の定義}) \\
&= \left((A_1B_1)\boxtimes\cdots\boxtimes(A_MB_M)\right)_{\nu(I),\nu(L)}
   &&(\because \boxtimes \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\nu`),
        " は全単射だから、これで両辺のすべての成分が一致することが示された。",
      ]),
      paragraph([
        "(2) の証明。",
        math(String.raw`I=(i_1,\dots,i_M),\ J=(j_1,\dots,j_M)\in\mathcal{I}_M`),
        " を任意に取る。単位行列の成分は ",
        math(String.raw`\left(I_{\mathrm{Mat}(2,\mathbb{C})}\right)_{ij}=\delta_{ij}`),
        "（",
        math(String.raw`i=j`),
        " のとき ",
        math(String.raw`1`),
        "、そうでなければ ",
        math(String.raw`0`),
        "）である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(I_{\mathrm{Mat}(2,\mathbb{C})}\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}\right)_{\nu(I),\nu(J)}
&= \prod_{k=1}^{M}\delta_{i_kj_k}
   &&(\because \boxtimes \text{ の定義と単位行列の成分}) \\
&= \begin{cases}1 & (I=J)\\ 0 & (I\neq J)\end{cases}
   &&(\because \text{積が } 1 \text{ になるのは全ての } k \text{ で } i_k=j_k \text{、すなわち } I=J \text{ のときに限り、そうでなければ因子に } 0 \text{ が現れる}) \\
&= \left(I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)_{\nu(I),\nu(J)}
   &&(\because \nu \text{ は単射なので } I=J \iff \nu(I)=\nu(J) \text{、および単位行列の成分})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\nu`),
        " は全単射だから、これで両辺のすべての成分が一致することが示された。",
      ]),
      paragraph([
        "(3) の証明。(1) と同じ計算を、第 2 の因子を数ベクトルに置き換えて行う。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\left(A_1\boxtimes\cdots\boxtimes A_M\right)\left(v_1\boxtimes\cdots\boxtimes v_M\right)\right)_{\nu(I)}
&= \sum_{p=1}^{2^M}\left(A_1\boxtimes\cdots\boxtimes A_M\right)_{\nu(I),p}
\left(v_1\boxtimes\cdots\boxtimes v_M\right)_{p}
   &&(\because \text{行列と数ベクトルの積の定義}) \\
&= \sum_{K\in\mathcal{I}_M}
\left(\prod_{k=1}^{M}(A_k)_{i_kt_k}\right)\left(\prod_{k=1}^{M}(v_k)_{t_k}\right)
   &&(\because \nu \text{ は全単射、} \boxtimes \text{ の定義}) \\
&= \sum_{K\in\mathcal{I}_M}\prod_{k=1}^{M}\left((A_k)_{i_kt_k}(v_k)_{t_k}\right)
   &&(\because \text{複素数の積の可換律・結合律}) \\
&= \prod_{k=1}^{M}\left(\sum_{t=1}^{2}(A_k)_{i_kt}(v_k)_{t}\right)
   &&(\because \text{多重添字の和を各因子ごとの和の積へ直す段を } c_k(t)=(A_k)_{i_kt}(v_k)_{t} \text{ に適用}) \\
&= \prod_{k=1}^{M}(A_kv_k)_{i_k}
   &&(\because \text{行列と数ベクトルの積の定義}) \\
&= \left((A_1v_1)\boxtimes\cdots\boxtimes(A_Mv_M)\right)_{\nu(I)}
   &&(\because \boxtimes \text{ の定義})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。「テンソル積上の積は各因子ごとの積」という規則は" +
          "004 章以降の証明で繰り返し根拠として使われているのに、定義も証明も本文に無かった" +
          "（goal-alignment-audit の A-3）。クロネッカー積として定義したことで、成分計算で証明できる" +
          "主張になったのでここに置いた。",
        "2026-08-10: 式変形の書き方の統一。2 箇所を直した。準備（多重添字の和を各因子ごとの" +
          "和の積へ直す段）の鎖の最終行に根拠が無かったので (∵ …) を付けた。" +
          "(3) の鎖は、1 行で 2 つの定理を同時に適用していた段（ν が全単射であることと ⊠ の定義で" +
          "書き換える段に、複素数の積の可換律・結合律による並べ替えを混ぜていた）を 2 段へ割り、" +
          "さらに最後の行が 1 行に 2 つの等号を並べて根拠を 1 つも書いていなかったので" +
          "2 段へ割って各行に (∵ …) を置いた（(1) の鎖と同じ形になった）。" +
          "段は増えており、減った段は無い。主張も証明の筋も変えていない。",
      ],
    },
  },
  {
    id: "linear_space_general_000c_claim_kronecker_multilinear",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "クロネッカー積の各因子についての線型性" },
    labels: ["kronecker_multilinear"],
    statement: [
      paragraph([
        ref("def_kronecker"),
        " の記号のもと、",
        math(String.raw`j\in\{1,\dots,M\}`),
        " を固定し、",
        math(String.raw`A_1,\dots,A_M \in \mathrm{Mat}(2,\mathbb{C})`),
        "、",
        math(String.raw`r\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`c_1,\dots,c_r\in\mathbb{C}`),
        "、",
        math(String.raw`B_1,\dots,B_r\in\mathrm{Mat}(2,\mathbb{C})`),
        " とする。第 ",
        math(String.raw`j`),
        " 因子が ",
        math(String.raw`A_j=\sum_{a=1}^{r}c_aB_a`),
        " と書けているとき、",
      ]),
      displayMath(
        String.raw`A_1\boxtimes\cdots\boxtimes\overbrace{\left(\sum_{a=1}^{r}c_aB_a\right)}^{j\text{ 番目}}\boxtimes\cdots\boxtimes A_M
= \sum_{a=1}^{r}c_a\left(A_1\boxtimes\cdots\boxtimes\overbrace{B_a}^{j\text{ 番目}}\boxtimes\cdots\boxtimes A_M\right)`,
      ),
      paragraph([
        "が成り立つ。特に ",
        math(String.raw`r=1`),
        " として、",
        math(String.raw`c\in\mathbb{C}`),
        " について",
      ]),
      displayMath(
        String.raw`A_1\boxtimes\cdots\boxtimes\overbrace{(c\,A_j)}^{j\text{ 番目}}\boxtimes\cdots\boxtimes A_M
= c\left(A_1\boxtimes\cdots\boxtimes A_M\right)`,
      ),
      paragraph([
        "である。数ベクトルのクロネッカー積についても、",
        math(String.raw`\mathbb{C}^2`),
        " の元を同じ形に分解したとき同じ等式が成り立つ。",
      ]),
    ],
    proof: [
      paragraph(["成分の複素数の演算には ", ref("complex_numbers_form_a_field"), " の結合律・可換律・分配律を用いる。"]),
      paragraph([
        "準備。",
        math(String.raw`I=(i_1,\dots,i_M),\ J=(j_1,\dots,j_M)\in\mathcal{I}_M`),
        " を任意に取り、両辺の ",
        math(String.raw`(\nu(I),\nu(J))`),
        " 成分を比べる。以下で ",
        math(String.raw`\prod_{k\neq j}(A_k)_{i_kj_k}`),
        " は ",
        math(String.raw`k\in\{1,\dots,M\}\setminus\{j\}`),
        " についての積を表す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(A_1\boxtimes\cdots\boxtimes\left(\sum_{a=1}^{r}c_aB_a\right)\boxtimes\cdots\boxtimes A_M\right)_{\nu(I),\nu(J)}
&= \left(\prod_{k\neq j}(A_k)_{i_kj_k}\right)\left(\sum_{a=1}^{r}c_aB_a\right)_{i_jj_j}
&&(\because \boxtimes \text{ の定義}) \\
&= \left(\prod_{k\neq j}(A_k)_{i_kj_k}\right)\left(\sum_{a=1}^{r}c_a(B_a)_{i_jj_j}\right)
&&(\because \text{行列の和・スカラー倍は成分ごとの演算}) \\
&= \sum_{a=1}^{r}c_a\left(\prod_{k\neq j}(A_k)_{i_kj_k}\right)(B_a)_{i_jj_j}
&&(\because \text{複素数の分配律}) \\
&= \sum_{a=1}^{r}c_a\left(A_1\boxtimes\cdots\boxtimes B_a\boxtimes\cdots\boxtimes A_M\right)_{\nu(I),\nu(J)}
&&(\because \boxtimes \text{ の定義}) \\
&= \left(\sum_{a=1}^{r}c_a\left(A_1\boxtimes\cdots\boxtimes B_a\boxtimes\cdots\boxtimes A_M\right)\right)_{\nu(I),\nu(J)}
&&(\because \text{行列の和・スカラー倍は成分ごとの演算})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\nu`),
        " は全単射だから、すべての成分が一致し両辺は等しい。",
        math(String.raw`r=1,\ c_1=c,\ B_1=A_j`),
        " とすればスカラーを前に出す式を得る。数ベクトルの場合は、上の計算で ",
        math(String.raw`(A_k)_{i_kj_k}`),
        " を ",
        math(String.raw`(v_k)_{i_k}`),
        " に置き換えれば同じ議論がそのまま通用する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。「テンソル積の各因子についての C-線型性」" +
          "（スカラーを前に出す・和で展開する）は 004 章以降で繰り返し根拠として使われているのに、" +
          "定義も証明も本文に無かった（goal-alignment-audit の A-3）。",
        "2026-08-10: 式変形の書き方の統一。第 1 段が「⊠ の定義」と「行列の和・スカラー倍は" +
          "成分ごとの演算」の 2 つを同時に適用していたので 2 段に割った（一ステップ一定理）。" +
          "式変形の前に置かれていた成分の分解の式は、鎖の中の 1 段になったので準備から外し、" +
          "式変形の後ろにあった記法の断り（∏_{k≠j} の意味）は準備へ移した。" +
          "段は増えており、減った段は無い。",
      ],
    },
  },
  {
    id: "linear_space_general_000d_claim_kronecker_transpose",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 1 },
    title: { text: "クロネッカー積の転置（因子ごとの転置になること）" },
    labels: ["kronecker_transpose"],
    statement: [
      paragraph([
        ref("def_kronecker"),
        " の記号のもと、",
        math(String.raw`A_1,\dots,A_M \in \mathrm{Mat}(2,\mathbb{C})`),
        " について、",
        math(String.raw`2^M`),
        " 次の複素行列の転置 ",
        math(String.raw`\left(B^\top\right)_{pq} := B_{qp}`),
        "（",
        math(String.raw`p,q\in\{1,\dots,2^M\}`),
        "）に関して",
      ]),
      displayMath(
        String.raw`\left(A_1\boxtimes\cdots\boxtimes A_M\right)^\top
= A_1^\top\boxtimes\cdots\boxtimes A_M^\top`,
      ),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`I=(i_1,\dots,i_M),\ J=(j_1,\dots,j_M)\in\mathcal{I}_M`),
        " を任意に取り、両辺の ",
        math(String.raw`(\nu(I),\nu(J))`),
        " 成分を比べる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\left(A_1\boxtimes\cdots\boxtimes A_M\right)^\top\right)_{\nu(I),\nu(J)}
&= \left(A_1\boxtimes\cdots\boxtimes A_M\right)_{\nu(J),\nu(I)}
&&(\because \text{転置の定義}) \\
&= \prod_{k=1}^{M}(A_k)_{j_ki_k}
&&(\because \blkref{def_kronecker} \text{ のクロネッカー積の成分の定め方}) \\
&= \prod_{k=1}^{M}\left(A_k^\top\right)_{i_kj_k}
&&(\because 2 \text{ 次の行列の転置の定義}) \\
&= \left(A_1^\top\boxtimes\cdots\boxtimes A_M^\top\right)_{\nu(I),\nu(J)}
&&(\because \blkref{def_kronecker} \text{ のクロネッカー積の成分の定め方})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\nu`),
        " は ",
        ref("def_kronecker"),
        " により全単射であり、",
        math(String.raw`\{1,\dots,2^M\}`),
        " のどの成分の番号も ",
        math(String.raw`\nu(I)`),
        " の形に書けるので、これで両辺のすべての成分が一致することが示された。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。009 章（V の固有値）の実対称性の議論が" +
          "「テンソル積の転置は因子ごとの転置になる」を根拠なしに使っていたので、" +
          "クロネッカー積の成分の定義から証明できる主張としてここに置いた。",
        "式変形の書き方の統一（2026-08-10）。鎖と行末の (∵ …) は既にあったが、" +
          "引いたブロックへのラベル参照が無く、(∵ ⊠ の定義) がどのブロックを指すかが" +
          "式の中からは辿れなかった。式の直後に参照を置いた。" +
          "あわせて、最後の段が「ν は全単射だから」とだけ述べていたところを、" +
          "全単射性がどこで定めたものかと、そこから成分の番号がすべて尽くされることを書いた。" +
          "式変形の段は 1 つも増減しておらず、主張と証明の中身は変えていない。",
        "2026-09-01 の式変形統一で、四段の根拠を行中の \\quad (\\because …) から" +
          "行末の根拠列（aligned の &&）へ揃えた。式変形・根拠・段数・参照は変えていない。",
      ],
    },
  },
  {
    id: "linear_space_general_001_theorem_tensor_product_basis",
    kind: "theorem",
    origin: { path: "_old/typst/parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ", ordinal: 1 },
    title: { text: "クロネッカー積がつくる基底" },
    labels: ["tensor_basis"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とし、記号は ",
        ref("def_kronecker"),
        " のものとする。",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の行列単位を ",
        math(String.raw`E_{ij}`),
        "（",
        math(String.raw`(i,j)`),
        " 成分が ",
        math(String.raw`1`),
        " で他の成分が ",
        math(String.raw`0`),
        "、",
        math(String.raw`i,j\in\{1,2\}`),
        "）、",
        math(String.raw`\mathbb{C}^2`),
        " の標準基底を ",
        math(String.raw`e_1=(1,0),\ e_2=(0,1)`),
        " とする。",
        math(String.raw`I=(i_1,\dots,i_M),\ J=(j_1,\dots,j_M)\in\mathcal{I}_M`),
        " について",
      ]),
      displayMath(
        String.raw`E_{I,J} := E_{i_1j_1}\boxtimes\cdots\boxtimes E_{i_Mj_M} \in \mathrm{Mat}(2^M,\mathbb{C}),
\qquad
f_I := e_{i_1}\boxtimes\cdots\boxtimes e_{i_M} \in \mathbb{C}^{2^M}`,
      ),
      paragraph(["とおく。次が成り立つ。"]),
      list([
        [
          "(1) 族 ",
          math(String.raw`\left(E_{I,J}\right)_{I,J\in\mathcal{I}_M}`),
          " は ",
          math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
          " の ",
          math(String.raw`\mathbb{C}`),
          "-基底である。特に ",
          math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2^M,\mathbb{C}) = 4^M`),
          "。",
        ],
        [
          "(2) ",
          math(String.raw`\mathcal{B}=\{b_1,b_2,b_3,b_4\}`),
          " を ",
          math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
          " の任意の ",
          math(String.raw`\mathbb{C}`),
          "-基底とするとき、多重添字 ",
          math(String.raw`(a_1,\dots,a_M)\in\{1,2,3,4\}^M`),
          " で添字づけられた ",
          math(String.raw`4^M`),
          " 個の元からなる族",
          math(String.raw`\ \left(b_{a_1}\boxtimes\cdots\boxtimes b_{a_M}\right)_{(a_1,\dots,a_M)\in\{1,2,3,4\}^M}`),
          " は ",
          math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
          " の ",
          math(String.raw`\mathbb{C}`),
          "-基底である。",
        ],
        [
          "(3) ",
          math(String.raw`\{u_1,u_2\}`),
          " を ",
          math(String.raw`\mathbb{C}^2`),
          " の任意の ",
          math(String.raw`\mathbb{C}`),
          "-基底とするとき、族 ",
          math(String.raw`\left(u_{a_1}\boxtimes\cdots\boxtimes u_{a_M}\right)_{(a_1,\dots,a_M)\in\{1,2\}^M}`),
          " は ",
          math(String.raw`\mathbb{C}^{2^M}`),
          " の ",
          math(String.raw`\mathbb{C}`),
          "-基底である。特に ",
          math(String.raw`\left(f_I\right)_{I\in\mathcal{I}_M}`),
          " は ",
          math(String.raw`\mathbb{C}^{2^M}`),
          " の基底であり ",
          math(String.raw`\dim_{\mathbb{C}}\mathbb{C}^{2^M}=2^M`),
          "。",
        ],
      ]),
      paragraph([
        "(1)(2) は ",
        math(String.raw`2^M`),
        " 次の複素正方行列全体 ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の基底についての主張、(3) は ",
        math(String.raw`2^M`),
        " 次元数ベクトル空間 ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の基底についての主張である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: (3) の特別な場合（標準基底）。",
        math(String.raw`(e_i)_t=\delta_{it}`),
        " であるから、",
        math(String.raw`K=(k_1,\dots,k_M)\in\mathcal{I}_M`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(f_I)_{\nu(K)}
&= \prod_{k=1}^{M}(e_{i_k})_{k_k}
&&(\because \blkref{def_kronecker} \text{ のクロネッカー積の成分の定め方}) \\
&= \prod_{k=1}^{M}\delta_{i_kk_k}
&&(\because (e_i)_t=\delta_{it}) \\
&= \begin{cases}1 & (I=K)\\ 0 & (I\neq K)\end{cases}
&&(\because I=K \text{ ならばどの因子も } 1\text{、}
I\neq K \text{ ならば } i_k\neq k_k \text{ となる } k \text{ があってその因子が } 0)
\end{aligned}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`f_I`),
        " は第 ",
        math(String.raw`\nu(I)`),
        " 成分だけが ",
        math(String.raw`1`),
        " で他が ",
        math(String.raw`0`),
        " の数ベクトル、つまり ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の標準基底ベクトルである。",
        math(String.raw`\nu`),
        " が全単射だから ",
        math(String.raw`(f_I)_{I\in\mathcal{I}_M}`),
        " は標準基底全体と一致し、これは ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の基底である（任意の ",
        math(String.raw`w=(w_1,\dots,w_{2^M})`),
        " は ",
        math(String.raw`w=\sum_{p=1}^{2^M}w_p\,(\text{第 } p \text{ 標準基底ベクトル})`),
        " と成分比較で一意に書ける）。特に ",
        math(String.raw`\dim_{\mathbb{C}}\mathbb{C}^{2^M}=2^M`),
        "。",
      ]),
      paragraph([
        "Step 2: (1)。同様に ",
        math(String.raw`(E_{ij})_{st}=\delta_{is}\delta_{jt}`),
        " であるから、",
        math(String.raw`K,L\in\mathcal{I}_M`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(E_{I,J}\right)_{\nu(K),\nu(L)}
&= \prod_{k=1}^{M}(E_{i_kj_k})_{k_kl_k}
&&(\because \blkref{def_kronecker} \text{ のクロネッカー積の成分の定め方}) \\
&= \prod_{k=1}^{M}\delta_{i_kk_k}\delta_{j_kl_k}
&&(\because (E_{ij})_{st}=\delta_{is}\delta_{jt}) \\
&= \begin{cases}1 & (I=K \text{ かつ } J=L)\\ 0 & (\text{それ以外})\end{cases}
&&(\because I=K \text{ かつ } J=L \text{ ならばどの因子も } 1\text{、}
\text{そうでなければ } 0 \text{ となる因子がある})
\end{aligned}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`E_{I,J}`),
        " は ",
        math(String.raw`(\nu(I),\nu(J))`),
        " 成分だけが ",
        math(String.raw`1`),
        " で他が ",
        math(String.raw`0`),
        " の ",
        math(String.raw`2^M`),
        " 次行列（",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の行列単位）である。",
        math(String.raw`\nu`),
        " が全単射だから ",
        math(String.raw`(E_{I,J})_{I,J\in\mathcal{I}_M}`),
        " は ",
        math(String.raw`2^M`),
        " 次の行列単位全体と一致する。任意の ",
        math(String.raw`A=(a_{pq})\in\mathrm{Mat}(2^M,\mathbb{C})`),
        " は成分比較により ",
        math(String.raw`A=\sum_{p,q=1}^{2^M}a_{pq}\,(\text{第 }(p,q)\text{ 行列単位})`),
        " と一意に書けるから、これは基底であり、元数は ",
        math(String.raw`2^M\cdot 2^M=4^M`),
        "。よって ",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2^M,\mathbb{C})=4^M`),
        "。",
      ]),
      paragraph([
        "Step 3: 有限次元線型空間についての 2 つの事実。以下で次を使う。",
      ]),
      list([
        [
          "(a) ",
          math(String.raw`d`),
          " 次元 ",
          math(String.raw`\mathbb{C}`),
          "-線型空間を張る有限族の元数は ",
          math(String.raw`d`),
          " 以上である。",
        ],
        [
          "(b) したがって、",
          math(String.raw`d`),
          " 次元 ",
          math(String.raw`\mathbb{C}`),
          "-線型空間を張る、ちょうど ",
          math(String.raw`d`),
          " 個の元からなる族は基底である。実際、線型独立でなければ、ある元が他の元の線型結合になり、その元を除いた ",
          math(String.raw`d-1`),
          " 個の族がなお全体を張るので (a) に反する。",
        ],
      ]),
      paragraph([
        "Step 4: (2)。",
        math(String.raw`\mathcal{B}=\{b_1,\dots,b_4\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の基底だから、各行列単位 ",
        math(String.raw`E_{ij}`),
        "（",
        math(String.raw`i,j\in\{1,2\}`),
        "）は",
      ]),
      displayMath(
        String.raw`E_{ij} = \sum_{a=1}^{4} d^{(ij)}_{a}\,b_a \qquad (d^{(ij)}_{a}\in\mathbb{C})`,
      ),
      paragraph([
        "と書ける。",
        math(String.raw`I,J\in\mathcal{I}_M`),
        " を固定し、",
        math(String.raw`E_{I,J}=E_{i_1j_1}\boxtimes\cdots\boxtimes E_{i_Mj_M}`),
        " の第 ",
        math(String.raw`1`),
        " 因子から順にこの展開を代入する。",
        ref("kronecker_multilinear"),
        " を第 ",
        math(String.raw`j`),
        " 因子に適用する操作を ",
        math(String.raw`j=1,2,\dots,M`),
        " と繰り返す（",
        math(String.raw`j`),
        " についての帰納法）と、",
      ]),
      displayMath(
        String.raw`E_{I,J}
= \sum_{(a_1,\dots,a_M)\in\{1,2,3,4\}^M}
\left(\prod_{k=1}^{M} d^{(i_kj_k)}_{a_k}\right)
\left(b_{a_1}\boxtimes\cdots\boxtimes b_{a_M}\right)
\quad (\because \text{各因子についての線型性})`,
      ),
      paragraph([
        "を得る（各段階で和の項数が ",
        math(String.raw`4`),
        " 倍になり、",
        math(String.raw`M`),
        " 段階で ",
        math(String.raw`4^M`),
        " 項になる）。よって ",
        math(String.raw`E_{I,J}`),
        " は族 ",
        math(String.raw`\left(b_{a_1}\boxtimes\cdots\boxtimes b_{a_M}\right)`),
        " の ",
        math(String.raw`\mathbb{C}`),
        "-線型結合である。Step 2 より ",
        math(String.raw`(E_{I,J})`),
        " は ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " を張るから、",
        math(String.raw`\left(b_{a_1}\boxtimes\cdots\boxtimes b_{a_M}\right)`),
        " も ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " を張る（既知の基底の各元がこの候補族の線型結合で書けるので、既知の基底が張る空間は候補族が張る空間に含まれる）。この族の元数は ",
        math(String.raw`\#\{1,2,3,4\}^M=4^M`),
        " であり、Step 2 より ",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2^M,\mathbb{C})=4^M`),
        " であるから、Step 3 (b) よりこの族は基底である。",
      ]),
      paragraph([
        "Step 5: (3) の一般の基底の場合。Step 4 とまったく同じ議論を、",
        math(String.raw`e_i=\sum_{a=1}^{2}d^{(i)}_{a}u_a`),
        "、",
        ref("kronecker_multilinear"),
        " の数ベクトル版、Step 1 の ",
        math(String.raw`(f_I)`),
        " が ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " を張ること、",
        math(String.raw`\#\{1,2\}^M=2^M=\dim_{\mathbb{C}}\mathbb{C}^{2^M}`),
        " に対して行えばよい。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、(C^2)^{⊗M} を数ベクトル空間 C^{2^M} へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文(Typst)のステートメントは「単一のテンソル積が基底である」と読め、" +
          "かつ V の次元とテンソル冪の階数に同じ記号 m を二重使用していた。" +
          "Lean 形式化(lean/Ising2D/Part002/Theorem000_TensorBasis.lean)で判明したため、" +
          "原文側を修正し本ブロックも同期済み。",
        "さらに本ブロックは「任意の体 K 上の任意の n 次元線型空間のテンソル冪の基底」という" +
          "抽象テンソル積の一般論だった。README 2 節がまさにこの主張（基底のテンソル積が基底）を" +
          "本文に置くことを禁じているため、クロネッカー積（<def_kronecker>）についての具体的な主張" +
          "（行列単位のクロネッカー積が Mat(2^M,C) の基底、次元は 4^M）へ置き換えた。" +
          "ラベル <tensor_basis> は参照元（<centralizer_is_scalar>, <Z_Y_linearly_independent>, " +
          "<def_end_iso>, <Z_Y_generate_algebra>, 008 章）を保つためそのままにしている。" +
          "抽象的な見方は notes/002_linear_space_general.ts へ退避した。",
        "参照元が必要とする形はそれぞれ、(1) 行列単位（<centralizer_is_scalar>, <def_end_iso>）、" +
          "(2) 一般の基底 {I,σ^x,σ^y,σ^z}（<Z_Y_linearly_independent>, <Z_Y_generate_algebra>, 008 章）、" +
          "(3) 数ベクトルの標準基底（<def_end_iso> の F の基底）であるため、3 つの形を並べた。",
        "式変形の書き方の統一（2026-08-10）。Step 1 と Step 2 の式が、3 つの等号を 1 行へ潰したうえで" +
          "行末の (∵ ⊠ の定義) を式全体へ 1 つだけ付けていた。どの等号がその根拠によるのかが" +
          "式から読み取れないので、1 行 1 等号の鎖へ分け、各行の末尾に根拠を置いた" +
          "（クロネッカー積の成分の定め方・成分の定義・添字の一致による場合分けの 3 つが" +
          "別々の根拠であることが、これで式の上に現れる）。あわせて、クロネッカー積の成分を" +
          "取り出す段を明示的な 1 段として書き（Step 2 では (E_{i_k j_k})_{k_k l_k} の積を経由する）、" +
          "引いたブロック <def_kronecker> への参照を式の直後に置いた。" +
          "主張と証明の中身、および Step の分け方は変えていない。",
        "2026-09-02 の式変形統一で、Step 1 と Step 2 の二本の鎖の根拠 6 行を行中の \\quad (\\because …) から" +
          "他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・根拠・参照は変えていない。",
      ],
    },
  },
  {
    id: "linear_space_general_002_claim_scalar_identity_commutes",
    kind: "claim",
    origin: { path: "_old/typst/parts/002_線型空間の一般論/001_lemma_スカラー倍の恒等行列は全行列と可換.typ", ordinal: 2 },
    title: { tex: String.raw`c \cdot I \text{ は全行列と可換}` },
    labels: ["scalar_identity_commutes"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`c \in \mathbb{C}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,\mathbb{C})`),
        " について、",
      ]),
      displayMath(String.raw`[c \cdot I,\, A] = 0`),
      paragraph(["行列積は ", ref("mat_mult"), "、交換子は ", ref("commutator_via_anticommutators"), " の定義を用い、成分の複素数の演算は ", ref("complex_numbers_form_a_field"), " に従う。"]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
[c \cdot I,\, A]
&= (c \cdot I)A - A(c \cdot I)
&&(\because \text{交換子の定義}) \\
&= c(IA) - c(AI)
&&(\because \text{スカラー倍は行列の積の外へ出せる}) \\
&= cA - cA
&&(\because \text{単位行列の性質}\ IA=A,\ AI=A) \\
&= 0
&&(\because \text{同じ元の差は零行列})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形の書き方の統一（2026-08-10）。もとの鎖はどの行にも根拠が書かれておらず、" +
          "さらに第 2 段が 2 つの定理を同時に適用していた" +
          "（スカラー倍を積の外へ出すことと、単位行列を消すこと）。" +
          "この 2 つを別々の段に割り、全 4 段のそれぞれに行末の (∵ …) を付けた。" +
          "段は増えており、減った段は無い。主張と証明の中身は変えていない。",
        "2026-09-01 の式変形統一で、四段の根拠を行中の \\quad (\\because …) から" +
          "他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・根拠は変えていない。",
      ],
    },
  },
  {
    id: "linear_space_general_004_lemma_centralizer_is_scalar",
    kind: "claim",
    origin: { path: "_old/typst/parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ", ordinal: 4 },
    title: { tex: String.raw`\mathrm{Mat}(2^M,\mathbb{C}) \text{ の中で全元と可換な元はスカラー}` },
    labels: ["centralizer_is_scalar"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とする。",
        math(String.raw`W \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " が、すべての ",
        math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について ",
        math(String.raw`Wx = xW`),
        " を満たすならば、ある ",
        math(String.raw`c \in \mathbb{C}`),
        " が存在して ",
        math(String.raw`W = c\cdot I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の行列単位。",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の行列単位を",
      ]),
      displayMath(
        String.raw`E_{11}=\begin{pmatrix}1&0\\0&0\end{pmatrix},\quad
E_{12}=\begin{pmatrix}0&1\\0&0\end{pmatrix},\quad
E_{21}=\begin{pmatrix}0&0\\1&0\end{pmatrix},\quad
E_{22}=\begin{pmatrix}0&0\\0&1\end{pmatrix}`,
      ),
      paragraph([
        "とする。任意の ",
        math(String.raw`A=\begin{pmatrix}a_{11}&a_{12}\\a_{21}&a_{22}\end{pmatrix}\in\mathrm{Mat}(2,\mathbb{C})`),
        " に対し",
      ]),
      displayMath(
        String.raw`A = a_{11}E_{11} + a_{12}E_{12} + a_{21}E_{21} + a_{22}E_{22} \quad (\because \text{成分比較})`,
      ),
      paragraph([
        " が成り立つので ",
        math(String.raw`\mathcal{E}_0 := \{E_{11},E_{12},E_{21},E_{22}\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " を張り、",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2,\mathbb{C})=4=\#\mathcal{E}_0`),
        " であるから ",
        math(String.raw`\mathcal{E}_0`),
        " は基底である。成分計算により、",
        math(String.raw`i,j,k,l\in\{1,2\}`),
        " について",
      ]),
      displayMath(
        String.raw`E_{ij}E_{kl} = \delta_{jk}E_{il} \quad (\because \text{行列の積の成分計算})`,
      ),
      paragraph([
        "（",
        math(String.raw`\delta_{jk}`),
        " は Kronecker のデルタ）。特に ",
        math(String.raw`E_{11}+E_{22}=\begin{pmatrix}1&0\\0&1\end{pmatrix}=I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "。多重添字 ",
        math(String.raw`I=(i_1,\dots,i_M),\ J=(j_1,\dots,j_M)\in\{1,2\}^M`),
        " について ",
        math(String.raw`E_{IJ}:=E_{i_1 j_1}\boxtimes E_{i_2 j_2}\boxtimes\cdots\boxtimes E_{i_M j_M}\in\mathrm{Mat}(2^M,\mathbb{C})`),
        " とおく（",
        ref("def_kronecker"),
        " のクロネッカー積。これは ",
        math(String.raw`2^M`),
        " 次の複素行列である）。",
        math(String.raw`\mathcal{E}:=\{E_{IJ}:I,J\in\{1,2\}^M\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の基底である（",
        ref("tensor_basis"),
        " (1)）。その元数は ",
        math(String.raw`\#\mathcal{E}=(2^M)^2=4^M`),
        "。",
      ]),
      paragraph([
        "Step 2: 行列単位 ",
        math(String.raw`E_{IJ}`),
        " の積公式。",
        math(String.raw`I,J,K,L\in\{1,2\}^M`),
        " について、",
        ref("kronecker_product_rule"),
        " (1)、",
        ref("kronecker_multilinear"),
        " と Step 1 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_{IJ} E_{KL}
&= (E_{i_1 j_1}\boxtimes\cdots\boxtimes E_{i_M j_M})(E_{k_1 l_1}\boxtimes\cdots\boxtimes E_{k_M l_M}) \\
&= (E_{i_1 j_1}E_{k_1 l_1})\boxtimes\cdots\boxtimes(E_{i_M j_M}E_{k_M l_M})
&&(\because \text{クロネッカー積の積の規則}) \\
&= (\delta_{j_1 k_1}E_{i_1 l_1})\boxtimes\cdots\boxtimes(\delta_{j_M k_M}E_{i_M l_M})
&&(\because E_{ij}E_{kl}=\delta_{jk}E_{il}) \\
&= \left(\prod_{r=1}^M \delta_{j_r k_r}\right)E_{IL}
&&(\because \text{各因子についての線型性を } M \text{ 回})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\delta_{JK}:=\prod_{r=1}^M \delta_{j_r k_r}`),
        " とおくと、これは ",
        math(String.raw`J=K`),
        " のとき ",
        math(String.raw`1`),
        "、そうでなければ ",
        math(String.raw`0`),
        " であるから ",
        math(String.raw`E_{IJ}E_{KL}=\delta_{JK}E_{IL}`),
        "。また各因子に ",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}=E_{11}+E_{22}`),
        " を代入して展開すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
I_{\mathrm{Mat}(2^M,\mathbb{C})}
&= I_{\mathrm{Mat}(2,\mathbb{C})}\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}
&&(\because \text{クロネッカー積の積の規則 (2) を右辺から左辺へ}) \\
&= (E_{11}+E_{22})\boxtimes\cdots\boxtimes(E_{11}+E_{22})
&&(\because I_{\mathrm{Mat}(2,\mathbb{C})}=E_{11}+E_{22}) \\
&= \sum_{P=(p_1,\dots,p_M)\in\{1,2\}^M}
   E_{p_1 p_1}\boxtimes\cdots\boxtimes E_{p_M p_M}
&&(\because \text{各因子についての線型性を } M \text{ 回}) \\
&= \sum_{P\in\{1,2\}^M} E_{PP}
&&(\because E_{PP} \text{ の定め方})
\end{aligned}`,
      ),
      paragraph([
        "（引いたのは ",
        ref("kronecker_product_rule"),
        " (2) と ",
        ref("kronecker_multilinear"),
        " である）。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`W`),
        " を行列単位で展開し、可換性から係数を決定する。",
        math(String.raw`\mathcal{E}`),
        " は基底であるから ",
        math(String.raw`W`),
        " は一意に ",
        math(String.raw`W=\sum_{I,J\in\{1,2\}^M} w_{IJ}E_{IJ}`),
        "（",
        math(String.raw`w_{IJ}\in\mathbb{C}`),
        "）と展開できる。仮定より各 ",
        math(String.raw`E_{KL}`),
        " について ",
        math(String.raw`W E_{KL}=E_{KL} W`),
        "。左辺は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
W E_{KL}
&= \left(\sum_{I,J} w_{IJ}E_{IJ}\right)E_{KL}
&&(\because W \text{ の基底 } \mathcal{E} \text{ による展開}) \\
&= \sum_{I,J} w_{IJ}(E_{IJ}E_{KL})
&&(\because \text{積の双線型性}) \\
&= \sum_{I,J} w_{IJ}\delta_{JK}E_{IL}
&&(\because \text{Step 2 の積公式}) \\
&= \sum_{I\in\{1,2\}^M} w_{IK}E_{IL}
&&(\because \delta_{JK} \text{ は } J=K \text{ でのみ非零})
\end{aligned}`,
      ),
      paragraph(["右辺は"]),
      displayMath(
        String.raw`\begin{aligned}
E_{KL} W
&= E_{KL}\left(\sum_{I,J} w_{IJ}E_{IJ}\right)
&&(\because W \text{ の基底 } \mathcal{E} \text{ による展開}) \\
&= \sum_{I,J} w_{IJ}(E_{KL}E_{IJ})
&&(\because \text{積の双線型性}) \\
&= \sum_{I,J} w_{IJ}\delta_{LI}E_{KJ}
&&(\because \text{Step 2 の積公式}) \\
&= \sum_{J\in\{1,2\}^M} w_{LJ}E_{KJ}
&&(\because \delta_{LI} \text{ は } I=L \text{ でのみ非零})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mathcal{E}`),
        " は基底であるから両辺の係数は一致する。任意に ",
        math(String.raw`P,Q\in\{1,2\}^M`),
        " を固定し ",
        math(String.raw`E_{PQ}`),
        " の係数を比較する。",
      ]),
      paragraph([
        "場合 1: ",
        math(String.raw`Q=L`),
        " かつ ",
        math(String.raw`P=K`),
        " のとき。左辺で ",
        math(String.raw`E_{PL}`),
        " の係数は ",
        math(String.raw`w_{PK}=w_{KK}`),
        "、右辺で ",
        math(String.raw`E_{KQ}`),
        " の係数は ",
        math(String.raw`w_{LQ}=w_{LL}`),
        " であるから ",
        math(String.raw`w_{KK}=w_{LL}`),
        "。これは任意の ",
        math(String.raw`K,L`),
        " で成立するから対角係数は ",
        math(String.raw`K`),
        " によらない定数 ",
        math(String.raw`c:=w_{KK}`),
        " である。",
      ]),
      paragraph([
        "場合 2: ",
        math(String.raw`K\neq L`),
        " とし ",
        math(String.raw`P=K,\ Q=K`),
        " のとき（",
        math(String.raw`E_{KK}`),
        " の係数比較）。第 2 添字が ",
        math(String.raw`K\neq L`),
        " なので左辺に ",
        math(String.raw`E_{KK}`),
        " は現れず係数は ",
        math(String.raw`0`),
        "、右辺で ",
        math(String.raw`E_{KK}`),
        " の係数は ",
        math(String.raw`w_{LK}`),
        " であるから ",
        math(String.raw`w_{LK}=0`),
        "。すなわち ",
        math(String.raw`I\neq J`),
        " なる非対角係数 ",
        math(String.raw`w_{IJ}`),
        " はすべて ",
        math(String.raw`0`),
        "。",
      ]),
      paragraph(["Step 4: 結論。"]),
      displayMath(
        String.raw`\begin{aligned}
W
&= \sum_{I,J\in\{1,2\}^M} w_{IJ}E_{IJ}
&&(\because \text{Step 3 の } W \text{ の基底 } \mathcal{E} \text{ による展開}) \\
&= \sum_{P\in\{1,2\}^M} w_{PP}E_{PP}
&&(\because \text{Step 3: 非対角係数は } 0) \\
&= \sum_{P\in\{1,2\}^M} c\,E_{PP}
&&(\because \text{Step 3: 対角係数は共通の } c) \\
&= c\sum_{P\in\{1,2\}^M} E_{PP}
&&(\because \text{和のスカラー倍}) \\
&= c\cdot I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because I_{\mathrm{Mat}(2^M,\mathbb{C})}=\sum_{P\in\{1,2\}^M} E_{PP})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "抽象テンソル積の記法を廃した。Mat(2,C)^{⊗M}（抽象テンソル冪）を <def_kronecker> の" +
          "クロネッカー積が住む具体的な空間 Mat(2^M,C) へ、I_{(Mat(2,C))^{⊗M}} を 2^M 次の" +
          "単位行列 I_{Mat(2^M,C)} へ置き換えた（README のゴール設定 2 節に従う）。",
        "2026-08-17: 式変形の書き方の統一。Step 3 の二本の鎖の第 1 段（W E_{KL}・E_{KL} W を展開で書く行）と" +
          "Step 4 の鎖の第 1 段（W の展開）に根拠が無かったので、行末に (∵ W の基底 𝓔 による展開) を置いた。" +
          "段は増減せず、主張も証明の筋も変えていない。",
        "2026-09-01 の式変形統一で、Step 3 の二本の鎖と Step 4 の鎖に行中の \\quad(\\because …) で" +
          "置かれていた根拠 13 行を、他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。" +
          "内容・式変形・根拠・参照は変えていない。",
      ],
    },
  },
  {
    id: "linear_space_general_002b_definition_matrix_norm",
    kind: "definition",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 3 },
    title: { text: "数ベクトル・行列のノルムと収束" },
    labels: ["def_matrix_norm"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`d, n \in \mathbb{Z}_{\geq 1}`),
        " とする。",
      ]),
      paragraph([
        math(String.raw`|\cdot| : K \to \mathbb{R}_{\geq 0}`),
        " を、",
        math(String.raw`K=\mathbb{R}`),
        " のときは実数の絶対値、",
        math(String.raw`K=\mathbb{C}`),
        " のときは ",
        ref("def_abs_arg"),
        " の絶対値とする（",
        ref("abs_basic_properties"),
        " (6) より、",
        math(String.raw`\mathbb{R}`),
        " を ",
        math(String.raw`\iota_{\mathbb{R}\to\mathbb{C}}`),
        " で ",
        math(String.raw`\mathbb{C}`),
        " に埋め込んだとき両者は一致する）。",
      ]),
      paragraph([
        math(String.raw`w = (w_1,\dots,w_d) \in K^d`),
        " のノルムを",
      ]),
      displayMath(
        String.raw`\|w\| := \sqrt{\sum_{i=1}^{d} |w_i|^2}^{\,(\mathbb{R}_{\ge 0})} \in \mathbb{R}_{\ge 0}`,
      ),
      paragraph([
        "と定める。また ",
        math(String.raw`A = (a_{ij})_{1\le i,j\le n} \in \mathrm{Mat}(n,K)`),
        " のノルムを",
      ]),
      displayMath(
        String.raw`\|A\| := \sqrt{\sum_{i=1}^{n}\sum_{j=1}^{n} |a_{ij}|^2}^{\,(\mathbb{R}_{\ge 0})} \in \mathbb{R}_{\ge 0}`,
      ),
      paragraph([
        "と定める（いずれも根号の中は非負実数の有限和なので ",
        ref("definition_of_sqrt_r_positive"),
        " により定まる）。",
      ]),
      paragraph([
        math(String.raw`\mathrm{Mat}(n,K)`),
        " の列 ",
        math(String.raw`(A_N)_{N \in \mathbb{Z}_{\ge 0}}`),
        " と ",
        math(String.raw`A \in \mathrm{Mat}(n,K)`),
        " について、",
      ]),
      displayMath(
        String.raw`A_N \to A \overset{\mathrm{def}}{\Longleftrightarrow}
\|A_N - A\| \to 0 \ (N\to\infty)`,
      ),
      paragraph([
        "と定める（右辺は実数列 ",
        math(String.raw`(\|A_N-A\|)_N`),
        " の ",
        math(String.raw`0`),
        " への収束）。このとき ",
        math(String.raw`A`),
        " を ",
        math(String.raw`(A_N)`),
        " の極限といい ",
        math(String.raw`A = \lim_{N\to\infty} A_N`),
        " と書く。さらに ",
        math(String.raw`B_0, B_1, \dots \in \mathrm{Mat}(n,K)`),
        " について、部分和 ",
        math(String.raw`S_N := \sum_{m=0}^{N} B_m`),
        " が ",
        math(String.raw`S`),
        " に収束するとき",
      ]),
      displayMath(String.raw`\sum_{m=0}^{\infty} B_m := S`),
      paragraph(["と書く。"]),
      paragraph([
        math(String.raw`K^d`),
        " の列の収束も同様に ",
        math(String.raw`\|w_N - w\| \to 0`),
        " で定める。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。原文は行列ノルムの劣乗法性" +
          "（labels: matrix_norm_submultiplicativity）や exp 級数の収束（labels: exp_converges）で" +
          "ノルム記号を使うが、ノルムそのものの定義がどこにも無かったため、" +
          "初出の直前に置いた。採用したのは Frobenius ノルム（成分の平方和の平方根）で、" +
          "これは 005 章の M(n;C) の内積・ノルムの定義（原文では TODO）が意図する" +
          "Hilbert--Schmidt 内積 ⟨A,B⟩ = tr(A^* B) から定まるノルムと同一である。",
      ],
    },
  },
  {
    id: "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 3 },
    title: { text: "ノルムの基本性質（非退化性・斉次性・三角不等式）" },
    labels: ["matrix_norm_triangle_inequality"],
    statement: [
      paragraph([
        ref("def_matrix_norm"),
        " のノルムについて、",
        math(String.raw`A, B \in \mathrm{Mat}(n,K)`),
        "、",
        math(String.raw`c \in K`),
        " に対して次が成り立つ。",
      ]),
      list([
        [
          "(1) ",
          math(String.raw`\|A\| \ge 0`),
          " であり、",
          math(String.raw`\|A\| = 0 \iff A = O`),
          "（",
          math(String.raw`O`),
          " は零行列）。",
        ],
        ["(2) ", math(String.raw`\|cA\| = |c|\,\|A\|`), "。"],
        ["(3) ", math(String.raw`\|A+B\| \le \|A\| + \|B\|`), "。"],
        [
          "(4) ",
          ref("def_matrix_norm"),
          " の意味での極限は、存在すれば一意である。すなわち ",
          math(String.raw`A_N \to A`),
          " かつ ",
          math(String.raw`A_N \to A'`),
          " ならば ",
          math(String.raw`A = A'`),
          "。",
        ],
      ]),
      paragraph([
        math(String.raw`K^d`),
        " のノルムについても同じ 4 つが成り立つ（証明は成分の添字を 1 重にするだけで同一）。",
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`A=(a_{ij})`),
        "、",
        math(String.raw`B=(b_{ij})`),
        " とおき、和は ",
        math(String.raw`1\le i,j\le n`),
        " の全体にわたるものとする。",
      ]),
      paragraph([
        "Step 0: 補題（非負実数の平方の単調性）。",
        math(String.raw`u,v\in\mathbb{R}_{\ge 0}`),
        " について",
      ]),
      displayMath(String.raw`u\le v \iff u^2\le v^2`),
      paragraph([
        "が成り立つ。実際、", math(String.raw`u\le v`), " ならば",
      ]),
      displayMath(String.raw`\begin{aligned}
u^2&=u\cdot u &&(\because\ \text{平方の定義})\\
&\le v\cdot u &&(\because\ u\le v,\ u\ge0)\\
&\le v\cdot v &&(\because\ u\le v,\ v\ge0)\\
&=v^2 &&(\because\ \text{平方の定義})
\end{aligned}`),
      paragraph([
        "である。逆に ", math(String.raw`u>v\ (\ge 0)`), " ならば ",
        math(String.raw`u>0`), " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
u^2&=u\cdot u &&(\because\ \text{平方の定義})\\
&>v\cdot u &&(\because\ u>v,\ u>0)\\
&\ge v\cdot v &&(\because\ u>v,\ v\ge0)\\
&=v^2 &&(\because\ \text{平方の定義})
\end{aligned}`),
      paragraph([
        "であるから、対偶により ",
        math(String.raw`u^2\le v^2\Rightarrow u\le v`),
        "。特に ",
        math(String.raw`u^2=v^2\Rightarrow u=v`),
        "。",
      ]),
      paragraph([
        "Step 1: 絶対値の性質。",
        math(String.raw`z,w\in K`),
        " について",
      ]),
      displayMath(
        String.raw`|z|\ge 0, \qquad |zw|=|z|\,|w|, \qquad |z+w|\le|z|+|w|,
\qquad \left(|z|=0\iff z=0\right)`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`K=\mathbb{C}`),
        " のときは ",
        ref("abs_basic_properties"),
        " (3)(4)(5) と ",
        ref("def_abs_arg"),
        "（値域が ",
        math(String.raw`\mathbb{R}_{\ge 0}`),
        "）による。",
        math(String.raw`K=\mathbb{R}`),
        " のときは、",
        ref("inclusion_rr_to_cc"),
        " の ",
        math(String.raw`\iota_{\mathbb{R}\to\mathbb{C}}`),
        " が和と積を保つこと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\iota_{\mathbb{R}\to\mathbb{C}}(x)+\iota_{\mathbb{R}\to\mathbb{C}}(y)
&= (x,0)+(y,0)
&&(\because \iota_{\mathbb{R}\to\mathbb{C}} \text{ の定め方}) \\
&= (x+y,0)
&&(\because \text{複素数の和の定め方}) \\
&= \iota_{\mathbb{R}\to\mathbb{C}}(x+y)
&&(\because \iota_{\mathbb{R}\to\mathbb{C}} \text{ の定め方})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\iota_{\mathbb{R}\to\mathbb{C}}(x)\cdot\iota_{\mathbb{R}\to\mathbb{C}}(y)
&= (x,0)\cdot(y,0)
&&(\because \iota_{\mathbb{R}\to\mathbb{C}} \text{ の定め方}) \\
&= (xy-0\cdot 0,\ x\cdot 0+0\cdot y)
&&(\because \text{複素数の積の定め方}) \\
&= (xy,0)
&&(\because 0 \text{ を掛けた項が消えること}) \\
&= \iota_{\mathbb{R}\to\mathbb{C}}(xy)
&&(\because \iota_{\mathbb{R}\to\mathbb{C}} \text{ の定め方})
\end{aligned}`,
      ),
      paragraph([
        "と ",
        ref("abs_basic_properties"),
        " (6) を組み合わせて同じ 4 つの性質が従う。たとえば ",
        math(String.raw`x,y\in\mathbb{R}`),
        " について ",
        math(String.raw`|x+y|=\left|\iota_{\mathbb{R}\to\mathbb{C}}(x+y)\right|
=\left|\iota_{\mathbb{R}\to\mathbb{C}}(x)+\iota_{\mathbb{R}\to\mathbb{C}}(y)\right|
\le\left|\iota_{\mathbb{R}\to\mathbb{C}}(x)\right|+\left|\iota_{\mathbb{R}\to\mathbb{C}}(y)\right|=|x|+|y|`),
        " であり、乗法性・非負性・非退化性も同様である。",
      ]),
      paragraph([
        "Step 2: (1)。",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`\|A\|\ge 0`),
        "。また Step 0 より ",
        math(String.raw`\|A\|=0`),
        " と ",
        math(String.raw`\|A\|^2=0`),
        " は同値であり、",
      ]),
      displayMath(
        String.raw`\|A\|^2=\sum_{i,j}|a_{ij}|^2`,
      ),
      paragraph([
        "は非負実数の有限和であるから、",
        math(String.raw`\|A\|^2=0`),
        " と「すべての ",
        math(String.raw`i,j`),
        " について ",
        math(String.raw`|a_{ij}|^2=0`),
        "」は同値（非負数の有限和が ",
        math(String.raw`0`),
        " ならば各項が ",
        math(String.raw`0`),
        "、逆も明らか）。Step 1 より ",
        math(String.raw`|a_{ij}|=0\iff a_{ij}=0`),
        " であるから ",
        math(String.raw`\|A\|=0\iff A=O`),
        "。",
      ]),
      paragraph(["Step 3: (2)。Step 1 の乗法性より、"]),
      displayMath(
        String.raw`\begin{aligned}
\|cA\|^2
&= \sum_{i,j}|c\,a_{ij}|^2
&&(\because \text{ノルムの定め方と } (cA)_{ij}=c\,a_{ij}) \\
&= \sum_{i,j}\left(|c|\,|a_{ij}|\right)^2
&&(\because \text{Step 1 の乗法性 } |zw|=|z||w|) \\
&= \sum_{i,j}|c|^2\,|a_{ij}|^2
&&(\because \text{積の平方は平方の積}) \\
&= |c|^2\sum_{i,j}|a_{ij}|^2
&&(\because \text{有限和についての分配律}) \\
&= |c|^2\,\|A\|^2
&&(\because \text{ノルムの定め方}) \\
&= \left(|c|\,\|A\|\right)^2
&&(\because \text{積の平方は平方の積})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\|cA\|\ge 0`),
        " かつ ",
        math(String.raw`|c|\,\|A\|\ge 0`),
        " であるから Step 0 より ",
        math(String.raw`\|cA\|=|c|\,\|A\|`),
        "。",
      ]),
      paragraph([
        "Step 4: 有限列に対する Cauchy--Schwarz の不等式。",
        math(String.raw`m\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`u_1,\dots,u_m,v_1,\dots,v_m\in\mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`\left(\sum_{k=1}^{m}u_kv_k\right)^2
\le \left(\sum_{k=1}^{m}u_k^2\right)\left(\sum_{k=1}^{m}v_k^2\right)`,
      ),
      paragraph([
        "が成り立つ。実際 ",
        math(String.raw`P:=\sum_k u_k^2,\ Q:=\sum_k v_k^2,\ R:=\sum_k u_kv_k`),
        " とおく。",
        math(String.raw`Q=0`),
        " のときは非負数の有限和が ",
        math(String.raw`0`),
        " であることから各 ",
        math(String.raw`v_k^2=0`),
        " すなわち ",
        math(String.raw`v_k=0`),
        " となり ",
        math(String.raw`R=0`),
        " であるから ",
        math(String.raw`R^2=0=PQ`),
        "。",
        math(String.raw`Q>0`),
        " のときは、任意の ",
        math(String.raw`t\in\mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le\sum_{k=1}^{m}(u_k-tv_k)^2
&&(\because \text{実数の平方は非負であり、非負数の有限和は非負}) \\
&= \sum_{k=1}^{m}\left(u_k^2-2tu_kv_k+t^2v_k^2\right)
&&(\because \text{分配律}) \\
&= P-2tR+t^2Q
&&(\because P,\ Q,\ R \text{ の置き方と有限和の分解})
\end{aligned}`,
      ),
      paragraph([
        "であるから、",
        math(String.raw`t:=R/Q`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le P-2\frac{R}{Q}R+\left(\frac{R}{Q}\right)^2Q
&&(\because \text{上の不等式に } t=R/Q \text{ を代入した}) \\
&= P-2\frac{R^2}{Q}+\frac{R^2}{Q}
&&(\because Q>0 \text{ による約分}) \\
&= P-\frac{R^2}{Q}
&&(\because \text{同類項をまとめた})
\end{aligned}`,
      ),
      paragraph(["となる。したがって"]),
      displayMath(
        String.raw`\begin{aligned}
R^2
&= \frac{R^2}{Q}\cdot Q
&&(\because Q>0 \text{ と } \mathbb{R} \text{ の四則}) \\
&\le P\cdot Q
&&(\because \text{直前の } 0\le P-R^2/Q \text{ の移項による } R^2/Q\le P \text{ と、両辺に正の数 } Q \text{ を掛けても順序が保たれること})
\end{aligned}`,
      ),
      paragraph([
        "を得る。すなわち ",
        math(String.raw`R^2\le PQ`),
        "。",
      ]),
      paragraph([
        "Step 5: (3)。Step 1 の三角不等式と Step 0 より、各 ",
        math(String.raw`i,j`),
        " について ",
        math(String.raw`|a_{ij}+b_{ij}|\le|a_{ij}|+|b_{ij}|`),
        " であり、両辺とも非負なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|a_{ij}+b_{ij}|^2
&\le\left(|a_{ij}|+|b_{ij}|\right)^2
&&(\because \text{Step 0 を } u=|a_{ij}+b_{ij}|,\ v=|a_{ij}|+|b_{ij}| \text{ に当てた}) \\
&= |a_{ij}|^2+2|a_{ij}||b_{ij}|+|b_{ij}|^2
&&(\because \text{分配律})
\end{aligned}`,
      ),
      paragraph(["これを ", math(String.raw`i,j`), " について加えると、"]),
      displayMath(
        String.raw`\begin{aligned}
\|A+B\|^2
&= \sum_{i,j}|a_{ij}+b_{ij}|^2
&&(\because \text{ノルムの定め方と } (A+B)_{ij}=a_{ij}+b_{ij}) \\
&\le \sum_{i,j}\left(|a_{ij}|^2+2|a_{ij}||b_{ij}|+|b_{ij}|^2\right)
&&(\because \text{上の各項ごとの不等式を } i,j \text{ について加えた}) \\
&= \sum_{i,j}|a_{ij}|^2+2\sum_{i,j}|a_{ij}||b_{ij}|+\sum_{i,j}|b_{ij}|^2
&&(\because \text{有限和の分解と分配律}) \\
&= \|A\|^2+2\sum_{i,j}|a_{ij}||b_{ij}|+\|B\|^2
&&(\because \text{ノルムの定め方})
\end{aligned}`,
      ),
      paragraph([
        "ここで Step 4 を ",
        math(String.raw`m=n^2`),
        " 個の添字 ",
        math(String.raw`(i,j)`),
        " について ",
        math(String.raw`u_{(i,j)}=|a_{ij}|,\ v_{(i,j)}=|b_{ij}|`),
        " として適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sum_{i,j}|a_{ij}||b_{ij}|\right)^2
&\le\left(\sum_{i,j}|a_{ij}|^2\right)\left(\sum_{i,j}|b_{ij}|^2\right)
&&(\because \text{Step 4}) \\
&= \|A\|^2\|B\|^2
&&(\because \text{ノルムの定め方}) \\
&= \left(\|A\|\,\|B\|\right)^2
&&(\because \text{積の平方は平方の積})
\end{aligned}`,
      ),
      paragraph(["である。また"]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le \sum_{i,j}|a_{ij}||b_{ij}|
&&(\because\ \text{非負実数の有限和は非負}) \\
0
&\le \|A\|\,\|B\|
&&(\because\ \text{ノルムは非負であり、非負実数の積は非負}) \\
\sum_{i,j}|a_{ij}||b_{ij}|
&\le \|A\|\,\|B\|
&&(\because\ \text{直前の平方の不等式と Step 0})
\end{aligned}`,
      ),
      paragraph(["よって"]),
      displayMath(
        String.raw`\begin{aligned}
\|A+B\|^2
&\le\|A\|^2+2\sum_{i,j}|a_{ij}||b_{ij}|+\|B\|^2
&&(\because \text{上の式変形}) \\
&\le\|A\|^2+2\|A\|\,\|B\|+\|B\|^2
&&(\because \sum_{i,j}|a_{ij}||b_{ij}|\le\|A\|\,\|B\|) \\
&=\left(\|A\|+\|B\|\right)^2
&&(\because \text{分配律})
\end{aligned}`,
      ),
      paragraph([
        "となり、両辺の平方根をとる（Step 0、",
        math(String.raw`\|A+B\|\ge 0`),
        "、",
        math(String.raw`\|A\|+\|B\|\ge 0`),
        "）ことで ",
        math(String.raw`\|A+B\|\le\|A\|+\|B\|`),
        " を得る。",
      ]),
      paragraph([
        "Step 6: (4)。",
        math(String.raw`A_N\to A`),
        " かつ ",
        math(String.raw`A_N\to A'`),
        " とする。各 ",
        math(String.raw`N`),
        " について ",
        math(String.raw`A-A'=(A-A_N)+(A_N-A')`),
        " であるから、Step 5 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le\|A-A'\|
&&(\because \text{(1)}) \\
&\le\|A-A_N\|+\|A_N-A'\|
&&(\because \text{Step 5 を } A-A'=(A-A_N)+(A_N-A') \text{ に当てた}) \\
&= \|A_N-A\|+\|A_N-A'\|
&&(\because\ A-A_N=(-1)(A_N-A) \text{ と Step 3（} c=-1 \text{）、および } |-1|=1 \text{（} K=\mathbb{C} \text{ のときは } \blkref{abs_basic_properties} \text{ (6) より } |-1_{\mathbb{C}}|=|-1|=1 \text{）})
\end{aligned}`,
      ),
      paragraph([
        "右辺は ",
        math(String.raw`N\to\infty`),
        " で ",
        math(String.raw`0`),
        " に収束する実数列であり、左辺の ",
        math(String.raw`\|A-A'\|`),
        " は ",
        math(String.raw`N`),
        " によらない定数である。非負の定数が ",
        math(String.raw`0`),
        " に収束する列で上から抑えられるならその定数は ",
        math(String.raw`0`),
        " であるから ",
        math(String.raw`\|A-A'\|=0`),
        "、Step 2 より ",
        math(String.raw`A-A'=O`),
        " すなわち ",
        math(String.raw`A=A'`),
        "。",
      ]),
      paragraph([
        "Step 7: ",
        math(String.raw`K^d`),
        " の場合。上の Step 2・Step 3・Step 5・Step 6 で添字の組 ",
        math(String.raw`(i,j)`),
        " を単一の添字 ",
        math(String.raw`i`),
        " に置き換えれば、同じ議論がそのまま通用する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。ノルムの定義（labels: def_matrix_norm）を置いた以上、" +
          "極限の一意性や行列乗算の連続性（labels: matrix_multiplication_continuity）の議論が" +
          "前提としている非退化性・斉次性・三角不等式を明示的に証明しておく必要があるため追加した。",
        "2026-08-10: 式変形の書き方の統一。証明の中の 8 つの式が、1 行に 2 つ以上の等号・不等号を" +
          "並べたうえで根拠を 1 つだけ（あるいは 1 つも）付けていなかったので、" +
          "1 行 1 関係の鎖へ分け、各行の末尾に (∵ …) を置いた。" +
          "対象は、実数を複素数へ送る写像が和と積を保つことの 2 式、斉次性の式、" +
          "Cauchy--Schwarz の証明の 2 式、三角不等式の 4 式、極限の一意性の式である。" +
          "段は増えており、減った段は無い。主張も証明の筋も変えていない。",
        "2026-09-04: 式変形の書き方の統一。Cauchy--Schwarz の結びで散文に埋まっていた" +
          "「両辺に Q>0 を掛けて R^2≤PQ」を、R^2 から始まり PQ へ至る二段の式変形と" +
          "行末の根拠（移項と、正の数を掛けても順序が保たれること）へ開いた。内容と根拠は変えていない。",
        "2026-09-04: 式変形の書き方の統一。Step 5 で平方の不等式から平方根側の" +
          "不等式を得る推論が散文に埋まっていたので、両辺の非負性と Step 0 の適用を" +
          "三行の表示へ開いた。内容と根拠は変えていない。",
        "2026-09-04: 式変形の書き方の統一。Step 6 の最後の等号の根拠が式変形の後の" +
          "散文段落に置かれていたので、その行の末尾の (∵ …) へ移した" +
          "（Step 3 の c=-1 と |-1|=1 の参照を含む）。内容と根拠は変えていない。",
      ],
    },
  },
  {
    id: "linear_space_general_003_claim_matrix_norm_submultiplicativity",
    kind: "claim",
    origin: { path: "_old/typst/parts/002_線型空間の一般論/002_claim_行列ノルムの劣乗法性.typ", ordinal: 3 },
    title: { text: "行列ノルムの劣乗法性" },
    labels: ["matrix_norm_submultiplicativity"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A, B \in \mathrm{Mat}(n, K)`),
        " について、",
      ]),
      displayMath(String.raw`\|AB\| \leq \|A\| \cdot \|B\|`),
      paragraph([
        "ここで ",
        math(String.raw`\|\cdot\|`),
        " は ",
        ref("def_matrix_norm"),
        " のノルムである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`A=(a_{ij})_{1\le i,j\le n}`),
        "、",
        math(String.raw`B=(b_{ij})_{1\le i,j\le n}`),
        " とおく。行列の積の定義より ",
        math(String.raw`(AB)_{ij}=\sum_{k=1}^{n}a_{ik}b_{kj}`),
        " である。",
      ]),
      paragraph([
        "Step 1: 有限和の三角不等式。",
        math(String.raw`m\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`z_1,\dots,z_m\in K`),
        " について",
      ]),
      displayMath(
        String.raw`\left|\sum_{k=1}^{m}z_k\right|\le\sum_{k=1}^{m}|z_k|`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`m`),
        " に関する帰納法で示す。",
        math(String.raw`m=1`),
        " のときは両辺とも ",
        math(String.raw`|z_1|`),
        " で等号成立。",
        math(String.raw`m`),
        " で成り立つと仮定すると、",
        ref("matrix_norm_triangle_inequality"),
        " の Step 1（絶対値の三角不等式）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\sum_{k=1}^{m+1}z_k\right|
&= \left|\left(\sum_{k=1}^{m}z_k\right)+z_{m+1}\right| \\
&\le \left|\sum_{k=1}^{m}z_k\right|+|z_{m+1}| &&(\because\ \blkref{matrix_norm_triangle_inequality}\text{ の Step 1}) \\
&\le \sum_{k=1}^{m}|z_k|+|z_{m+1}| &&(\because\ \text{帰納法の仮定}) \\
&= \sum_{k=1}^{m+1}|z_k| &&(\because\ \text{有限和の末項の吸収})
\end{aligned}`,
      ),
      paragraph([
        "Step 2: 各成分の評価。",
        math(String.raw`1\le i,j\le n`),
        " を固定する。Step 1 と絶対値の乗法性（",
        ref("matrix_norm_triangle_inequality"),
        " の Step 1）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|(AB)_{ij}\right|
&= \left|\sum_{k=1}^{n}a_{ik}b_{kj}\right| &&(\because\ \text{行列の積の定義}) \\
&\le \sum_{k=1}^{n}\left|a_{ik}b_{kj}\right| &&(\because\ \text{Step 1}) \\
&= \sum_{k=1}^{n}|a_{ik}|\,|b_{kj}| &&(\because\ \text{絶対値の乗法性})
\end{aligned}`,
      ),
      paragraph([
        "である。ここから、",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0（非負実数の平方の単調性）と Step 4（Cauchy--Schwarz の不等式）により",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|(AB)_{ij}\right|^2
&\le \left(\sum_{k=1}^{n}|a_{ik}|\,|b_{kj}|\right)^2 &&(\because\ \text{直前の評価と }\blkref{matrix_norm_triangle_inequality}\text{ の Step 0}) \\
&\le \left(\sum_{k=1}^{n}|a_{ik}|^2\right)\left(\sum_{k=1}^{n}|b_{kj}|^2\right) &&(\because\ \blkref{matrix_norm_triangle_inequality}\text{ の Step 4 を } u_k=|a_{ik}|,\ v_k=|b_{kj}| \text{ として適用}) \\
&= \left(\sum_{k=1}^{n}|a_{ik}|^2\right)\left(\sum_{l=1}^{n}|b_{lj}|^2\right) &&(\because\ \text{第 2 因子の和の添字の付け替え})
\end{aligned}`,
      ),
      paragraph([
        "Step 3: 全成分についての和。Step 2 の不等式を ",
        math(String.raw`1\le i,j\le n`),
        " について加えると、右辺の第 1 因子は ",
        math(String.raw`i`),
        " のみ、第 2 因子は ",
        math(String.raw`j`),
        " のみに依存するので二重和が積に分解して、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|AB\|^2
&= \sum_{i=1}^{n}\sum_{j=1}^{n}\left|(AB)_{ij}\right|^2 &&(\because\ \|\cdot\| \text{ の定義と } \left(\sqrt{a}^{(\mathbb{R}_{\ge 0})}\right)^2=a) \\
&\le \sum_{i=1}^{n}\sum_{j=1}^{n}
\left(\sum_{k=1}^{n}|a_{ik}|^2\right)\left(\sum_{l=1}^{n}|b_{lj}|^2\right) &&(\because\ \text{Step 2}) \\
&= \left(\sum_{i=1}^{n}\sum_{k=1}^{n}|a_{ik}|^2\right)
   \left(\sum_{j=1}^{n}\sum_{l=1}^{n}|b_{lj}|^2\right) &&(\because\ \text{有限和の分配律}) \\
&= \|A\|^2\,\|B\|^2 &&(\because\ \|\cdot\| \text{ の定義と } \left(\sqrt{a}^{(\mathbb{R}_{\ge 0})}\right)^2=a) \\
&= \left(\|A\|\cdot\|B\|\right)^2 &&(\because\ \text{非負実数の積の平方 } (xy)^2=x^2y^2)
\end{aligned}`,
      ),
      paragraph([
        "Step 4: 結論。",
        math(String.raw`\|AB\|\ge 0`),
        " かつ ",
        math(String.raw`\|A\|\cdot\|B\|\ge 0`),
        " であるから、",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0 より",
      ]),
      displayMath(String.raw`\|AB\|\le\|A\|\cdot\|B\|
\qquad(\because\ \blkref{matrix_norm_triangle_inequality}\text{ の Step 0 を Step 3 の平方の不等式へ適用})`),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-08-10: Step 2（各成分の評価）が、3 つの式を別々の displayMath に置き、" +
          "その間に「両辺は非負であるから」「さらに…適用すると」「よって」という日本語を" +
          "挟んでいた。どの不等号がどの根拠によるのかが式から読み取れないので、" +
          "平方以降を 1 行 1 関係の 3 段の鎖へまとめ、各行の末尾に (∵ …) を置いた" +
          "（平方の単調性・Cauchy--Schwarz・和の添字の付け替えが別々の根拠であることが式の上に現れる）。" +
          "あわせて、鎖の第 1 段（絶対値を行列の積の定義で書き下す段）に根拠が無かったので付けた。" +
          "段は増えており、減った段は無い。主張も証明の筋も変えていない。",
        "2026-08-31: 根拠の無い行が四つ残っていた（Step 1 の末項の吸収の段、Step 2 の" +
          "行列の積の定義で書き下す段、Step 3 のノルムの定義へ戻す段と積の平方へまとめる段）。" +
          "それぞれの行末に (∵ …) を付けた。式・段数・主張・証明の筋は変えていない。",
        "2026-09-02 の式変形統一で、四本の鎖の根拠 14 行を行中の \\quad (\\because …) から" +
          "行末の根拠列（aligned の &&）へ揃えた。式変形・根拠・段数・参照は変えていない。",
        "2026-09-04: 式変形の書き方の統一。Step 4 の結論式の根拠が直前の散文だけに" +
          "置かれていたので、式の行末へ Step 0 と Step 3 の平方の不等式を明記した。" +
          "内容・式変形・根拠は変えていない。",
        "2026-09-04: 式変形の書き方の統一。行列ノルムの基本性質を使う四つの行で、" +
          "根拠名だけを書いていた箇所へ対応ラベルを行末から直接付けた。" +
          "内容・式変形・根拠は変えていない。",
        "原文の proof は TODO のみ。ここで証明を与えた。" +
          "原文にはノルムの定義そのものが無かったため、Frobenius ノルムを定義するブロック" +
          "（labels: def_matrix_norm）とその基本性質のブロック（labels: matrix_norm_triangle_inequality）を" +
          "本ブロックの直前に追加している。",
      ],
    },
  },
  {
    id: "linear_space_general_003c_claim_matrix_norm_vector_bound",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 3 },
    title: { text: "行列ノルムによる数ベクトルの評価" },
    labels: ["matrix_norm_vector_bound"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,K)`),
        "、",
        math(String.raw`w \in K^n`),
        " について、",
      ]),
      displayMath(String.raw`\|Aw\| \le \|A\| \cdot \|w\|`),
      paragraph([
        "ここで ",
        math(String.raw`\|\cdot\|`),
        " は ",
        ref("def_matrix_norm"),
        " のノルム（左辺と右辺第 2 因子は ",
        math(String.raw`K^n`),
        " のノルム、右辺第 1 因子は ",
        math(String.raw`\mathrm{Mat}(n,K)`),
        " のノルム）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`w=(w_1,\dots,w_n)`),
        " に対し、第 1 列が ",
        math(String.raw`w`),
        "、第 2 列以降が ",
        math(String.raw`0`),
        " である行列 ",
        math(String.raw`W\in\mathrm{Mat}(n,K)`),
        " を",
      ]),
      displayMath(
        String.raw`W_{i1} := w_i \quad (1\le i\le n), \qquad
W_{ij} := 0 \quad (1\le i\le n,\ 2\le j\le n)`,
      ),
      paragraph(["で定める。第 1 列の成分は"]),
      displayMath(String.raw`\begin{aligned}
(AW)_{i1}
&=\sum_{k=1}^{n}a_{ik}W_{k1}
&&(\because\ \text{行列の積の定義})\\
&=\sum_{k=1}^{n}a_{ik}w_k
&&(\because\ W\ \text{の第 1 列の定め方})\\
&=(Aw)_i
&&(\because\ \text{行列と数ベクトルの積の定義})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`2\le j\le n`),
        " について第 ",
        math(String.raw`j`),
        " 列の成分は",
      ]),
      displayMath(String.raw`\begin{aligned}
(AW)_{ij}
&=\sum_{k=1}^{n}a_{ik}W_{kj}
&&(\because\ \text{行列の積の定義})\\
&=\sum_{k=1}^{n}a_{ik}\cdot 0
&&(\because\ W\ \text{の第 2 列以降の定め方})\\
&=0
&&(\because\ 0\ \text{を掛けた項だけの有限和は}\ 0)
\end{aligned}`),
      paragraph(["である。これを使って"]),
      displayMath(String.raw`\begin{aligned}
\|AW\|
&=\sqrt{\sum_{i=1}^{n}\sum_{j=1}^{n}\left|(AW)_{ij}\right|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \text{ノルムの定義。}\blkref{def_matrix_norm})\\
&=\sqrt{\sum_{i=1}^{n}\left|(AW)_{i1}\right|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ |0|=0\ \text{（ノルムの基本性質の Step 1。}\blkref{matrix_norm_triangle_inequality}\text{）なので第 2 列以降は平方和に寄与しない})\\
&=\sqrt{\sum_{i=1}^{n}\left|(Aw)_i\right|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \text{上の第 1 列の成分の等式})\\
&=\|Aw\|
&&(\because\ \text{ノルムの定義。}\blkref{def_matrix_norm})
\end{aligned}`),
      paragraph([
        "、および",
      ]),
      displayMath(String.raw`\begin{aligned}
\|W\|
&=\sqrt{\sum_{i=1}^{n}\sum_{j=1}^{n}\left|W_{ij}\right|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ \text{ノルムの定義。}\blkref{def_matrix_norm})\\
&=\sqrt{\sum_{i=1}^{n}\left|W_{i1}\right|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ |0|=0\ \text{（ノルムの基本性質の Step 1。}\blkref{matrix_norm_triangle_inequality}\text{）なので第 2 列以降は平方和に寄与しない})\\
&=\sqrt{\sum_{i=1}^{n}\left|w_i\right|^2}^{\,(\mathbb{R}_{\ge 0})}
&&(\because\ W\ \text{の第 1 列の定め方})\\
&=\|w\|
&&(\because\ \text{ノルムの定義。}\blkref{def_matrix_norm})
\end{aligned}`),
      paragraph([
        "を得る。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\|Aw\|
&=\|AW\|
&&(\because\ \text{上の第 1 の等式})\\
&\le\|A\|\cdot\|W\|
&&(\because\ \text{行列ノルムの劣乗法性。}\blkref{matrix_norm_submultiplicativity})\\
&=\|A\|\cdot\|w\|
&&(\because\ \text{上の第 2 の等式})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。exp 級数の各点収束（labels: exp_converges）の証明で" +
          "行列ノルムから数ベクトルの評価へ移る箇所が必要になるため、劣乗法性の直後に置いた。",
        "2026-08-10: 式変形の書き方を統一した。もとは 4 つの式を別々に置き、その間に" +
          "「行列の積の定義より」「である。|0|=0 より第 2 列以降は平方和に寄与しないので」" +
          "「したがって …より」という日本語を挟んだうえ、1 つの式に 2 つ以上の等号を並べて" +
          "根拠を 1 つも書いていなかった。どの等号がどの根拠によるのかが式から読み取れないので、" +
          "1 行 1 関係の 4 つの鎖へ分け（第 1 列の成分・第 2 列以降の成分・‖AW‖=‖Aw‖ と ‖W‖=‖w‖・" +
          "結論）、各行の末尾に (∵ …) を置いた。この生成器は blkref を定義していないので、" +
          "(∵ …) には引いたブロックの題を書き、ラベル参照は式の直後に置いた。" +
          "段は増えており、減った段は無い（‖W‖=‖w‖ の側はもとが 2 つの等号を 1 行に並べていたので" +
          "4 段へ開いた）。主張も証明の筋も変えていない。",
        "2026-09-02: 三つの鎖の直後に置いていた参照一覧（ノルムの定義・ノルムの基本性質の Step 1・" +
          "劣乗法性）を削り、それらを実際に使う各行末の (∵ …) の \\blkref へ移した" +
          "（blkref が使えるようになったため）。内容・式変形・根拠・参照は不変である。",
      ],
    },
  },
  {
    id: "linear_space_general_003d_claim_matrix_completeness",
    kind: "claim",
    origin: { path: "structured-latex/content/002_linear_space_general.ts", ordinal: 3 },
    title: { tex: String.raw`\mathrm{Mat}(n,K) \text{ の完備性と絶対収束判定}` },
    labels: ["matrix_completeness"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " とし、ノルムと収束は ",
        ref("def_matrix_norm"),
        " のものとする。",
      ]),
      list([
        [
          "(1)（完備性）",
          math(String.raw`(A_N)_{N\ge 0}`),
          " を ",
          math(String.raw`\mathrm{Mat}(n,K)`),
          " の列とし、Cauchy 列である、すなわち",
          math(
            String.raw`\ \forall\varepsilon\in\mathbb{R}_{>0},\ \exists N_0\in\mathbb{Z}_{\ge 0}\ \text{s.t.}\ \forall N,M\ge N_0,\ \|A_N-A_M\|<\varepsilon\ `,
          ),
          "とする。このとき ",
          math(String.raw`A\in\mathrm{Mat}(n,K)`),
          " が存在して ",
          math(String.raw`A_N\to A`),
          "。",
        ],
        [
          "(2)（絶対収束判定）",
          math(String.raw`B_0,B_1,\dots\in\mathrm{Mat}(n,K)`),
          " について実数列の級数 ",
          math(String.raw`\sum_{m=0}^{\infty}\|B_m\|`),
          " が収束するならば ",
          math(String.raw`\sum_{m=0}^{\infty}B_m`),
          " は ",
          math(String.raw`\mathrm{Mat}(n,K)`),
          " において収束し、",
          math(String.raw`\left\|\sum_{m=0}^{\infty}B_m\right\|\le\sum_{m=0}^{\infty}\|B_m\|`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: 成分は ノルムで抑えられる。",
        math(String.raw`A=(a_{ij})\in\mathrm{Mat}(n,K)`),
        " と ",
        math(String.raw`1\le i,j\le n`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|a_{ij}|^2
&\le\sum_{k=1}^{n}\sum_{l=1}^{n}|a_{kl}|^2
&& (\because \text{非負項の有限和は各項以上})\\
&=\|A\|^2
&& (\because \text{行列ノルムの定義})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`|a_{ij}|\ge 0`),
        "、",
        math(String.raw`\|A\|\ge 0`),
        " であるから ",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0 より ",
        "次の一段を得る。",
      ]),
      displayMath(String.raw`|a_{ij}|\le\|A\|
\quad (\because \text{直前の平方の評価と非負実数の平方の単調性})`),
      paragraph([
        "Step 2: ",
        math(String.raw`K`),
        " の Cauchy 列は収束する。",
        math(String.raw`K=\mathbb{R}`),
        " のときは ",
        math(String.raw`\mathbb{R}`),
        " の完備性そのものである。",
        math(String.raw`K=\mathbb{C}`),
        " のとき、",
        math(String.raw`z=(x,y)\in\mathbb{C}`),
        " について ",
        ref("abs_basic_properties"),
        " (2) より、次の一続きの評価を得る。",
      ]),
      displayMath(String.raw`\begin{aligned}
|z|^2
&=x^2+y^2
&& (\because \text{複素数の絶対値の平方})\\
&\ge x^2
&& (\because y^2\ge0)\\
&=|x|^2
&& (\because \text{実数の絶対値の定義})
\end{aligned}`),
      paragraph([
        "最後の等号は実数の絶対値の定義 ",
        math(String.raw`|x|\in\{x,-x\}`),
        " による。",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0 より ",
        math(String.raw`|x|\le|z|`),
        "、同様に ",
        math(String.raw`|y|\le|z|`),
        "。",
        ref("complex_numbers_form_a_field"),
        " より ",
        math(String.raw`\mathbb{C}`),
        " の加法とその逆元は成分ごとである。いま示した評価を ",
        math(String.raw`z=z_N-z_M`),
        " に適用すると",
      ]),
      displayMath(String.raw`\begin{aligned}
z_N-z_M&=(x_N-x_M,\ y_N-y_M)
&& (\because \mathbb C\text{ の減法は成分ごと})\\
|x_N-x_M|&\le|z_N-z_M|
&& (\because \text{直前の第 1 成分の評価})\\
|y_N-y_M|&\le|z_N-z_M|
&& (\because \text{同じ評価の第 2 成分版})
\end{aligned}`),
      paragraph([
        "よって ",
        math(String.raw`\mathbb{C}`),
        " の Cauchy 列 ",
        math(String.raw`(z_N)=((x_N,y_N))`),
        " に対して ",
        math(String.raw`(x_N),(y_N)`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の Cauchy 列であり、",
        math(String.raw`\mathbb{R}`),
        " の完備性より ",
        math(String.raw`x_N\to x`),
        "、",
        math(String.raw`y_N\to y`),
        " なる ",
        math(String.raw`x,y\in\mathbb{R}`),
        " が存在する。このとき ",
        ref("abs_basic_properties"),
        " (2) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|z_N-(x,y)|^2
&=(x_N-x)^2+(y_N-y)^2
&& (\because \text{複素数の絶対値の平方})\\
&\longrightarrow 0
&& (\because x_N\to x\text{ と }y_N\to y)
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`|z_N-(x,y)|\to 0`),
        "（非負実数について ",
        math(String.raw`u_N^2\to 0\Rightarrow u_N\to 0`),
        "。実際 ",
        math(String.raw`\varepsilon>0`),
        " に対し ",
        math(String.raw`u_N^2<\varepsilon^2`),
        " なる ",
        math(String.raw`N`),
        " 以降で ",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0 より ",
        math(String.raw`u_N<\varepsilon`),
        "）。",
      ]),
      paragraph([
        "Step 3: (1) の証明。",
        math(String.raw`(A_N)`),
        " を Cauchy 列とすると、Step 1 より各成分について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|(A_N)_{ij}-(A_M)_{ij}\right|
&=\left|(A_N-A_M)_{ij}\right|
&&(\because\ \text{行列の差は成分ごとである})\\
&\le\|A_N-A_M\|
&&(\because\ \text{Step 1})
\end{aligned}`,
      ),
      paragraph([
        "であるから、",
        math(String.raw`((A_N)_{ij})_N`),
        " は ",
        math(String.raw`K`),
        " の Cauchy 列である。Step 2 よりその極限 ",
        math(String.raw`a_{ij}\in K`),
        " が存在する。",
        math(String.raw`A:=(a_{ij})\in\mathrm{Mat}(n,K)`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|A_N-A\|^2
&=\sum_{i=1}^{n}\sum_{j=1}^{n}\left|(A_N)_{ij}-a_{ij}\right|^2
&& (\because \text{行列ノルムの定義})\\
&\longrightarrow 0
&& (\because \text{有限個の }0\text{ に収束する実数列の和})
\end{aligned}`,
      ),
      paragraph([
        "であり、Step 2 末尾と同じ理由で ",
        math(String.raw`\|A_N-A\|\to 0`),
        "、すなわち ",
        math(String.raw`A_N\to A`),
        "。",
      ]),
      paragraph([
        "Step 4: (2) の証明。",
        math(String.raw`S_N:=\sum_{m=0}^{N}B_m`),
        "、",
        math(String.raw`T_N:=\sum_{m=0}^{N}\|B_m\|`),
        " とおく。仮定より ",
        math(String.raw`(T_N)`),
        " は収束するので Cauchy 列である。",
        math(String.raw`N>M`),
        " のとき ",
        ref("matrix_norm_triangle_inequality"),
        " (3) を繰り返し用いて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|S_N-S_M\|
&=\left\|\sum_{m=M+1}^{N}B_m\right\|
&&(\because\ S_N\ \text{と}\ S_M\ \text{の定義と、有限和の差})\\
&\le\sum_{m=M+1}^{N}\|B_m\|
&&(\because\ \text{行列ノルムの三角不等式を繰り返し用いる})\\
&=T_N-T_M
&&(\because\ T_N\ \text{と}\ T_M\ \text{の定義と、有限和の差})
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`(S_N)`),
        " は Cauchy 列であり、(1) より ",
        math(String.raw`S:=\lim_{N\to\infty}S_N`),
        " が存在する。すなわち ",
        math(String.raw`\sum_{m=0}^{\infty}B_m=S`),
        "。",
      ]),
      paragraph([
        "Step 5: ノルムの評価。",
        ref("matrix_norm_triangle_inequality"),
        " (3) より",
      ]),
      displayMath(String.raw`\begin{aligned}
\|S_N\|
&\le T_N
&& (\because \text{行列ノルムの三角不等式を有限回適用})\\
&\le T
&& (\because \text{非負項の級数の部分和はその極限以下})
\end{aligned}`),
      paragraph([
        "ここで ", math(String.raw`T:=\sum_{m=0}^{\infty}\|B_m\|`), " である。",
        math(String.raw`(T_N)`),
        " は非負項の級数の部分和なので単調非減少であり ",
        math(String.raw`T_N\le T`),
        "。また ",
        ref("matrix_norm_triangle_inequality"),
        " (3) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|S\|
&\le\|S-S_N\|+\|S_N\|
&&(\because\ S=(S-S_N)+S_N\ \text{と行列ノルムの三角不等式})\\
&\le\|S-S_N\|+T
&&(\because\ \|S_N\|\le T)
\end{aligned}`,
      ),
      paragraph([
        "であり、右辺第 1 項は ",
        math(String.raw`N\to\infty`),
        " で ",
        math(String.raw`0`),
        " に収束する。",
        math(String.raw`\|S\|`),
        " は ",
        math(String.raw`N`),
        " によらない定数であるから ",
        math(String.raw`\|S\|\le T`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。exp 級数の収束（labels: exp_converges）と" +
          "可換行列の exp 積公式（labels: theorem_exp_product）が前提とする" +
          "「Mat(n,K) が完備であること」「絶対収束すれば収束すること」を明示するために追加した。",
        "式変形の書き方の統一（2026-08-10）。3 箇所の式が 1 行に 2 つ以上の関係を並べ、" +
          "根拠を 1 つも書いていなかった（Step 3 の成分の評価、Step 4 の部分和の差の評価、" +
          "Step 5 のノルムの評価）。どの関係がどの根拠によるのかが式から読み取れないので、" +
          "それぞれ 1 行 1 関係の鎖へ分け、各行の末尾に (∵ …) を置いた。" +
        "段は増えており、減った段は無い。主張も証明の筋も変えていない。",
        "2026-08-31: 完備性と絶対収束判定の証明に残っていた一行複数関係を開いた。" +
          "成分平方の評価、複素数の成分評価、複素差の二成分評価、極限二箇所、部分和ノルムの二段を、" +
          "一行一関係と行末根拠へ直した。既存の参照・段・主張・証明の筋は変えていない。",
      ],
    },
  },
  {
    id: "linear_space_general_003b_claim_matrix_multiplication_continuity",
    kind: "claim",
    origin: { path: "_old/typst/parts/002_線型空間の一般論/002_claim_行列ノルムの劣乗法性.typ", ordinal: 3 },
    title: { text: "行列乗算の連続性" },
    labels: ["matrix_multiplication_continuity"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`A_N, A, B \in \mathrm{Mat}(n, K)`),
        "、",
        math(String.raw`\|A_N - A\| \to 0`),
        " のとき、",
      ]),
      displayMath(String.raw`\|A_N B - AB\| \to 0`),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\|A_N B - AB\|
&= \|(A_N - A)B\|
&&(\because\ \text{行列の積の右分配則})\\
&\leq \|A_N - A\| \cdot \|B\|
&&(\because\ \text{行列ノルムの劣乗法性。}\blkref{matrix_norm_submultiplicativity})\\
&\to 0
&&(\because\ \|A_N - A\| \to 0\ \text{と、収束する実数列に定数を掛けた列の極限})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形の書き方の統一（2026-08-10）。3 段の鎖はもとから 1 行 1 関係になっていたが、" +
          "どの関係がどの根拠によるのかが式の上に無く、引いたブロックの参照が式の後ろに" +
          "1 つだけ置かれていた。各行の末尾に (∵ …) を置いた（右分配則・劣乗法性・" +
          "収束する実数列に定数を掛けた列の極限が別々の根拠であることが、これで式の上に現れる）。" +
          "段は増えておらず減ってもおらず、主張も証明の筋も変えていない。",
        "2026-09-03 の式変形統一で、証明末尾の参照一覧を削除し、行列ノルムの劣乗法性を" +
          "使う不等式行の行末へラベル参照を移した。内容・式変形・根拠は変えていない。",
      ],
    },
  },
]);
