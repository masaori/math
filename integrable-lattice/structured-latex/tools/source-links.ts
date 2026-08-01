/**
 * **本文ブロック ↔ 根拠 report の対応台帳。**
 *
 * なぜこれが要るか: 「根拠 report は正しいのに、本文へ移す段で落ちる」型の事故が 3 回起きている。
 *   - cycle 18: 命題 N の例外集合。report は「算術級数の有限和」＝一般に無限と書いていたのに、
 *     本文は「有限個の $N$」になっていた。
 *   - cycle 20: 桁定理（命題 J (J1)）が使う $A_1\equiv0$ を本文が書いていなかった。
 *     $m=\ell^L$ ちょうどの段はこれなしでは偽である。
 *   - cycle 21: 命題 R (R1) の係数が $\mu_{c+\ell\gamma}$ ではなく添字なしの $\mu$ になっていた。
 *
 * **3 件とも「対応は付いていた」。** 対応表があることを見る検査では 1 件も防げない。
 * だからこの台帳は「対応がある」ことではなく、**report の該当範囲に出てくる記号と語が
 * 本文にも出てくること**を検査させるために書く（`verify-transcription.ts`）。
 *
 * 書き方:
 *   - `passages` は report の**範囲**を行の目印で指す。目印が消えていれば検査は例外で落ちる
 *     （台帳が腐ったまま緑になるのを防ぐ）。
 *   - `acknowledged` は**項目 1 つだけ**を免除する。ブロックを丸ごと免除する形は作らない
 *     （ブロック単位の免除は cycle 21 で実際に検査の穴になった。`ja-en-exceptions.ts` の注記も参照）。
 *   - 免除の理由に「本文には要らないから」と書くのは理由ではない。
 *     **なぜ本文の主張が、その記号・語を落としても成り立つのか**を書く。
 *   - **免除には `grounds`（機械検証できる根拠）が要る**（cycle 24 step 3。型で必須にしてある）。
 *     自然文の `reason` は人が読むためのもので、**根拠 report が書き換わっても本文が書き換わっても
 *     黙って生き残る**。`grounds` は「report のこの文」「本文のこの記述」「分担先のこのブロック」を
 *     指し、それが動いたら検査 A′ が赤にする。型の一覧と、型ごとに何を検証できて何ができないかは
 *     `transcription-model.ts` の `ExemptionGrounds` を見よ。
 *     **`positioning`（report の位置づけの言葉）だけは「主張ではない」ことを機械検証できない。**
 *     その件数は毎回出力される。
 */

import type { SourceLink } from "./transcription-model.ts";

