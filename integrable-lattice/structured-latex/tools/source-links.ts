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
      },
      {
        item: "高位",
        reason:
          "同上。「高位の桁で消える」は $Z_N$ の $p$ 進付値が跳ぶ仕組みの説明であり、本文が持つ反例（奇数 $N$ で $Z_N=0$、$N=2k$ で $Z_N=2^{k+1}$）がその仕組みを具体的に示している。",
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
      },
      {
        item: "P_{i}",
        reason:
          "同上（$P_i$ は $S_\infty$ の点の番号付け。本文の $\max_{P}$ が同じ範囲を走る）。",
      },
      {
        item: "P_{r}",
        reason:
          "同上。",
      },
      {
        item: "u_{i}",
        reason:
          "同上（$u_i=\iota^{-1}(P_i)$ の番号付け。本文は $\det(u,u')$ と書いている）。",
      },
      {
        item: "u_{j}",
        reason:
          "同上。",
      },
      {
        item: "e_{m}",
        reason:
          "report の $e_m$ は本文の $e_{m_u}$ と同じ量である（report も同じ節で $m=m_P$ と置いている）。本文は基点 $P$ に対応する $u$ を明示する記法を採っている。",
      },
      {
        item: "\\kappa_{n}",
        reason:
          "系 W6 が係数を取り出している展開 $\mathrm{ord}_\ell(\kappa_n)$ は本文では 命題 J (J4) が持つ。命題 K (K6) はその展開の $n\ell^n$ 係数 $b$ だけを述べる分担であり、本文は (K6) の冒頭で 命題 J を参照している。",
      },
      {
        item: "\\psi_{u}",
        reason:
          "**本文はこれを持たない。** report は $e_{m_u}=\mathrm{ord}_{x=0}\bar\psi_u(G)$ という $e_{m_u}$ の明示式を与えるが、本文 (K4) の主張は $j^*(P)=m_u$ であって $e_{m_u}$ の値は使わない。(K5) は $e_{m_u}$ を $r_0$ の式に含むが、そこで要るのは $e_{m_u}<\infty$（(K4) が述べている）だけである。したがって主張は成り立つ。ただし $e_{m_u}$ を実際に計算する式が本文に無いことは事実なので、本文側の判断（書き足すか、report 参照に留めるか）は本文を担当する step へ回す。",
      },
      {
        item: "グラフ",
        reason:
          "report の「$\ell$、グラフ、voltage のどれにも依らない一様な式で書ける」という強い言い方を、本文は「$D$ の係数からの $\mathbb{F}_\ell$ 上の有限計算だけで決まる」に留めている。**弱い方の主張だけを書いている**ので、落としても本文の主張は成り立つ（強い方を主張していない）。",
      },
      {
        item: "一様",
        reason:
          "同上。",
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
      },
      {
        item: "本サイクル",
        reason:
          "同上。",
      },
      {
        item: "存在",
        reason:
          "report の「例外直線が存在する（$\ell\mid p'q'(p'+q')$）」という仮定を、本文は「例外直線があるとき」と書いている。条件式 $\ell\mid p'q'(p'+q')$ そのものは本文にある。",
      },
      {
        item: "予言",
        reason:
          "report のこの文は数値検証の枠組み（H4 が 3 分解を数値で出す）についての注であり、定理の主張ではない。本文は同じ数値検証を `verification` のラベルで指している。",
      },
      {
        item: "数値",
        reason:
          "同上。",
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
      },
      {
        item: "b_{j}",
        reason:
          "同上（$b_j$ は採らなかった Cramer 則の経路に現れる係数）。",
      },
      {
        item: "p^{k-v}",
        reason:
          "同上（$v$ による弱い方の整除。本文が主張するのは $w^*$ による強い方である）。",
      },
    ],
  },
];