export const SOURCE_LINKS: readonly SourceLink[] = [
  {
    block: "paper_044_theorem_newton",
    passages: [
      {
        report: "outputs/reports/cycle3_T1_D-U2_rigorous.md",
        from: "Skolem–Mahler–Lech 例外",
        to: "Skolem–Mahler–Lech 例外",
        covers: "命題 N の証明の但し書き（例外集合の形）",
      },
    ],
    acknowledged: [
      {
        item: "スパイク",
        reason:
          "report のこの文は「$Z_N$ が高位で消える例外があるので成長率 $r_p$ がスパイクしうる」と、例外の**現れ方**を $r_p$ の側から描写している。本文は同じ事実を例外集合の側から「例外集合は算術級数の有限和であり一般に無限集合である」と述べ、さらに $T=(0\,1;2\,0)$, $p=2$ ですべての奇数 $N$ で $Z_N=0$ という反例を具体的に置いている。落ちているのは描写の言葉であって例外の存在・形・無限性のいずれでもない。",
        grounds: {
          type: "paraphrase",
          reportQuote: "が高位で消える **Skolem–Mahler–Lech 例外**（算術級数の有限和）でスパイクしうる",
          bodyQuote: "例外集合は算術級数の有限和であり、**一般に無限集合である**",
        },
      },
      {
        item: "高位",
        reason:
          "同上。「高位の桁で消える」は $Z_N$ の $p$ 進付値が跳ぶ仕組みの説明であり、本文が持つ反例（奇数 $N$ で $Z_N=0$、$N=2k$ で $Z_N=2^{k+1}$）がその仕組みを具体的に示している。",
        grounds: {
          type: "example",
          reportQuote: "ただし $S(N)$ が高位で消える",
          bodyQuote: "**すべての奇数",
        },
      },
    ],
  },
  {
    block: "paper_091_theorem_theta_padic",
    passages: [
      {
        report: "outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md",
        from: "**証明.** $(a,b)\\mapsto(a+\\ell^Lu",
        to: "から従う）。$\\blacksquare$",
        covers: "命題 J (J1)（桁定理）の証明。$m=\\ell^L$ ちょうどの段が使う仮定を含む",
      },
    ],
    acknowledged: [],
  },
  {
    block: "paper_101_theorem_digit_branch",
    passages: [
      {
        report: "outputs/reports/cycle20_T3_cancellation_recursion.md",
        from: "> **補題 L0.**",
        to: "> 4. *$\\theta(\\nu)\\le\\ell^{\\mathrm{sep}(\\nu)}-1$。*",
        covers: "命題 R (R1)(R2)（桁枝分解と桁枝再帰）",
      },
    ],
    acknowledged: [
      {
        item: "\\nu_{c}",
        reason:
          "report は測度 $\nu$ とその桁成分 $\nu_c$ の言葉で書き、本文は同じ再帰を母関数 $g_c$ の言葉で書いている（report 自身が $f_{\nu_c}$ と $g_c$ を同一視している: 補題 L0）。落ちているのは記法の選択であって、$\theta(\nu_c)<\infty$ に対応する「各枝の $\mathrm{ord}\,g_c$ が有限」は本文 (R2) にある。",
        grounds: {
          type: "notation",
          reportQuote: "*$\\theta(\\nu_c)<\\infty$（$c\\in I$）であり",
          bodyQuote: "\\mathrm{ord}_y\\,g_c",
        },
      },
    ],
  },
  {
    block: "paper_101_theorem_s_infinity_decision",
    passages: [
      {
        report: "outputs/reports/cycle20_T3_s_infinity_decision.md",
        from: "## 4. 定理 W4 — $j^*$ は二項式因子の重複度である",
        to: "## 6. 検証（何をどう測ったか）",
        covers: "命題 K (K4)（$j^*=m_u$）・(K5)（仮定 (N) の解消）・(K6)（$b$ の式）・(K7)（上界）",
        quotedOnly: true,
      },
    ],
    acknowledged: [
      {
        item: "P_{1}",
        reason:
          "report は $S_\infty=\{P_1,\dots,P_r\}$ と番号を振り、本文は $r_0$ の式を「相異なる $P,P'$」の$\max$ として書いている。同じ有限集合の上の同じ最大値であり、番号付けは記法の選択である。",
        grounds: {
          type: "notation",
          reportQuote: "$S_\\infty=\\{P_1,\\dots,P_r\\}$（$P_i=\\iota([u_i])$）に対して",
          bodyQuote: "\\max_{P\\neq P'}v_\\ell\\bigl(\\det(u,u')\\bigr)",
        },
      },
      {
        item: "P_{i}",
        reason:
          "同上（$P_i$ は $S_\infty$ の点の番号付け。本文の $\max_{P}$ が同じ範囲を走る）。",
        grounds: {
          type: "notation",
          reportQuote: "$S_\\infty=\\{P_1,\\dots,P_r\\}$（$P_i=\\iota([u_i])$）に対して",
          bodyQuote: "\\max_{P\\neq P'}v_\\ell\\bigl(\\det(u,u')\\bigr)",
        },
      },
      {
        item: "P_{r}",
        reason:
          "同上。",
        grounds: {
          type: "notation",
          reportQuote: "$S_\\infty=\\{P_1,\\dots,P_r\\}$（$P_i=\\iota([u_i])$）に対して",
          bodyQuote: "\\max_{P\\neq P'}v_\\ell\\bigl(\\det(u,u')\\bigr)",
        },
      },
      {
        item: "u_{i}",
        reason:
          "同上（$u_i=\iota^{-1}(P_i)$ の番号付け。本文は $\det(u,u')$ と書いている）。",
        grounds: {
          type: "notation",
          reportQuote: "$P_i=\\iota([u_i])$）に対して",
          bodyQuote: "\\det(u,u')",
        },
      },
      {
        item: "u_{j}",
        reason:
          "同上。",
        grounds: {
          type: "notation",
          reportQuote: "\\max_{i\\neq j}v_\\ell\\bigl(\\det(u_i,u_j)\\bigr)",
          bodyQuote: "\\det(u,u')",
        },
      },
      {
        item: "e_{m}",
        reason:
          "report の $e_m$ は本文の $e_{m_u}$ と同じ量である（report も同じ節で $m=m_P$ と置いている）。本文は基点 $P$ に対応する $u$ を明示する記法を採っている。",
        grounds: {
          type: "notation",
          reportQuote: "\\max_i\\bigl\\lfloor\\log_\\ell e_{m}(P_i)\\bigr\\rfloor",
          bodyQuote: "e_{m_u}",
        },
      },
      {
        item: "\\kappa_{n}",
        reason:
          "系 W6 が係数を取り出している展開 $\mathrm{ord}_\ell(\kappa_n)$ は本文では 命題 J (J4) が持つ。命題 K (K6) はその展開の $n\ell^n$ 係数 $b$ だけを述べる分担であり、本文は (K6) の冒頭で 命題 J を参照している。",
        grounds: {
          type: "division",
          reportQuote: "$\\mathrm{ord}_\\ell(\\kappa_n)$ の $n\\ell^n$ 項の係数は",
          holder: "paper_091_theorem_theta_padic",
          holderItem: "\\mathrm{ord}_\\ell(\\kappa_n)",
        },
      },
      {
        item: "\\psi_{u}",
        reason:
          "**本文はこれを持たない。** report は $e_{m_u}=\mathrm{ord}_{x=0}\bar\psi_u(G)$ という $e_{m_u}$ の明示式を与えるが、本文 (K4) の主張は $j^*(P)=m_u$ であって $e_{m_u}$ の値は使わない。(K5) は $e_{m_u}$ を $r_0$ の式に含むが、そこで要るのは $e_{m_u}<\infty$（(K4) が述べている）だけである。したがって主張は成り立つ。ただし $e_{m_u}$ を実際に計算する式が本文に無いことは事実なので、本文側の判断（書き足すか、report 参照に留めるか）は本文を担当する step へ回す。",
        grounds: {
          type: "weaker",
          reportQuote: "さらに $e_{m_u}=\\mathrm{ord}_{x=0}\\bar\\psi_u(G)$",
          bodyQuote: "j^*(P)=m_u",
        },
      },
      {
        item: "グラフ",
        reason:
          "report の「$\ell$、グラフ、voltage のどれにも依らない一様な式で書ける」という強い言い方を、本文は「$D$ の係数からの $\mathbb{F}_\ell$ 上の有限計算だけで決まる」に留めている。**弱い方の主張だけを書いている**ので、落としても本文の主張は成り立つ（強い方を主張していない）。",
        grounds: {
          type: "weaker",
          reportQuote: "どれにも依らない一様な式で書ける",
          bodyQuote: "上の有限計算だけで決まる",
        },
      },
      {
        item: "一様",
        reason:
          "同上。",
        grounds: {
          type: "weaker",
          reportQuote: "どれにも依らない一様な式で書ける",
          bodyQuote: "上の有限計算だけで決まる",
        },
      },
    ],
  },
  {
    block: "paper_056_theorem_ell2_family",
    passages: [
      {
        report: "outputs/reports/cycle20_T3_ell_equals_2.md",
        from: "### 5.2 定理 Y′",
        to: "## 6. 何が $\\ell=2$ で本当に違うのか",
        covers: "命題 G″ (G″4)（4 通りの閉形式）・(G″5)（命題 G′ が $\\ell=2$ で正しい範囲）",
        quotedOnly: true,
      },
    ],
    acknowledged: [],
  },
  {
    block: "paper_055_theorem_theta_infinity",
    passages: [
      {
        report: "outputs/reports/cycle19_T3_theta_infinity.md",
        from: "### 5.3 定理 X′（この族の閉形式）",
        to: "### 5.4 系 X″（型 III は「小さい $\\ell$ の現象」ではない）",
        covers: "命題 G′ の閉形式（$\\ell$ 奇の bouquet 族）",
        quotedOnly: true,
      },
    ],
    acknowledged: [
      {
        item: "主結果",
        reason:
          "「本サイクルの主結果」は report が自分の成果を位置づける言葉であって、定理の内容ではない。",
        grounds: {
          type: "positioning",
          reportQuote: "**定理 X′（本サイクルの主結果）.**",
        },
      },
      {
        item: "本サイクル",
        reason:
          "同上。",
        grounds: {
          type: "positioning",
          reportQuote: "**定理 X′（本サイクルの主結果）.**",
        },
      },
      {
        item: "存在",
        reason:
          "report の「例外直線が存在する（$\ell\mid p'q'(p'+q')$）」という仮定を、本文は「例外直線があるとき」と書いている。条件式 $\ell\mid p'q'(p'+q')$ そのものは本文にある。",
        grounds: {
          type: "paraphrase",
          reportQuote: "上の族で例外直線が存在する",
          bodyQuote: "例外直線があるとき",
        },
      },
      {
        item: "予言",
        reason:
          "report のこの文は数値検証の枠組み（H4 が 3 分解を数値で出す）についての注であり、定理の主張ではない。本文は同じ数値検証を `verification` のラベルで指している。",
        grounds: {
          type: "positioning",
          reportQuote: "予言に使うのは $\\mu$ と $\\Lambda$ だけ",
        },
      },
      {
        item: "数値",
        reason:
          "同上。",
        grounds: {
          type: "positioning",
          reportQuote: "H4 は上の 3 分解を数値で出している",
        },
      },
    ],
  },
  {
    block: "paper_046_theorem_wstar_different",
    passages: [
      {
        report: "outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md",
        from: "## 4.1 主定理",
        to: "### 4.2 分岐データによる表示",
        covers: "命題 W\\*（$w^*$ の代数的閉形式）",
      },
    ],
    acknowledged: [
      {
        item: "有限アーベル群",
        reason:
          "report は $A/\eta A$ を「有限アーベル群」と呼んでからその不変量を取る。本文は同じ段で$\det G=\pm[A:\eta A]=\pm N(\eta)$ と指数を書いており、指数が有限値として書けることに有限性が現れている。落ちているのは呼び名であって、単因子が $A/\eta A$ の不変量に等しいという主張は本文にある。",
        grounds: {
          type: "paraphrase",
          reportQuote: "ゆえに $G$ の単因子は有限アーベル群 $A/\\eta A$ の不変量に等しい",
          bodyQuote: "\\det G=\\pm N_{A/\\mathbb{Q}}(\\eta)",
        },
      },
    ],
  },
  {
    block: "paper_043b_theorem_trace_bound",
    passages: [
      {
        report: "outputs/reports/cycle18_T3_trace_period_bound.md",
        from: "## 4. 主定理",
        to: "## 5. どんな $p$ 冪補正でも直らないこと",
        covers: "命題 C′（トレース周期の上界と、その最良性）",
        quotedOnly: true,
      },
    ],
    acknowledged: [
      {
        item: "\\Delta",
        reason:
          "report のこの注は「$\det G$ による Cramer 則でも同じ形の上界が出るが、Smith 標準形を使うと$v=v_p(\Delta)$ を最大単因子 $w^*\le v$ に置き換えられる」という**採らなかった経路との比較**である。本文は採った経路（最大単因子 $w^*$）だけを書いており、より弱い $v$ による上界を主張していない。",
        grounds: {
          type: "weaker",
          reportQuote: "による Cramer 則でも $p^{k-v}\\mid b_j$ が出る",
          bodyQuote: "最大単因子（Smith 標準形の最後の対角成分）",
        },
      },
      {
        item: "b_{j}",
        reason:
          "同上（$b_j$ は採らなかった Cramer 則の経路に現れる係数）。",
        grounds: {
          type: "weaker",
          reportQuote: "による Cramer 則でも $p^{k-v}\\mid b_j$ が出る",
          bodyQuote: "最大単因子（Smith 標準形の最後の対角成分）",
        },
      },
      {
        item: "p^{k-v}",
        reason:
          "同上（$v$ による弱い方の整除。本文が主張するのは $w^*$ による強い方である）。",
        grounds: {
          type: "weaker",
          reportQuote: "Smith 標準形を使うと $v$ を最大単因子 $w^*\\le v$ に置き換えられる",
          bodyQuote: "最大単因子（Smith 標準形の最後の対角成分）",
        },
      },
    ],
  },

  // ==========================================================================
  // cycle 23 step 2 で追加した分（台帳被覆を上げる）。
  //
  // 追加の方針: **根拠が一次情報として実在するブロックだけを載せる。**
  // 「対応が付かない」ことは正当な結論だが、確かめずにそう書かない。
  // 対応づけられなかったブロックとその理由は
  // `outputs/reports/cycle23_ops_ledger_coverage.md` §3 に列挙してある。
  //
  // `report` フィールドは `integrable-lattice/` からの相対パスであり、
  // `outputs/reports/` に限らない。数値の根拠が `sagemath/check/*/README.md` に
  // あるもの（命題 C の Wall 型反例など）はそちらを指す。**「その主張をどこで
  // 確かめたか」を指すのが台帳の役目**であって、置き場所は問わない。
  // ==========================================================================

  {
    block: "paper_012_definition_ladder",
    passages: [
      {
        report: "inputs/seeds/lambda-statement-program.md",
        from: "## 決定可能性の梯子（収集の座標系）",
        to: "## 量の帰属台帳",
        covers: "決定可能性の梯子（$\\Lambda$ の等号＝素因数分解一致・順序＝整数比較、$\\overline{\\mathbb{Q}}$ は根分離、Schanuel 層は回避、$\\mathbb{R}/\\mathbb{C}$ は決定不能）",
      },
    ],
    acknowledged: [
      {
        item: "\\ell_{q}",
        reason:
          "seed は Schanuel 層を $\\ell_p\\ell_q$ の積という代表例で書く。本文は同じ層を梯子の中で「$\\overline{\\mathbb{Q}}(\\ell_p)$ の非線形部（Schanuel 条件付き）」と書いており、$\\ell_p\\ell_q$ はその非線形部の一例である。層の位置と回避方針は落ちていない。",
        grounds: {
          type: "notation",
          reportQuote: "exp/log の体（$\\ell_p\\ell_q$ の積）: Schanuel 条件付き",
          bodyQuote: "\\overline{\\mathbb{Q}}(\\ell_p)\\ \\text{の非線形部}",
        },
      },
      {
        item: "無条件決定可能",
        reason:
          "語の切り出しの差。本文は梯子の下線ラベルで「無条件に決定可能」と書き、さらに「$\\Lambda$ での等号は素因数分解の一致、順序は指数ベクトルの整数比較であり、どちらも有限手続きで決定できる」と中身まで書いている。",
        grounds: {
          type: "paraphrase",
          reportQuote: "無条件決定可能。",
          bodyQuote: "\\text{無条件に決定可能}",
        },
      },
    ],
  },
  {
    block: "paper_013_remark_four_axes",
    passages: [
      {
        report: "inputs/seeds/lambda-statement-program.md",
        from: "## 四軸（07 由来。statement を分類・選別する軸）",
        to: "$\\Lambda$ は 1 を（有限・離散のとき）保証するだけ。",
        covers: "四軸（帰属・計算可能性・複雑性・可解性）と、$\\Lambda$ が軸 1 しか保証しないこと",
      },
    ],
    acknowledged: [
      {
        item: "\\Lambda",
        reason:
          "seed は軸 1 の説明で帰属先を $\\Omega\\in\\mathbb{N},S\\in\\Lambda,Z\\in\\mathbb{Z}[x],$ 零点 $\\in\\overline{\\mathbb{Q}}$ と列挙する。本文のこのブロックは軸の**定義**だけを担い、帰属先の具体列は決定可能性の梯子のブロックと Massieu 自由エントロピーの定義ブロックが持つ分担である。",
        grounds: {
          type: "division",
          reportQuote: "**帰属/存在**: 有限・離散なら",
          holder: "paper_012_definition_ladder",
          holderItem: "\\Lambda=\\bigoplus_{p}\\mathbb{Z}\\,\\ell_p",
        },
      },
      {
        item: "\\Omega",
        reason:
          "同上。",
        grounds: {
          type: "division",
          reportQuote: "**帰属/存在**: 有限・離散なら",
          holder: "paper_023_definition_massieu",
          holderItem: "\\Omega_N(m)\\in\\mathbb{N}",
        },
      },
      {
        item: "\\overline",
        reason:
          "同上。",
        grounds: {
          type: "division",
          reportQuote: "**帰属/存在**: 有限・離散なら",
          holder: "paper_012_definition_ladder",
          holderItem: "\\overline{\\mathbb{Q}}",
        },
      },
      {
        item: "零点",
        reason:
          "同上。",
        grounds: {
          type: "division",
          reportQuote: "**帰属/存在**: 有限・離散なら",
          holder: "paper_023_definition_massieu",
          holderItem: "固有値と分配関数零点",
        },
      },
      {
        item: "存在",
        reason:
          "同上（seed の軸 1 の呼び名は「帰属/存在」。本文は「帰属」だけを採っている）。",
        grounds: {
          type: "notation",
          reportQuote: "**帰属/存在**: 有限・離散なら",
          bodyQuote: "**軸 1（帰属）**",
        },
      },
      {
        item: "連続スピン",
        reason:
          "seed は軸 1 の適用外（連続スピン・無限サイズは最初から $\\mathbb{R}$ で不可）まで書く。本論文は有限・離散な模型だけを対象とすると設定で宣言しており、**狭い方の場合しか主張していない**。",
        grounds: {
          type: "weaker",
          reportQuote: "連続スピン/無限サイズだと最初から",
          bodyQuote: "有限・離散なら可算側に住む",
        },
      },
      {
        item: "無限サイズ",
        reason:
          "同上。",
        grounds: {
          type: "weaker",
          reportQuote: "連続スピン/無限サイズだと最初から",
          bodyQuote: "有限・離散なら可算側に住む",
        },
      },
      {
        item: "不可",
        reason:
          "同上。",
        grounds: {
          type: "weaker",
          reportQuote: "連続スピン/無限サイズだと最初から",
          bodyQuote: "有限・離散なら可算側に住む",
        },
      },
      {
        item: "平面",
        reason:
          "seed は軸 3 に例（平面 Ising=Pfaffian / 3D・スピングラス）を添える。本文は軸そのもの（有限サイズで多項式時間か #P 困難か）だけを述べ、例を挙げない。例が無くても軸の定義は成り立つ。",
        grounds: {
          type: "example",
          reportQuote: "**複雑性**: 有限 $N$ で多項式（平面 Ising=Pfaffian）か #P 困難",
          bodyQuote: "有限サイズで多項式時間か #P 困難か",
        },
      },
      {
        item: "スピングラス",
        reason:
          "同上。",
        grounds: {
          type: "example",
          reportQuote: "**複雑性**: 有限 $N$ で多項式（平面 Ising=Pfaffian）か #P 困難",
          bodyQuote: "有限サイズで多項式時間か #P 困難か",
        },
      },
      {
        item: "有限側",
        reason:
          "seed が軸 3 を「有限側の本体軸」と位置づける言葉。本文は軸 3 と軸 4 が独立であることを述べており、位置づけの言葉は使っていない。",
        grounds: {
          type: "positioning",
          reportQuote: "**有限側の本体軸**。",
        },
      },
      {
        item: "本体軸",
        reason:
          "同上。",
        grounds: {
          type: "positioning",
          reportQuote: "**有限側の本体軸**。",
        },
      },
      {
        item: "保証",
        reason:
          "seed の「$\\Lambda$ は 1 を（有限・離散のとき）保証するだけ。2・3・4 は保証しない」を、本文は「**軸 1・2 は軸 4 を何も含意しない。**」と含意の言葉で書いている。同じ主張の言い換えである。",
        grounds: {
          type: "paraphrase",
          reportQuote: "は 1 を（有限・離散のとき）保証するだけ",
          bodyQuote: "**軸 1・2 は軸 4 を何も含意しない。**",
        },
      },
    ],
  },
  {
    block: "paper_023_definition_massieu",
    passages: [
      {
        report: "inputs/seeds/lambda-statement-program.md",
        from: "## 量の帰属台帳（09 由来。収集する statement が指す対象の住処）",
        to: "## 四軸（07 由来。statement を分類・選別する軸）",
        covers: "各量の住処（$\\Omega_N\\in\\mathbb{N}$、$Z_N\\in\\mathbb{Z}[x]$、$\\Phi_N\\in\\Lambda$、$T(x)\\in M_d(\\mathbb{Z}[x])$、零点 $\\in\\overline{\\mathbb{Q}}$）",
      },
      {
        report: "outputs/reports/cycle3_T1_D-U2_rigorous.md",
        from: "## 設定",
        to: "$\\Phi_N$ の $\\ell_p$ 係数は $v_p(Z_N)\\in\\mathbb{Z}_{\\ge0}$。",
        covers: "$\\Phi_N=\\log Z_N\\in\\Lambda$ と、その $\\ell_p$ 係数が $v_p(Z_N)$ であること",
      },
    ],
    acknowledged: [],
  },
  {
    block: "paper_021_definition_curve",
    passages: [
      {
        report: "outputs/reports/cycle14_T1_vp_growth_two_variable.md",
        from: "## 1. 設定",
        to: "この $L$ の列が $\\mathbb{Z}_p^2$ 塔に対応する。",
        covers: "周期点数 $a_L$ の定義（単項式倍で不変・Galois 不変で $\\mathbb{Z}$ に属する）",
      },
    ],
    acknowledged: [
      {
        item: "有限計算",
        reason:
          "report の §1 は $(1.1)$ の終結式表示が「整数係数の有限計算」であることまで述べる。本文のこのブロックは $a_L$ の**定義**（単項式倍で不変・Galois 不変で $\\mathbb{Z}$ に属する）だけを担い、終結式表示とその有限計算性は次のブロック（周期点数は入れ子の終結式で厳密に計算できる）が述べる分担になっている。落ちているのではなく隣のブロックにある。",
        grounds: {
          type: "division",
          reportQuote: "これは**整数係数の有限計算**である",
          holder: "paper_022_claim_resultant",
          holderItem: "整数係数の有限計算",
        },
      },
    ],
  },
  {
    block: "paper_022_claim_resultant",
    passages: [
      {
        report: "outputs/reports/cycle14_T1_vp_growth_two_variable.md",
        from: "$z^L-1$, $w^L-1$ はモニックなので、終結式の標準性質",
        to: "これは**整数係数の有限計算**である",
        covers: "$d=2$ の入れ子終結式表示 $(1.1)$ と、それが整数係数の有限計算であること",
      },
      {
        report: "outputs/reports/cycle14_T1_vp_growth_two_variable.md",
        from: "### 3.4 $d$ 変数への一般化",
        to: "\\tag{3.3}",
        covers: "一般の $d$ でも終結式を $d$ 回入れ子にすればよいこと",
      },
    ],
    acknowledged: [],
  },
  {
    block: "paper_031_theorem_lsw",
    passages: [
      {
        report: "outputs/reports/cycle13_T1_padic_entropy_generality.md",
        from: "## 2. $\\infty$ 素点側で確認できたこと（一般性は確定した）",
        to: "**注意（[B] §1 の訂正記述）**",
        covers:
          "(i) LSW Thm 3.1（仮定なし）・(ii) LSW Thm 7.1（expansive）・(iii)(iv) LSV Thm 1.2 / 1.3・$c_\\Gamma(f)$ のずれ",
      },
    ],
    acknowledged: [
      {
        item: "零点条件",
        reason:
          "report の「$f$ に零点条件は課されていない」は、本文 (i) の「**仮定は無い**」と同じ主張の言い換えである。",
        grounds: {
          type: "paraphrase",
          reportQuote: "**$f$ に零点条件は課されていない。",
          bodyQuote: "**仮定は無い**",
        },
      },
      {
        item: "無条件",
        reason:
          "report のこの文は [B] の $(1.1)$ がイデアル一般（主でない場合・$\\{0\\}$ の場合を含む）で無条件に成り立つことを述べている。本文は主イデアル $\\langle P\\rangle$（$P\\neq0$）だけを扱う**狭い方の主張**しかしていないので、落としても本文の主張は成り立つ。",
        grounds: {
          type: "weaker",
          reportQuote: "$\\mathfrak a=\\langle f\\rangle$（$f\\neq0$）に対して無条件に掲げ",
          bodyQuote: "P\\in\\mathbb{Z}[z_1^{\\pm},\\dots,z_d^{\\pm}]\\setminus\\{0\\}",
        },
      },
      {
        item: "非主イデアル",
        reason:
          "同上（[B] のイデアル一般の場合分け。本文は主イデアルの場合しか主張していない）。",
        grounds: {
          type: "weaker",
          reportQuote: "が非主イデアルなら $h=0$",
          bodyQuote: "P\\in\\mathbb{Z}[z_1^{\\pm},\\dots,z_d^{\\pm}]\\setminus\\{0\\}",
        },
      },
      {
        item: "場合分",
        reason:
          "同上。",
        grounds: {
          type: "weaker",
          reportQuote: "なら $h=\\infty$ と場合分けしている",
          bodyQuote: "P\\in\\mathbb{Z}[z_1^{\\pm},\\dots,z_d^{\\pm}]\\setminus\\{0\\}",
        },
      },
      {
        item: "既約因子",
        reason:
          "report は atoral を「既約因子がすべて atoral」という分解経由の定義でも書いている。本文は同値な特徴づけ $\\dim\\mathsf U(P)\\le d-2$ の側だけを採っており、これが Lind–Schmidt–Verbitskiy Theorem 1.3 の仮定そのものである。",
        grounds: {
          type: "paraphrase",
          reportQuote: "一般の $f$ は既約因子がすべて atoral なとき atoral",
          bodyQuote: "\\dim\\mathsf U(P)\\le d-2",
        },
      },
      {
        item: "\\Gamma^{\\circ}",
        reason:
          "report は $\\mathsf P_\\Gamma=|\\mathrm{Fix}_\\Gamma/\\mathrm{Fix}_\\Gamma^{\\circ}|$ という定義まで書き下している。本文の注意が使うのは**結論**（$\\mathsf P_\\Gamma$ は周期成分の個数であり、$a^{\\mathrm{red}}_L$ とは因子 $c_\\Gamma(f)$ だけずれる）だけで、その $c_\\Gamma(f)$ と $\\frac{1}{|\\mathbb{Z}^d/\\Gamma|}\\log c_\\Gamma(f)\\to0$ は本文にある。",
        grounds: {
          type: "weaker",
          reportQuote: "$\\mathrm{Fix}_\\Gamma/\\mathrm{Fix}_\\Gamma^{\\circ}$ の位数（**周期成分**の個数）であり",
          bodyQuote: "c_\\Gamma(f)",
        },
      },
      {
        item: "位数",
        reason:
          "同上（商群の位数という言い方。本文は「周期成分の個数」と書いている）。",
        grounds: {
          type: "paraphrase",
          reportQuote: "$\\mathrm{Fix}_\\Gamma/\\mathrm{Fix}_\\Gamma^{\\circ}$ の位数（**周期成分**の個数）であり",
          bodyQuote: "周期成分の個数",
        },
      },
      {
        item: "訂正記述",
        reason:
          "「[B] §1 の訂正記述」は report が原論文の記述の経緯（先行論文の等式が誤りで $c_\\Gamma(f)$ で割る必要がある）を位置づける言葉である。本文は同じ事実を「同論文はこのずれを明記したうえで」と述べており、ずれの存在と因子は落ちていない。",
        grounds: {
          type: "positioning",
          reportQuote: "**注意（[B] §1 の訂正記述）**",
        },
      },
    ],
  },
  {
    block: "paper_032_remark_ising_known",
    passages: [
      {
        report: "outputs/reports/paper001_en_citation_review.md",
        from: "| 5 | `paper_032_remark_ising_known`",
        to: "| 5 | `paper_032_remark_ising_known`",
        covers: "Viswanathan（特殊温度で Hasse–Weil $L$、臨界点で Dirichlet $L$）の引用内容の一次照合",
      },
    ],
    acknowledged: [
      {
        item: "一致",
        reason:
          "引用検証の**判定語**であって、引用の内容ではない。",
        grounds: {
          type: "positioning",
          reportQuote: "arXiv abstract（本レビューで再取得）が逐語でそう述べている",
        },
      },
      {
        item: "再取得",
        reason:
          "同上（レビュー時に arXiv abstract を取り直した作業の記録）。",
        grounds: {
          type: "positioning",
          reportQuote: "arXiv abstract（本レビューで再取得）が逐語でそう述べている",
        },
      },
      {
        item: "本レビュー",
        reason:
          "同上。",
        grounds: {
          type: "positioning",
          reportQuote: "arXiv abstract（本レビューで再取得）が逐語でそう述べている",
        },
      },
      {
        item: "逐語",
        reason:
          "同上（abstract が逐語でそう述べているという照合の記録）。",
        grounds: {
          type: "positioning",
          reportQuote: "arXiv abstract（本レビューで再取得）が逐語でそう述べている",
        },
      },
      {
        item: "本文未読",
        reason:
          "**これは本文の不備である。** 引用検証の F-6 は「Viswanathan は本文未読であることを明示せよ」と指摘しており、日本語正本のこのブロックにもその明示が無い。本 step は本文を触れないので、`outputs/reports/cycle23_ops_ledger_coverage.md` §4 へ本文へ回す項目として記録したうえで、ここに残す。**理由は「本文に要らないから」ではなく「本文が直すべきものとして記録済みだから」である。**",
        grounds: {
          type: "bodyDefect",
          reportQuote: "ただし本文未読の印が無い → F-6",
          recordedIn: {
            report: "outputs/reports/cycle23_ops_ledger_coverage.md",
            marker: "### 4.1 【要修正・本文へ回す】統計力学側の既知結果のブロックが「本文未読」を明示していない",
          },
        },
      },
    ],
  },
  {
    block: "paper_041_theorem_periodicity",
    passages: [
      {
        report: "outputs/reports/cycle3_T1_D-U2_rigorous.md",
        from: "## 命題 A（決定可能・rigorous な核。証明済み）",
        to: "証明: (1) 有限モノイドの元の冪は",
        covers: "命題 A（切断付値 $\\min(v_p(Z_N),k)$ の最終周期性と、その周期が $\\pi(p,k)$ を割ること）",
      },
    ],
    acknowledged: [
      {
        item: "N_{0}",
        reason:
          "report の (4) は前周期 $N_0(p,k)$ の決定可能性も述べる。本文は最終周期 $\\pi(p,k)$ の側だけを主張しており、**弱い方の主張しかしていない**ので落としても成り立つ（「最終周期的」の定義に前周期の存在は含まれている）。",
        grounds: {
          type: "weaker",
          reportQuote: "$N_0(p,k),\\pi(p,k)$ および各周期内の値は",
          bodyQuote: "**最終周期的**",
        },
      },
      {
        item: "前周期",
        reason:
          "同上（証明中の「前周期＋周期に入る」という鳩の巣の言い回し）。",
        grounds: {
          type: "weaker",
          reportQuote: "有限モノイドの元の冪は前周期＋周期に入る",
          bodyQuote: "**最終周期的**",
        },
      },
      {
        item: "各周期内",
        reason:
          "同上（report は周期内の値表まで決定可能と述べる。本文は周期そのものの決定可能性だけを述べる）。",
        grounds: {
          type: "weaker",
          reportQuote: "および各周期内の値は、$T$ から",
          bodyQuote: "**最終周期的**",
        },
      },
      {
        item: "有限手順",
        reason:
          "report の「有限手順で決定可能」を、本文は「有限モノイド $M_d(\\mathbb{Z}/p^k)$ の上で決定可能である（元を順に生成して最初の再訪を見つければよい）」と手続きの中身まで書いている。落ちているのは語であって内容ではない。",
        grounds: {
          type: "paraphrase",
          reportQuote: "上で**有限手順で決定可能**",
          bodyQuote: "元を順に生成して最初の再訪を見つければよい",
        },
      },
      {
        item: "有限計算",
        reason:
          "同上（証明の (4)「有限計算」）。",
        grounds: {
          type: "paraphrase",
          reportQuote: "(4) 有限計算。",
          bodyQuote: "元を順に生成して最初の再訪を見つければよい",
        },
      },
      {
        item: "不使用",
        reason:
          "「$\\mathbb{R}$ 不使用」は本ブロックの habitat フィールド（$\\mathbb{Z}$）と、決定可能性の梯子のブロックの「本論文が $\\mathbb{R}$ を使うのは第 3 章の一点に限られる」が全体方針として担う。",
        grounds: {
          type: "division",
          reportQuote: "（$\\mathbb{R}$ 不使用）",
          holder: "paper_012_definition_ladder",
          holderItem: "を使うのは第 3 章の一点に限られる",
        },
      },
    ],
  },
  {
    block: "paper_042_theorem_pi_p1",
    passages: [
      {
        report: "outputs/reports/cycle17_ops_lean_propB.md",
        from: "## 2. 反例（Lean で形式化）",
        to: "不一致は例外的現象ではない。",
        covers: "命題 B の訂正（$\\pi$ と $\\pi_{\\mathrm{tr}}$ は別物）と $4\\times4$ の反例、22.6% の不一致率",
      },
      {
        report: "outputs/reports/cycle17_ops_lean_propB.md",
        from: "- 命題 B: $\\pi_{\\mathrm{tr}}(p,1)=\\operatorname{lcm}",
        to: "- 命題 B: $\\pi_{\\mathrm{tr}}(p,1)=\\operatorname{lcm}",
        covers: "訂正後の等式そのもの（トレース列の読み）",
      },
    ],
    acknowledged: [
      {
        item: "M_{4}",
        reason:
          "report は反例を $\\in M_4(\\mathbb{Z})$ と書き、本文は同じ行列を $2\\times2$ 行列の $\\oplus2$ として書いている。次数 4 は直和の書き方から一意に読める。",
        grounds: {
          type: "notation",
          reportQuote: "\\in M_4(\\mathbb{Z}),\\qquad p=2",
          bodyQuote: "T=\\begin{pmatrix}0&1\\\\1&1\\end{pmatrix}^{\\oplus2}",
        },
      },
      {
        item: "不一致",
        reason:
          "report の「不一致は例外的現象ではない」は評価の言葉である。本文は同じ事実を数値そのもの（無作為標本 2487 例中 563 例＝22.6% で 2 つの周期は食い違う）で述べている。",
        grounds: {
          type: "paraphrase",
          reportQuote: "不一致は例外的現象ではない。",
          bodyQuote: "無作為標本 2487 例中 563 例",
        },
      },
      {
        item: "例外的現象",
        reason:
          "同上。",
        grounds: {
          type: "paraphrase",
          reportQuote: "不一致は例外的現象ではない。",
          bodyQuote: "無作為標本 2487 例中 563 例",
        },
      },
    ],
  },
  {
    block: "paper_043_theorem_bound",
    passages: [
      {
        report: "outputs/reports/cycle18_T3_trace_period_bound.md",
        from: "**命題 5（行列冪列版 Wall 型上界。既知）.**",
        to: "よって $X^p\\equiv I\\ (p^{j+1})$",
        covers: "命題 C の上界 $\\pi(p,k)\\mid p^{k-1}\\pi(p,1)$ とその証明（行列冪列の読み）",
      },
      {
        report: "outputs/reports/cycle17_ops_lean_propB.md",
        from: "## 4. 副産物: 命題 C はトレース列の読みでは偽",
        to: "その読みでは正しい。",
        covers: "トレース列の読みでは上界が偽であること（1669 例中 56 例）",
      },
      {
        report: "sagemath/check/cycle3_T3_period/wall_large_scale_README.md",
        from: "| **a,b,c∈1..7** |",
        to: "一般(非退化 companion d=2)の基準率",
        covers: "Wall 型等号が一般には成立しないこと（472 例中 10 例・572 例中 26 例）と、0 件を根拠にしない教訓",
      },
    ],
    acknowledged: [
      {
        item: "副産物",
        reason:
          "「副産物」は report が節の位置づけを述べる見出し語であって、主張ではない。",
        grounds: {
          type: "positioning",
          reportQuote: "## 4. 副産物: 命題 C はトレース列の読みでは偽",
        },
      },
    ],
  },
  {
    block: "paper_045_theorem_lte",
    passages: [
      {
        report: "outputs/reports/cycle8_T1_lte_proposition.md",
        from: "## 命題 Λ（$p$ 進, 各素点）— LTE で完全・決定可能",
        to: "- **$p\\mid c$**: $c^L\\equiv0$",
        covers: "命題 L の 4 分岐（$p$ 奇の $d\\mid L$ / $d\\nmid L$、$p=2$ の $L$ 奇 / 偶）",
      },
    ],
    acknowledged: [],
  },
  {
    block: "paper_045_theorem_trace_ladder",
    passages: [
      {
        report: "outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md",
        from: "**定理 A′.** $k\\ge w^*+1$ ならば",
        to: "**定理 A′.** $k\\ge w^*+1$ ならば",
        covers: "命題 C″ の（階段）$t_{k+1}\\mid p\\,t_k$",
      },
      {
        report: "outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md",
        from: "**しきい値 $w^*+1$ は最良である**",
        to: "**系 A″（改良した主定理）.** すべての $k\\ge1$ で",
        covers: "しきい値 $w^*+1$ の最良性と、（改良した上界）系 A″",
      },
      {
        report: "outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md",
        from: "**指数はこれ以上下げられない**",
        to: "**指数はこれ以上下げられない**",
        covers: "指数 $k-w^*-1$ の最良性",
      },
      {
        report: "outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md",
        from: "**定理 S.** $g_m:=",
        to: "$$e_k=\\min\\{m\\ge0:\\ g_m\\ge k\\}.$$",
        covers: "命題 C″ の（構造）定理 S（$e_k=\\min\\{m:g_m\\ge k\\}$）",
      },
      {
        report: "outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md",
        from: "**障害 1: $g_0$ は固有値データから決まらない。**",
        to: "**結論（(i) の決着）**",
        covers: "命題 C″ の（閉形式は存在しない）2 つの障害（Wieferich 型の初期値・Wall 型等式の不成立）",
      },
      {
        report: "outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md",
        from: "**決定可能性は失われない。**",
        to: "**決定可能性は失われない。**",
        covers: "閉形式が無くても決定可能性は失われないこと",
      },
    ],
    acknowledged: [
      {
        item: "c^{\\tau}",
        reason:
          "report は障害 1 を $r=1$（$T=(c)$）の場合の $g_0=v_p(c^{\\tau}-1)$ で具体化する。本文は「$g_0$ を固有値データから決める式が要るが、これは Wieferich 型の量であり」と述べており、閉形式が無い理由（$g_0$ が固有値データから決まらないこと）は落ちていない。具体例の式を書いていないだけである。",
        grounds: {
          type: "example",
          reportQuote: "$r=1$（$T=(c)$）のとき$g_0=v_p(c^{\\tau}-1)$",
          bodyQuote: "を固有値データから決める式が要るが、これは Wieferich 型の量であり",
        },
      },
      {
        item: "最小",
        reason:
          "「最小の反例」の「最小」。本文は同じ反例（$T=(3)$、$p=2$、$t_k=1,2,2,4,8,16$）を挙げている。",
        grounds: {
          type: "example",
          reportQuote: "最小の反例:",
          bodyQuote: "t_k=1,2,2,4,8,16",
        },
      },
    ],
  },
  {
    block: "paper_051_theorem_duality",
    passages: [
      {
        report: "outputs/reports/cycle15_T1_kataoka_and_general_P.md",
        from: "### 3.2 帰結（一般の $P$ について）",
        to: "**これがグラフのラプラシアンに限らない一般の $P$ に対する増大の完全な形である。**",
        covers: "命題 D の (p 素点, 塔の漸近) の漸近形（$\\lambda=l_0(f)$・$\\mu=m_0(f)=v_p(\\mathrm{content}\\,P)$ を含む）",
      },
      {
        report: "outputs/reports/cycle16_T1_monsky_primary_sources.md",
        from: "**なお、原典を読んで初めて分かった規約上の要点**",
        to: "**$a^{\\mathrm{red}}$（退化因子を落とした積）を使う流儀は原典の規約そのもの**である。",
        covers: "規約 $\\mathrm{ord}\\,0=0$（$a^{\\mathrm{red}}$ を使う流儀が原典の規約そのものであること）",
      },
    ],
    acknowledged: [
      {
        item: "冪根",
        reason:
          "report の「$P$ が $p$ 冪根で零点をもたなければ $a^{\\mathrm{red}}=a$」は、本文では整数スペクトル曲線の定義ブロックが「$P$ が 1 の冪根の組で零点をもたなければ両者は一致する」として持つ。本ブロックは $a^{\\mathrm{red}}$ の側だけを扱う分担である。",
        grounds: {
          type: "division",
          reportQuote: "$P$ が $p$ 冪根で零点をもたなければ $a^{\\mathrm{red}}=a$",
          holder: "paper_021_definition_curve",
          holderItem: "1 の冪根の組で零点をもたなければ両者は一致する",
        },
      },
      {
        item: "整合",
        reason:
          "「本論文の定義はこの規約と整合しており」は report が本文を評価する言葉である。本文は規約そのもの（Cuoco–Monsky が p.237 で明示した $\\mathrm{ord}\\,0=0$ という通常とは異なる規約）を書いている。",
        grounds: {
          type: "positioning",
          reportQuote: "という定義はこの規約と整合しており",
        },
      },
    ],
  },
  {
    block: "paper_052_theorem_l0_computable",
    passages: [
      {
        report: "outputs/reports/cycle16_T1_lambda_l0_computability.md",
        from: "### 2.6 定理 C1",
        to: "### 2.7 計算量（正直に）",
        quotedOnly: true,
        covers: "(F1 計算可能性)（$\\lambda=l_0(f)$ の有限手続きと、素朴なレシピが上限しか与えないこと）",
      },
      {
        report: "outputs/reports/cycle16_T1_lambda_l0_computability.md",
        from: "### 4.2 定理 C2（停止問題への還元）",
        to: "### 4.3 $d=1$ との差（境界の位置）",
        quotedOnly: true,
        covers: "(F2 境界)（一般の $f$ では $l_0(f)\\ge1$ が決定不能）",
      },
    ],
    acknowledged: [
      {
        item: "v_{p}",
        reason:
          "定理 C1 は $m_0(f)=v_p(\\mathrm{content}\\,P)$ と $l_0(f)$ の式を同時に述べる。本文のこのブロック (F1) は $\\lambda=l_0(f)$ の側だけを担い、$\\mu=m_0(f)=v_p(\\mathrm{content}\\,P)$ は双対命題 D が述べる分担である。",
        grounds: {
          type: "division",
          reportQuote: "**定理 C1.** $0\\neq P\\in\\mathbb{Z}[z_1^{\\pm},\\dots,z_d^{\\pm}]$",
          holder: "paper_051_theorem_duality",
          holderItem: "m_0(f)=v_p\\bigl(\\mathrm{content}\\,P\\bigr)",
        },
      },
      {
        item: "z^{\\pm}_{1}",
        reason:
          "記法の差（report は $z_1^{\\pm}$、本文は $z_1^{\\pm1}$）。同じ Laurent 多項式環である。",
        grounds: {
          type: "notation",
          reportQuote: "**定理 C1.** $0\\neq P\\in\\mathbb{Z}[z_1^{\\pm},\\dots,z_d^{\\pm}]$",
          bodyQuote: "\\mathbb{Z}[z_1^{\\pm1},\\dots,z_d^{\\pm1}]",
        },
      },
      {
        item: "z^{\\pm}_{d}",
        reason:
          "同上。",
        grounds: {
          type: "notation",
          reportQuote: "**定理 C1.** $0\\neq P\\in\\mathbb{Z}[z_1^{\\pm},\\dots,z_d^{\\pm}]$",
          bodyQuote: "\\mathbb{Z}[z_1^{\\pm1},\\dots,z_d^{\\pm1}]",
        },
      },
      {
        item: "有限集合",
        reason:
          "report は $V(\\bar P)$ に「（有限集合）」と注記する。本文は同じ $V(\\bar P)=\\{\\mathrm{prim}(e-e'):e\\neq e'\\in E\\}$ を有限台 $E$ から定義し、右辺が有限個の演算で計算できると述べているので、有限性は主張に含まれている。",
        grounds: {
          type: "paraphrase",
          reportQuote: "ただし $V(\\bar P):=\\{\\mathrm{prim}(e-e'):e\\neq e'\\in E\\}$（有限集合）",
          bodyQuote: "V(\\bar P):=\\{\\mathrm{prim}(e-e')\\ :\\ e\\neq e'\\in E\\}",
        },
      },
      {
        item: "入力",
        reason:
          "定理 C2 の入力の与え方（Turing 機械の指標）についての言い回し。本文 (F2) は「係数を計算する手続きで与えられた一般の $f$」と同じことを述べている。",
        grounds: {
          type: "paraphrase",
          reportQuote: "入力を「係数関数を計算する Turing 機械の指標」で与えられた",
          bodyQuote: "係数を計算する手続きで与えられた一般の",
        },
      },
      {
        item: "係数関数",
        reason:
          "同上。",
        grounds: {
          type: "paraphrase",
          reportQuote: "入力を「係数関数を計算する Turing 機械の指標」で与えられた",
          bodyQuote: "係数を計算する手続きで与えられた一般の",
        },
      },
      {
        item: "指標",
        reason:
          "同上。",
        grounds: {
          type: "paraphrase",
          reportQuote: "入力を「係数関数を計算する Turing 機械の指標」で与えられた",
          bodyQuote: "係数を計算する手続きで与えられた一般の",
        },
      },
      {
        item: "同値",
        reason:
          "report の「停止問題と同値の困難さをもつ」を、本文は「停止問題に還元される」と書いている。決定不能性の主張は同じで、本文は還元の向きだけを述べる**弱い方**である。",
        grounds: {
          type: "weaker",
          reportQuote: "は**決定不能**（停止問題と同値の困難さをもつ）",
          bodyQuote: "**決定不能**である（停止問題に還元される）",
        },
      },
      {
        item: "困難",
        reason:
          "同上。",
        grounds: {
          type: "weaker",
          reportQuote: "は**決定不能**（停止問題と同値の困難さをもつ）",
          bodyQuote: "**決定不能**である（停止問題に還元される）",
        },
      },
    ],
  },
  {
    block: "paper_053_theorem_lower_order",
    passages: [
      {
        report: "outputs/reports/cycle16_T3_lower_order_and_degeneracy.md",
        from: "> **定理 N1.** *(H) を仮定し、塔が**非退化**かつ $J_0=1$",
        to: "> $$\\nu=v_\\ell(\\kappa(X))-\\mu-\\frac{k(\\ell+1)}{\\ell-1},\\qquad n_0=0. \\tag{2.2}$$",
        quotedOnly: true,
        covers: "(G1) のうち $J_0=1$ の完全閉形式（定理 N1）",
      },
      {
        report: "outputs/reports/cycle16_T3_lower_order_and_degeneracy.md",
        from: "> **定理 N2.** *(H) を仮定し、塔が**非退化**とする。",
        to: "> *すなわち $\\nu=v_\\ell(\\kappa(X))-\\mu-\\dfrac{k(\\ell+1)}{\\ell-1}+\\Delta$ であり、$n_0\\le J_0-1$。*",
        quotedOnly: true,
        covers: "(G1) のうち $J_0\\ge2$ の補正 $\\Delta$ と成立範囲 $n\\ge J_0-1$（定理 N2）",
      },
      {
        report: "outputs/reports/cycle16_T3_lower_order_and_degeneracy.md",
        from: "> **系 N3.** *(H) と非退化を仮定する。",
        to: "5 係数すべてが $D$ の係数からの有限計算で決まる",
        quotedOnly: true,
        covers: "(G1) の「全係数が $D$ の係数からの有限計算で決まる」（系 N3）",
      },
      {
        report: "outputs/reports/cycle16_T3_lower_order_and_degeneracy.md",
        from: "> **定理 D1.**",
        to: "### 4.4 第 3 点への答え（退化点の増え方）",
        quotedOnly: true,
        covers: "(G2 退化点の計数)（定理 D1）",
      },
      {
        report: "outputs/reports/cycle16_T3_lower_order_and_degeneracy.md",
        from: "> **定理 D2.**",
        to: "## 6. $\\ell$ が奇素数の退化塔",
        quotedOnly: true,
        covers: "(G3 $\\ell=2$ トーラス)（定理 D2）",
      },
      {
        report: "outputs/reports/cycle17_T3_delta_and_kappa_contributions.md",
        from: "> **命題 A.** *(H) を仮定し、塔を**非退化**とする。",
        to: "> $n\\ge0$ の全段で成立する。とくに **$\\Delta\\neq0$ であるためには $k\\ge\\ell+1$ が必要**である。*",
        quotedOnly: true,
        covers: "(G1′ 補正が消える十分条件)（命題 A・系 A′）",
      },
      {
        report: "outputs/reports/cycle17_T3_degenerate_torus_odd_ell.md",
        from: "> **定理 E.** *$\\ell$ を奇素数とし、",
        to: "> $e=\\nu=-\\dfrac{2\\ell+2+2z_H}{\\ell-1}$、$n_0=0$ である。*",
        quotedOnly: true,
        covers: "(G4 $\\ell$ 奇のトーラス)（定理 E）",
      },
      {
        report: "outputs/reports/cycle18_T3_general_degenerate_tower.md",
        from: "> **定理 C.** *(H) を仮定し、**全ての $P\\in\\mathbb{P}^1(\\mathbb{F}_\\ell)$ で",
        to: "> $a=\\mu$, $b=0$, $c=\\dfrac{\\Theta}{\\ell-1}$, $d=-2$,",
        quotedOnly: true,
        covers: "(G5 消滅深度による一般の退化塔)（定理 C・系 D）",
      },
    ],
    acknowledged: [
      {
        item: "\\kappa",
        reason:
          "report は $v_\\ell(\\kappa(X))$ と書き、本文は同じ量を $v_\\ell(\\kappa_X)$ と書く。記法の差であって量は同じである。",
        grounds: {
          type: "notation",
          reportQuote: "$$\\nu=v_\\ell(\\kappa(X))-\\mu-\\frac{k(\\ell+1)}{\\ell-1},\\qquad n_0=0. \\tag{2.2}$$",
          bodyQuote: "v_\\ell(\\kappa_X)",
        },
      },
      {
        item: "\\nu",
        reason:
          "定理 N1 $(2.2)$ は定数項を $\\nu$ と名付けて取り出す。本文のこのブロックは閉形式そのものを書き、$\\nu$ という名前は命題 W と命題 D の限界のブロックが使う分担である。",
        grounds: {
          type: "division",
          reportQuote: "すなわち cycle 14 定理 5 $(8.4)$ の $\\nu$ と $n_0$ は",
          holder: "paper_063_theorem_W",
          holderItem: "\\nu\\in\\mathbb{Q}",
        },
      },
      {
        item: "\\zeta",
        reason:
          "report の命題 A は結論を点ごとの付値 $v_\\ell(E(\\zeta,\\xi))$ として書く。本文 (G1′) は同じ結論を「全レベルの全点で $v_\\ell(E)=k/\\varphi(\\ell^M)$」と、点を記号で名指さずに書いている。",
        grounds: {
          type: "paraphrase",
          reportQuote: "すべての点 $(\\zeta,\\xi)\\neq(1,1)$",
          bodyQuote: "v_\\ell(E)=k/\\varphi(\\ell^M)",
        },
      },
      {
        item: "\\xi",
        reason:
          "同上。",
        grounds: {
          type: "paraphrase",
          reportQuote: "すべての点 $(\\zeta,\\xi)\\neq(1,1)$",
          bodyQuote: "v_\\ell(E)=k/\\varphi(\\ell^M)",
        },
      },
      {
        item: "仮定",
        reason:
          "「(H) を仮定し」の (H) は cycle 14 以来の共通設定（有限連結多重グラフの $\\mathbb{Z}_\\ell^2$ 塔）であり、本文はこのブロックの冒頭で命題 W の設定を参照している。",
        grounds: {
          type: "division",
          reportQuote: "(H) を仮定し、塔が**非退化**かつ $J_0=1$",
          holder: "paper_063_theorem_W",
          holderItem: "**非退化**",
        },
      },
      {
        item: "同値",
        reason:
          "cycle 18 定理 C の但し書き「補題 A3p より、$\\ell$ が奇なら『$\\theta(P)\\le\\ell-1$』と同値」。本文 (G6) は $\\theta(P)\\le\\ell$ の側だけを条件として書いており、奇 $\\ell$ での同値な言い換えを主張していない（弱い方だけを書いている）。",
        grounds: {
          type: "weaker",
          reportQuote: "$\\ell$ が奇なら「$\\theta(P)\\le\\ell-1$」と同値",
          bodyQuote: "\\theta(P)\\le\\ell",
        },
      },
    ],
  },
  {
    block: "paper_054_remark_limits",
    passages: [
      {
        report: "outputs/reports/cycle16_T1_monsky_primary_sources.md",
        from: "and an explicit interpretation of $l_0$ is given. The other coefficients remain mysterious.",
        to: "and an explicit interpretation of $l_0$ is given. The other coefficients remain mysterious.",
        covers: "限界 (i)（$m_0$ と $l_0$ 以外の係数は原論文が mysterious と明記している）",
      },
      {
        report: "outputs/reports/cycle18_T1_monsky1989_acquisition.md",
        from: "| Monsky 1989 に $\\mu_1$（$p^{(d-1)n}$ の係数）の**明示式**はあるか |",
        to: "| 本論文の命題 W の位置づけは変わるか |",
        covers: "限界 (i)（低位項の係数に明示式が無く、$d=2$ で有理数であることしか示されていないこと）",
      },
      {
        report: "outputs/reports/cycle18_T3_general_degenerate_tower.md",
        from: "### 6.1 $\\theta\\ge\\ell+1$ の場合の閉形式",
        to: "「同じ方向の点が同じ値を取る」ことだけである。",
        covers: "限界 (ii)（$\\theta\\ge\\ell+1$ の退化塔には閉形式が無いこと）",
      },
    ],
    acknowledged: [],
  },
  {
    block: "paper_061_theorem_V",
    passages: [
      {
        report: "outputs/reports/cycle14_T1_vp_growth_two_variable.md",
        from: "### 3.2 命題 V",
        to: "### 3.3 系（$n=0$ の値）",
        quotedOnly: true,
        covers: "命題 V（$v_p(a_{p^n})>0\\iff p\\mid P(1,1)$、$n$ に依らない）と、$P(1,1)\\ne0$ が証明の仮定ではないこと",
      },
    ],
    acknowledged: [
      {
        item: "仮定",
        reason:
          "report の注は「$P(1,1)\\ne0$ は判定として意味をもつための条件であって、証明の仮定ではない」と述べる。本文は $P(1,1)\\ne0$ を仮定として置いておらず、$P\\in\\mathbb{Z}[z^{\\pm1},w^{\\pm1}]$ 一般について同値を述べている＝report の注が言うとおりの形になっている。",
        grounds: {
          type: "paraphrase",
          reportQuote: "ための条件であって、証明の仮定ではない",
          bodyQuote: "v_p(a_{p^n})>0\\iff p\\mid P(1,\\dots,1)",
        },
      },
      {
        item: "意味",
        reason:
          "同上。",
        grounds: {
          type: "paraphrase",
          reportQuote: "は「判定として意味をもつ」ための条件であって",
          bodyQuote: "v_p(a_{p^n})>0\\iff p\\mid P(1,\\dots,1)",
        },
      },
      {
        item: "左辺",
        reason:
          "report の「左辺は $a_{p^n}=0$ のときは $v_p=\\infty>0$ と読む」という読み方の注。本文も $v_p(a_{p^n})>0$ の形で述べており、$a_{p^n}=0$ を除外していない。",
        grounds: {
          type: "paraphrase",
          reportQuote: "（左辺は $a_{p^n}=0$ のときは $v_p=\\infty>0$ と読む",
          bodyQuote: "v_p=\\infty>0",
        },
      },
    ],
  },
  {
    block: "paper_062_theorem_T",
    passages: [
      {
        report: "outputs/reports/cycle14_T1_proposition_T_generalization.md",
        from: "**定理 D.** $L$ を奇数とすると $v_2(\\tau_2(L))=2(L-1)$。",
        to: "$m\\equiv0$ のときは $1+\\zeta^m=2$ で $v=1$。",
        covers: "命題 T（奇 $L$ で $v_2(\\tau(L))=2(L-1)$）の証明",
      },
    ],
    acknowledged: [
      {
        item: "\\zeta^{m}",
        reason:
          "report の証明は $1+\\zeta^m$ の付値を $m\\equiv0$ か否かで場合分けする。本文の証明は同じ段を $\\zeta^j+\\zeta^{-j}$ と $r_j$ の言葉で書いており、$m$ という補助添字を導入していない。",
        grounds: {
          type: "notation",
          reportQuote: "$m\\equiv0$ のときは $1+\\zeta^m=2$ で $v=1$。",
          bodyQuote: "r_j+r_j^{-1}=4-\\zeta^{j}-\\zeta^{-j}",
        },
      },
    ],
  },
  {
    block: "paper_063_theorem_W",
    passages: [
      {
        report: "outputs/reports/cycle14_T3_two_variable_criterion.md",
        from: "**定義 8.1.** 定義 5.1 の $H\\in\\mathbb{F}_\\ell[T,S]$",
        to: "**定義 8.1.** 定義 5.1 の $H\\in\\mathbb{F}_\\ell[T,S]$",
        covers: "命題 W の非退化条件",
      },
      {
        report: "outputs/reports/cycle14_T3_two_variable_criterion.md",
        from: "> **定理 5.** *(H) を仮定し、さらに塔が**非退化**（定義 8.1）であるとする。",
        to: "> *とくに $(7.2)$ の係数は $a=\\mu$、$b=l_0=0$、",
        covers: "命題 W（非退化な $\\mathbb{Z}_\\ell^2$ 塔での閉形式。定理 5）",
      },
    ],
    acknowledged: [
      {
        item: "n_{0}",
        reason:
          "report は「$n_0\\ge1$ と $\\nu\\in\\mathbb{Q}$ が存在して $(n\\ge n_0)$」と書き、本文は同じことを「$n\\gg0$ で」と書いている。**「ある $n_0$ から先」と「$n\\gg0$」は同じ主張**である。",
        grounds: {
          type: "paraphrase",
          reportQuote: "このとき $n_0\\ge1$ と $\\nu\\in\\mathbb{Q}$ が存在して",
          bodyQuote: "n\\gg0",
        },
      },
      {
        item: "\\dfrac",
        reason:
          "組版の指定（$\\dfrac$ と $\\frac$）であって記号ではない。本文は同じ $\\frac{k(\\ell+1)}{\\ell-1}$ を書いている。",
        grounds: {
          type: "notation",
          reportQuote: "$c=\\dfrac{k(\\ell+1)}{\\ell-1}$、$d=-2$ と完全に決まる",
          bodyQuote: "\\frac{k(\\ell+1)}{\\ell-1}",
        },
      },
      {
        item: "完全",
        reason:
          "report の「$(7.2)$ の係数は … と完全に決まる」という評価語。本文は 4 係数を式として書き下しており、$\\nu$ については $\\mathbb{Q}$ であって一般に $\\mathbb{Z}$ でないことまで述べている。",
        grounds: {
          type: "positioning",
          reportQuote: "$d=-2$ と完全に決まる",
        },
      },
    ],
  },
  {
    block: "paper_071_remark_asymmetry",
    passages: [
      {
        report: "sagemath/check/cycle10_T3_lehmer/padic_analog_README.md",
        from: "## 結論: Λ 側に Lehmer 型問題は存在しない（決定可能側）",
        to: "誇張しない。",
        covers: "二素点の難易度が対称でないこと（ℝ 側の Lehmer 問題 ↔ Λ 側の離散な $\\mu$）と、新しい定理ではないこと",
      },
      {
        report: "sagemath/check/cycle10_T3_lehmer/README.md",
        from: "## 正直な注記（スケールの罠）",
        to: "「双対がどこに繋がるか」の地図",
        covers: "$4G/\\pi$ と Lehmer 数の近さがスケール違いの偶然であること",
      },
    ],
    acknowledged: [
      {
        item: "測度・エントロピー",
        reason:
          "語の切り出しが「Mahler 測度・エントロピー」という並列表記を 1 語として拾ったもの。本文は「Mahler 測度 ＝ エントロピー ＝ 自由エネルギー密度」と等式の形で同じ 3 者を並べている。",
        grounds: {
          type: "notation",
          reportQuote: "Mahler 測度・エントロピーは **ℝ 側（非可算・一般に非決定可能）**",
          bodyQuote: "Mahler 測度 ＝ エントロピー ＝ 自由エネルギー密度",
        },
      },
      {
        item: "非可算・一般",
        reason:
          "同上（「非可算・一般に非決定可能」の切り出し）。本文は同じ内容を「$\\mathbb{R}$ の元で連続」「一般の値は計算不能実数でもありうる」と書いている。",
        grounds: {
          type: "notation",
          reportQuote: "Mahler 測度・エントロピーは **ℝ 側（非可算・一般に非決定可能）**",
          bodyQuote: "一般の値は計算不能実数でもありうる",
        },
      },
      {
        item: "非決定可能",
        reason:
          "同上。本文は「計算不能実数でもありうる」と、より具体的な形で述べている。",
        grounds: {
          type: "paraphrase",
          reportQuote: "Mahler 測度・エントロピーは **ℝ 側（非可算・一般に非決定可能）**",
          bodyQuote: "一般の値は計算不能実数でもありうる",
        },
      },
    ],
  },
  {
    block: "paper_072_remark_qp_free",
    passages: [
      {
        report: "outputs/reports/cycle17_T1_prior_art_check.md",
        from: "### 2.4 判定",
        to: "## 3. 命題 T（奇 $L$ で $v_2(\\tau(L))=2(L-1)$）の既出性",
        covers:
          "$\\mathbb{Q}_p$ の一階理論が決定可能であること（Ax–Kochen / Ershov）、可算符号化は標準手法であること、差分が「等号を決定可能な水準まで降ろしたこと」の 1 点であること、および 0 件の記録",
      },
    ],
    acknowledged: [],
  },
  {
    block: "paper_081_remark_scope",
    passages: [
      {
        report: "outputs/reports/cycle17_T1_prior_art_check.md",
        from: "### 3.3 判定",
        to: "## 4. 命題 V",
        covers: "命題 T の既出性判定（弱い形が既出）",
      },
      {
        report: "outputs/reports/cycle17_T1_prior_art_check.md",
        from: "### 4.3 判定",
        to: "## 5. 命題 W",
        covers: "命題 V の既出性判定（$d=1$ で既出）",
      },
      {
        report: "outputs/reports/cycle17_T1_prior_art_check.md",
        from: "### 5.5 判定",
        to: "## 6. 論文 001 の本文へ反映すべき事項",
        covers: "命題 W の既出性判定（形が $d=1$ で既出）",
      },
    ],
    acknowledged: [
      {
        item: "未確認",
        reason:
          "**この report の記述のほうが古い。** cycle 17 は「Monsky 1989 が未確認である以上『文献に無い』と書いてはならない」と留保していたが、cycle 18 step 4 が Project Euclid の Open Access 版で本文を取得・読了して留保を解消した（`cycle18_T1_monsky1989_acquisition.md`）。本文はその後の判定（Open Access 版で本文を確認した）を書いており、落としているのではなく更新している。",
        grounds: {
          type: "reportStale",
          reportQuote: "ただし Monsky 1989 が未確認である以上",
          supersededBy: {
            report: "outputs/reports/cycle18_T1_monsky1989_acquisition.md",
            marker: "### 2.1 Introduction — Monsky 自身が「明示式は無い」と書いている",
          },
        },
      },
    ],
  },
  {
    block: "paper_082_remark_formalization",
    passages: [
      {
        report: "lean/README.md",
        from: "1. ソース中に `sorry` / `admit` が残っていないこと（grep）。",
        to: "（`propext` / `Classical.choice` / `Quot.sound` は mathlib 標準の 3 公理で問題ない）。",
        covers: "sorry ゼロを機械確認していること",
      },
      {
        report: "lean/README.md",
        from: "判定語: **完了** / **部分的**",
        to: "判定語: **完了** / **部分的**",
        covers: "形式化の現状表の判定語（完了 / 部分的 / 未着手。未着手はなぜかを一次情報で明記する）",
      },
    ],
    acknowledged: [],
  },
];
