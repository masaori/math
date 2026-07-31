# MEMORY

## cycle 18 step 2 done（2026-07-31, T3 Pure）: トレース列の周期の上界を確定させた

`outputs/reports/cycle18_T3_trace_period_bound.md` / `sagemath/check/cycle18_T3_trace_period/`。
cycle 17 が「命題 C はトレース列の読みでは偽」で止めた穴を塞いだ。

- **主結果（証明済み）**: $\pi_{\mathrm{tr}}(p,k)\mid p^{k-1}\pi_{\mathrm{tr}}(p,w^*+1)$。
  $w^*$ は Gram 行列 $G=(\mathrm{Tr}\,T^{i+j})_{i,j<\deg\mathrm{rad}\chi}$ の**最大単因子**の $p$ 進付値。
- **直すべきは指数ではなく基準レベルだった。** $\pi_{\mathrm{tr}}(p,k)\mid p^a\pi_{\mathrm{tr}}(p,1)$ は
  $a$ をどう取っても偽（$F\oplus F$, $p=2$ で $t_1=1$, $t_2=3$）。**最初にこの形で立てて反証された**（報告 §8）。
- **なぜ壊れていたかの説明**: $\det G=\mathrm{disc}(\rho)\prod_\lambda m_\lambda$ なので、
  $w^*=0$ は「$\rho$ が $\bmod p$ 分離的 & 全ての $p\nmid m_\lambda$」＝**命題 B の条件そのもの**。
  命題 C がトレース列で破れるのは偶然ではなく命題 B の帰結。
- **$\mathbb{R}$ にも $\mathbb{Z}_p$ にも脱出しない**（$\mathbb{Z}$ 上の Cramer 則・Smith 標準形と
  $\overline{\mathbb{Q}}$ の Vandermonde だけ）。$w^*$ は Smith 標準形で決定可能。
- 本文へ**命題 C′（`paper_prop_C_trace`）**を追加し、命題 C の「上界は未確立」の文を差し替えた。
- **数値支持どまり**（本文に入れていない）: $w^*+1\le k\le2w^*$ での階段 $t_{k+1}\mid p\,t_k$。
  402 件 0 反例だが、この標本の検出力は破れ率 0.74% までであることを明記した。
- **教訓（再確認）**: 証明を立てた直後に数値へかけたから、誤った主結果とGram 非退化性の仮定漏れが
  即座に露見した。数値検証を後回しにしていたら cycle 17 と同型の事故を繰り返していた。

## cycle 17 完了（2026-07-31）＝ cycle 16 総括の 4 点を潰すサイクル

**掲げた 4 点はすべて潰れた**（3 点は肯定的に決着、1 点＝既出性は「おおむね既出」という決着）。
**最大の発見は、論文の命題 B が偽だったこと**（下記 step 3）。

- **step 1: 照合の穴が両方塞がった。** $\Delta\neq0$ の例 5 件、$v_\ell(\kappa_X)>0$ の例 6 件（うち 1 件は 3 寄与同時）。
  **さらに cycle 16 で $\Delta=0$ しか出なかった理由を証明つきで説明**（$k\le\ell\Rightarrow\Delta=0$。
  cycle 16 の 5 件は $\ell=3,k=2$ なので最初から決まっていた）。**$\Delta\neq0$ は小さい $\ell$ の現象**。
  副産物: $\ell=2$ の非退化塔の存在（cycle 14 が未決としていた）。本文へ (G1′)。
- **step 2: $\ell$ 奇のトーラスが解けた（仮説 6.1 を証明）。** **詰まりの正体は評価の甘さではなく道具の選び方**で、
  割り算が $1/m!$ を持ち込み $\ell$ 整数性を壊していた。分子をそのまま展開すれば係数は整数の有限和になる。
  **$\ell=2$ と合わせトーラスは全素数で解けた。** 型 II の実例も確定（退化なのに $n\ell^n$ 項が無い塔）。本文へ (G4)(G5)。
- **step 3・step 4** は下記。
- **残る未解決**: 一般の退化塔（障害は特定済み＝消え方の深さを $M$ に依らない不変量として取り出す条件、$\ell=2$ が反例）／
  トレース列の周期の上界（新規）／一般の $d$ の低位項／**Monsky 1989 の本文未取得**（投稿前に必読）。
- **運用**: サブエージェント 4 本すべてが規約遵守（cycle 16 の main 直 push は再発せず。指示文への明示が効いた）。
  **並列実行の副作用が 1 件**: step 1 が塞いだ穴を step 2 が報告中で「依然 0 件」と書いていた（互いの結果を知らない）。
  呼び出し元が本文と report で整合させた。**並列 step の報告は統合時に必ず突き合わせること。**
- **cycle 18 の焦点**: (1) 一般の退化塔 (2) トレース列の周期の上界 (3) **確定済み命題も Lean に通す**
  （命題 B の事故を踏まえた主張の検算） (4) Monsky 1989 の入手（購読以外の経路）。

- **step 3 done（本サイクル最大の発見）: Lean で形式化しようとしたら、論文の命題 B が偽だと判明した。**
  `outputs/reports/cycle17_ops_lean_propB.md`。**記号 $\pi(p,1)$ が 2 つの別量に使われていた**:
  命題 A の定義は**行列冪列** $T^N\bmod p^k$ の最終周期、命題 B の証明が実際に計算しているのは
  **トレース列** $\mathrm{Tr}\,T^N\bmod p$ の最終周期。本文は後者の主張なのに前者を参照していた。
  - **反例**: $(0\,1;1\,1)^{\oplus2}$, $p=2$。行列冪列の周期 3、トレース列の周期 1（恒等的に 0）、右辺 1
    （重複度がともに 2 なので集合が空）。**この行列は半単純なので、cycle 16 が想定した
    「半単純性を組み立てれば逆向きが出る」筋では救済できない。** 無作為 2487 例中 563 例（22.6%）で食い違う。
  - **読みをトレース列に直せば両方向とも成立**し、代数閉体上で仮定なしの完成形まで Lean で閉じた。
  - **副産物**: 命題 C は逆に**トレース列の読みでは偽**（1669 例中 56 例＝3.4%）。
    **命題 A・B・C は同じ記号を共有できない。** 本文の 3 命題すべてを訂正した。
  - **新たに立った未解決**: トレース列の周期 $\pi_{\mathrm{tr}}(p,k)$（$k\ge2$）の上界。
  - ビルド 8664 jobs 成功・**63 定理が sorryAx 非依存**。**mathlib の欠落は 1 件も主張していない**
    （「無い」と書く予定だった補題を自前で組み立てられた）。
  - **教訓: 形式化は「証明の検算」ではなく「主張の検算」として効いた。** 人手証明では 2 つの量の混同が
    10 サイクル以上見逃されていたが、Lean は記号を区別せざるを得ないので即座に露見した。
  - 呼び出し元が**反例を独立に計算して確認**（数行で再現できる）し、検証スクリプトも再実行した。
- **step 4 done: 投稿前の既出性を調べ、結果は「おおむね既出」だった**（`outputs/reports/cycle17_T1_prior_art_check.md`）。
  本論文は新規性を主張していないので**瑕疵ではなく、位置づけが正確になった**。
  - **命題 V は $d=1$ で既出**（周期点数列は Dold 数列で、$n=p$ から $a_p\equiv a_1$。
    Byszewski–Graff–Ward, Bull. LMS 53 (2021) Def 2.1 を本文確認）。差分は「$a_L=0$ を許し $d$ 任意」の 1 点。
  - **命題 T は弱い形（$v_2$ が偶数）が既出**（Mednykh–Mednykh arXiv:1902.05681 Thm 5.1、§7.6 が本件のトーラス）。
    等号 $2(L-1)$ は見つからず、本命題はその**強化**として位置づけ直した。
  - **命題 W は形が $d=1$ で既出**（Vallières Cor 5.7）。$d=2$ の低位項は Kataoka §4.3 が「追わない」と明記。
  - **寄与 (b)** は、可算符号化という移動自体が逆数学・構成的代数の**標準手法**だと判明。
    差分は**「等号を決定可能な水準まで降ろした」1 点**に絞られた。
  - **投稿前の宿題が 1 件残った**: **Monsky, ASPM 17 (1989) が本文未取得**（購読制限）。
    $\mu_1$ に対応する明示式が含まれている可能性があり、**投稿前に必ず読む**（notes.md に単独タスクとして記載）。
  - **「既出でないと確認した」とは書いていない**（0 件を根拠にしない。MathSciNet 未使用も明記）。
  - 呼び出し元が**引用元 PDF を自分で取得して Def 2.1 を確認**し、数値検証も再実行して一致を確認した。

## cycle 16 完了（2026-07-31）＝ 論文 001 の残務を閉じるサイクル

**残務 6 件のうち 5 件が閉じ、1 件（低位項の明示公式）は非退化ケースで閉じて限界が精密化された。
ただし本サイクル最大の収穫は「閉じた数」ではなく、こちら側の誤りが 6 件見つかって訂正されたことである。**

- **誤り 6 件**（すべて自分側。外部の指摘ではない）: 文献同定の誤り／論文本文の数式の誤り（39 例中 22 例で外れていた）／
  「PDF はテキスト変換で読めない」の誤り／**「型 II の実例がある」の誤り**（フィットの健全性検査を欠いた＝
  cycle 14 の同種事故の再発）／恒等式の符号落ちと不変量計算のバグ／**mathlib 欠落調査の偽陰性**
  （「命題 B は道具が無いので未着手」は誤りで、単に未着手だった）。
- **残っている穴（誇張しないため明記）**: 命題 G の補正項が非自明に効く例は 1 件も無く、
  $v_\ell(\kappa_X)>0$ の例も 0 件。照合できたのは実質、補正が消える場合だけ。
  $\ell\equiv1\bmod4$ の退化トーラスと一般の $d$ は未解決。投稿前の既出性確認は手つかず。
- **cycle 17 の焦点**: (1) 補正項が非自明に効く例を実際に作る (2) $\ell\equiv1\bmod4$ の退化トーラス
  (3) Lean 命題 B の逆方向（道具はあると判明したので障害なし） (4) 投稿前の既出性確認。
- **運用**: サブエージェント 2 本が規約に反し main へ直接 push した（逸脱ログ 2 件）。内容は呼び出し元が
  事後検証して正しいと確認。またアカウントのセッション上限で 2 度サブエージェントが全滅したが、
  **未コミットの部分成果は worktree に残るので、その場で再開すれば失われない**。

### 以下、各 step の詳細


cycle 15 のユーザー判断点（002 の昇格）は承認済みで論文 001 は執筆済みなので、cycle 16 は新規探索ではなく
**論文 001 が自分で挙げた残務**（`outputs/papers/001_R_Lambda_duality/notes.md` の未完了作業・未解決リスク）を
一次情報で閉じるサイクルとした。step 列は `docs/tasks/auto-loop-state.md`。

- **step 3 done: 低位項と退化塔を詰めた**（`outputs/reports/cycle16_T3_lower_order_and_degeneracy.md`）。本文へ**命題 G**。
  **(G1)** 非退化 $d=2$ 塔なら漸近形の**全係数**が $D$ の係数からの有限計算で決まる（塔の値 $\kappa_n$ を使わない）。
  **(G2)** 退化点の**計数**が決まった: $|\mathrm{Band}_n|=z_H(\ell^{2n}-1)/(\ell+1)$、割合は $n$ に依らず一定。
  **残る未解決は「個数」ではなく「退化方向の上での付値のずれ」**である。
  **(G3)** 主対象の $\ell=2$ トーラス塔は**完全に解けた**（値は DuBose–Vallières 既出なので新規性は主張しない）。
  - **敵対的レビューで自分の誤りを 3 件検出・訂正した。** とくに **「型 II の実例がある」が誤り**だった:
    5 点から 5 係数を解いた「解」を健全性検査なしに採用しており、14 件中 6 件は係数が非整数で
    そもそも形が当てはまっていなかった。**cycle 14 の「フィットは証明ではない」事故が形を変えて再発**している。
  - **「破れ 0 件」に隠れていた穴も明記した**: 補正項 $\Delta$ が非自明に効く例 0 件、$v_\ell(\kappa_X)>0$ の例 0 件。
    照合できたのは実質 $\Delta=0$ の場合だけである。$\ell\equiv1\bmod4$ の退化トーラスは未確定。
  - **運用上の逸脱**: step 4 と同じく main へ直接 push した（逸脱ログ参照）。呼び出し元が sage 3 本を再実行して検証。
- **step 4 done: 参考文献を整備し、Lean の到達範囲を広げた**（`outputs/reports/cycle16_ops_bib_and_lean.md`）。
  refs.bib を 16 エントリで整備（arXiv/zbMATH/Crossref の API と取得済み PDF で一次確認。推測で埋めた項目なし。
  各 note に「本文のどこまで読んだか」を明記）。Lean は**命題 C の整除方向を完了**（等号＝Wall 型は一般に偽なので対象外）、
  **命題 B は部分的**、命題 N・T・W は未着手。ビルド 8663 jobs 成功・**46 定理が sorryAx 非依存**。
  - **自分の過去の記述の誤りを 2 件是正した**。旧 mathlib 欠落調査が**キャメルケース連結語の内容 grep だけ**で
    偽陰性を出しており、`WeierstrassPreparation` は「内容 grep 0 件だがファイルは実在」だった。
    これに依拠した「**命題 B は mathlib に重複度の API が無いので未着手**」は**誤り**で、必要な API
    （`rootMultiplicity` 等）は実在する。未形式化なのは欠落ではなく単に未着手だった。
    調査スクリプトを 3 段方式（連結語の内容／語幹の内容／**ファイル名**）へ是正し、
    「(2)(3) がともに 0 のときだけ『無い』と書く」規約にした。
  - **運用上の逸脱**: このサブエージェントは規約に反し **main へ直接 push** した（逸脱ログに記録済み）。
    内容は正しかったので revert せず、**呼び出し元が事後に `lake build` と `check-no-sorry.sh` を再実行して検証**した。
    以後サブエージェントへの指示では main への push を**禁止と明記**する。
- **step 1 done: 原論文本文を取得し、誤りを 2 件見つけて直した**（`outputs/reports/cycle16_T1_monsky_primary_sources.md`）。
  GDZ の IIIF で Math. Ann. 255 (1981) のページ画像を直読して **Monsky / Cuoco–Monsky の原典を確認**
  （DigiZeitschriften は 2025-12-31 に終了、EuDML は 403。GDZ が唯一の経路）。**Kataoka の引用は原典と完全一致**（9 項目、ずれ 0）。
  - **(誤り 1) 本プロジェクトの文献同定が誤っていた**。Theorem 5.6 の出典は Monsky *On p-adic power series*
    （Math. Ann. 255(2), 217–227）で、cycle 15 以来そう思い込んでいた *Some invariants of $\mathbb{Z}_p^d$-extensions*
    （同巻 229–233）**ではない**（後者には §5 も Thm 5.6 も無いことを全文 5 ページで確認）。cycle 15 レポートに訂正を追記。
  - **(誤り 2) 論文 001 本文の数式が誤っていた**。全域木数のオフセットの $-\mathrm{ord}_p(\#V_X)$ は不要で、
    $\#V_X$ は相殺する（$\chi=1$ 成分が与えるのは $\kappa_X$ ではなく $\kappa_X\cdot\#V_X$）。
    Kataoka Prop 4.4 原文・自前導出・厳密整数計算（$d=1,2$ の 39 例中 **22 例で現行式が不一致**）の 3 経路が一致して否定。
  - 「Kataoka の PDF はテキスト変換で読めない」（cycle 15）も誤りで、`pdftotext -layout` で読める。
  - **呼び出し元が GDZ の IIIF マニフェストを自分で取得し、Thm 5.6 のページが「On p-Adic Power Series」の
    canvas 範囲に入ることを独立に確認した**（サブエージェントの主張を鵜呑みにしていない）。sage も再実行して一致確認。
- **step 2 done: $\lambda=l_0(f)$ の計算可能性が解消した**（論文 001 の残る未解決点のうち最も重いもの）。
  `outputs/reports/cycle16_T1_lambda_l0_computability.md`、本文へ**命題 F**（`paper_prop_F`）として追加。
  **(F1)** $P$ が Laurent 多項式なら $l_0$ は $\mathbb{F}_p$ と $\mathbb{Z}^d$ 上の**有限手続きで計算できる**
  （$d$ 任意・非退化性不要・ℝ 脱出なし）。cycle 15 が有限化を諦めたのは素イデアルの添字集合
  $\mathbb{P}^{d-1}(\mathbb{Z}_p)$ が非可算だからだったが、**Laurent 多項式を割りうるのは有理方向だけ**で、
  候補は台の差の原始方向（有限個）に潰れる。**(F2)** 一方、一般の $\mathbb{Z}_p[[\Gamma]]$ の元では
  $d\ge2$ のとき $m_0=0$ の約束の下でも判定は**決定不能**（停止問題へ還元）。
  **境界は $d$ ではなく台の有限性にある**（本プロジェクトの対象はすべて決定可能側）。$\mu$ も同型の境界。
  検証 `sagemath/check/cycle16_T1_lambda_l0/`（4 通りの独立実装）。**呼び出し元が sage を再実行し、
  サブエージェントのログと完全一致することを確認**した。新規性は主張しない（対応する文献命題は未特定）。

## 完了（2026-07-31）: 救済PR #23 の残余 2 点を既存レポートへ追記（ファイルは救わない）

`docs/salvage-audit-2026-07-31.md` の「PR #23」節の判定に従い、ブランチ
`worktree-fuzzy-petting-bengio` からは**ファイルを 1 つも取り込まず**、有効だった 2 事実だけを
既存レポートへ追記した（ブランチの証明経路 $m_L$/終結式/$\mathbb{F}_2[x]$・Lemma 1–6 は持ち込まない。
`cycle14_T1_proposition_T_generalization.md` の定理 D との整合を壊さないため）。

- **偶 $L$ の観察 T′**: `outputs/reports/cycle14_T3_Zl2_tower_criterion.md` §9.2 に式 $(9.1')$
  $v_2(\tau(L))=(2s+4)L-(6s+1)$（$s=v_2(L)$）を追記。$(9.1)$（$L=2^n$ の 7 点）を特殊化として含む。
  **証明ではなく数値観察**である旨を明記。ブランチの主張は鵜呑みにせず自分で再現し、
  **$L=2,4,\dots,160$ の全偶数 80 例**（ブランチの $L\le128$/64 例より広い）で不一致 0 を確認した。
  計算は `sagemath/check/cycle13_T1_tau_v2/tau_v2_verify.sage` の (6) に追加（終結式経路・厳密整数）。
- **文献確認**: `outputs/reports/cycle13_T1_observation_T_settlement.md` に §5.1 を追加。
  OEIS A212800 の raw text 全文（`#23 Feb 16 2025`）と arXiv:1711.00175 の ar5iv 本文を
  **本セッションで自分で取得**し、「2 進付値も $\tau=L^2R^4$ 型分解も無い」「1 次元 circulant のみ、
  $p$ は素点でなく偶奇で決まる自然数、$p$ 進付値の議論なし」を確認。
  arXiv:1312.4389 は ar5iv 版が無く**本文未確認のまま**（虚偽の確認済み宣言をしない）。
  ついでに同スクリプト (7) で $\tau(n)$ と A212800 $a(2..11)$ の厳密一致（10/10）を確認し、
  本 report の $\tau$ が OEIS と同じ量（$L=2$ の多重辺規約も同じ）であることを固定した。
- 検証: `node sagemath/tools/verify-check-linkage.ts` exit 0（孤立 7 件は追記前と同一で増減なし）。

## 完了（2026-07-27）: **paper-plan 002 を論文 001 として書き上げた（4 ゴールすべて達成）**

依頼者の承認（2026-07-26）を受け、`outputs/papers/001_R_Lambda_duality/` へ昇格し論文を執筆した。
**承認に伴い「Lean 形式検証は含めない」という方針は撤回**され、Lean を構成要素に含めた。

- **(1) 昇格と執筆**: 昇格手順どおり実施し、承認日・範囲・方針変更を 002 冒頭の「昇格の記録」に残した。
  本文は `structured-latex/content/001_intro.ts` 〜 `007_asymmetry_scope.ts` の 7 章。
  **再框であることを本文冒頭と第 8 章で明示**し、**残る未解決点 3 つを中核命題 D の限界として明記**した。
  新規性はどの主張についても主張していない。
- **(2) 構造化テキストへの移行**: Ising 側の TypeScript 実装を土台に導入。**共有ライブラリには切り出さず複製**
  （別セッション作業中の Ising 側を壊さないため。判断根拠は `docs/structured-latex-decision.md`）。
  本プロジェクト固有として **`habitat` / `realEscape` / `verification` / `lean` を型と実行時で強制**。
  可算な住処に `realEscape` を書くと型エラー、非可算で書かないと型エラー、可算宣言のブロックに ℝ/ℂ が
  現れると実行時検証が落ちる。**執筆中この検査が実際に 2 件の不整合を検出した。**
  Typst は `_old/typst/` へ退避済み（`main.typ` 17 行に定理環境 0 件、`parts/` は空）。
- **(3) 検証との紐づけ**: `sagemath/tools/verify-check-linkage.ts` を新規作成。
  `verification` の実在・規約適合、孤立した検証の検出、`lean` 定理名の実在を機械検証する。
  **27 件中 20 件を論文の主張へ紐づけ**、残り 7 件は別企画（paper-plan 001）や T2 トラックの材料なので
  無理に紐づけず理由を `outputs/papers/001_R_Lambda_duality/computations/README.md` に記録した。
  **このツールが実際に、私が書いた仮の Lean 定理名 4 件が実物と食い違っていることを検出した**（修正済み）。
- **(4) Lean 形式検証**: `integrable-lattice/lean/`（mathlib4 v4.32.1、Ising 側と同じ固定）。
  **命題 A・L・V を完了、命題 C は部分的（代数的核まで）**、命題 B・N・T・W は未着手。
  **自分でビルドと `check-no-sorry.sh` を実行して確認**: 8661 jobs ビルド成功、
  全 22 定理が `[propext, Classical.choice, Quot.sound]` のみに依存（**sorryAx 依存 0**）。
  未着手の理由は一次情報で特定済み: **mathlib に Newton 多角形も Kirchhoff の matrix-tree 定理も無い**
  （私自身の grep でも `newtonPolygon` / `Kirchhoff` / `matrixTree` / `numSpanningTrees` すべて 0 ファイルを確認）。
  Weierstrass 準備定理は**ある**ので、命題 W の障害は準備定理ではなく岩澤型漸近と matrix-tree の側である。

### 事故と是正（2026-07-26）

cycle 15 の commit `4e15577` で、編集スクリプトが `index()` による splice を使い、探索文字列が
ヘッダの参照文にも一致したため **002 の §1〜§8 を消したまま commit・push していた**（294 行 → 51 行）。
直前の正常版から復元し、出現回数を検査する置換で再適用した。再発防止策は
`docs/tasks/auto-loop-state.md` の逸脱ログに記録。**編集後の成果物を確認せずコミットしたのが原因。**


## 完了（2026-07-27）: 構造化テキストに最終成果物の生成器（LaTeX/PDF）を足した

**論文 001 が content から PDF として出るようになった（10 ページ）。** 本文は担当セッションの執筆物で、
こちらはツール側だけを担当した（数学的判断はしていない）。

- **生成器を移植**: `tools/build-latex.ts` / `latex-escape.ts` / `verify-no-notes-in-output.ts` を
  Ising 側から移植。本プロジェクト固有として、**住処（`habitat`）と ℝ 脱出（`realEscape`）を PDF にも印字**し、
  見出し level 1 を章（`\section`）へ写す。`npm run build:tex` / `build:pdf`。
- **「ビルドは通るのに PDF 上で内容が失われる」不具合を 3 件検出して塞いだ**（いずれも content は不変）:
  (1) 数式中の ★ が欧文フォントに無く無言で消えていた（和文フォントの箱へ置換）。
  (2) 長いパスの `$\texttt{...}$` が改行できず版面から 93pt はみ出していた（`\path{}` で組む）。
  (3) ℚ̄ が結合マクロンを落として ℚ に化けていた（合成文字を先に処理し、未対応の結合文字はビルドを落とす）。
- **複製が腐らない仕組み**: `tools/verify-shared-tools-in-sync.ts`（`npm run check` に組込み）。
  土台 4 ファイル（426 行）が複製元とバイト一致し、固有化した 6 ファイルが一致して**いない**ことを検査する。
  共有ライブラリにしなかった判断の根拠（実測差分つき）は [docs/structured-latex-decision.md](docs/structured-latex-decision.md)。
- **地の文の Unicode ℝ/ℂ が可算宣言の検査を素通りしていた**のを塞いだ（数式しか見ていなかった）。
- **Typst**: `_old/typst/` に退避済みで追跡対象に `.typ` は 0 件。`main.typ`（17 行）に定理環境は 0 件、
  `parts/` は `.gitkeep` のみ。移行漏れは原理的に起こらないので `verify-no-lost-proofs.ts` は移植しない。
- **重複作業の整理**: ツール先行の指示に従い企画書の確定命題を暫定移設していたが、担当セッションが
  同時期に本文を執筆したため、**暫定移設は破棄して担当セッションの本文を正とした**。
- **Ising 側は 1 ファイルも変更していない**（278 ブロック・PDF 236 ページで通過を確認済み）。

**実測**: ブロック 30・ラベル 24・相互参照 17 すべて解決・SageMath 検証 24 件すべて実在・Lean 定理 5 件・
PDF 10 ページ・未解決参照 0・組めない文字 0・版面外へ出た行 0。

## cycle 15 完了（2026-07-26）＝ **002 が昇格提案済へ。ユーザー承認待ち**

**目標達成。paper-plan 002（ℝ/Λ 双対）は G1–G6 すべて `達成` となり、状態が `据え置き` → `昇格提案済`。
残る条件は「ユーザーが論文として書くと承認すること」の 1 点のみ。**

- **step 1+2（一本の発見で (a)(b) が同時に閉じた）**: `outputs/reports/cycle15_T1_kataoka_and_general_P.md`。
  Kataoka arXiv:2606.03579 の**本文を取得**（PDF をページ単位で pp.1–8 直読。HTML 版は 404）。
  **(b)**: $\mu=m_0(f)$ は Definition 2.2（＝Cuoco–Monsky Def 1.1/1.2）で「$f$ を割り切る $p$ の最大冪」と**定義**され、
  Theorem 2.3（＝Cuoco–Monsky Thm 1.7）が**等号**を与える。cycle 14 の上界方向は外部定理を引けば済む。
  **(a)**: Theorem 2.1（＝**Monsky Thm 5.6**）は**グラフ限定でない**。任意の $f\in\mathbb{Z}_p[[\Gamma]]$ の定理で、
  $a^{\mathrm{red}}_{p^n}=\prod_{\chi(f)\neq0}\chi(f)$ がちょうどその左辺 ⟹ **一般の $P$ に直接適用できる**。
  cycle 13 step 1 の「文献に特定できなかった」は**探索がグラフ文献に偏った誤り**だった。
  敵対的レビューで**誤り2件を検出・訂正**（$l_0=0$⟺非退化条件は偽で一方向のみ／簡約積と $\kappa$ は $-dn$ ずれる）。
  **$\lambda=l_0$ の計算可能性は未確立**（$\mathbb{F}_p$ 上のレシピは上限のみ。反例 $P=z+w^2-2w$, $p=3$）。
- **step 3**: `outputs/reports/cycle15_T3_tau_d3_structure.md`。$d=3,p=2$ の追加解を
  型 I（部分トーラス）／型 II（$\{u,\omega u,\omega^2u\}$）／型 III（$15\mid L$ の 48 個）に分類し、
  $v_2(\tau_3(L))=6(L-1)+8(L-3)[3\mid L]+144[15\mid L]+(\text{散発})$ を証明。
  cycle 14 が散発としていた $L=9,15,21,27$ が説明され、真に散発なのは $L=17$ のみに。独立検算で $L\le15$ 全一致。
- **新規性はいずれも主張しない**（既知定理の特定と適用であって自前証明ではない）。
- **次にやること = ユーザー判断**: 002 を `outputs/papers/` へ昇格させるか。判断材料 4 点は 002 の「昇格判断」節に明示
  （新規性が無い／残る未解決点 3 つ＝$\lambda$ の計算可能性・$\lambda_i,\mu_i$ の明示公式・消える $\chi$ が増える $P$／
  Lean 非対象／投稿前に寄与 (b) の逆数学既出性の専門家確認）。**cycle 16 の step 列は承認後に起こす。**

## cycle 14 完了（2026-07-26, 目標=002 の G1 解消。未達だが理由を2点へ絞った）

- **T1 命題 V（初等証明）**: `outputs/reports/cycle14_T1_vp_growth_two_variable.md`。
  $a_{p^n}\equiv P(1,\dots,1)^{p^{dn}}\pmod p$ から **$v_p(a_{p^n})>0\iff p\mid P(1,\dots,1)$**。
  $\bmod p$ で $z^{p^n}-1=(z-1)^{p^n}$ となり終結式が潰れるだけ。$\mathbb{Q}_p$ も代数的整数論も不使用。
  併せて **cycle 13 の content 判定式が $d=2$ で崩れる反例**（content=1 でも増大）と
  **レジームの三分法**（$p\nmid P(1,1)$ 自明／$p\mid P(1,1)\ne0$ 非自明／$P(1,1)=0$ トーラス零点）を確定。
  敵対的レビューで**誤り3件を検出・訂正**（Deninger との包含関係、4段フィットの数値的誤り、$X^2$ 係数の未証明断定）。
- **T3 $(★_2)$ と命題 W**: 起動事故で**2経路が独立に走り同じ境界に到達**
  （`cycle14_T3_two_variable_criterion.md` 第1経路 / `cycle14_T3_Zl2_tower_criterion.md` 第2経路）。
  下界 $a\ge v_\ell(\mathrm{content})$ は自証明、**上界は自前では証明できない**（外部定理に依拠）。
  第1経路は非退化条件下で**完全な閉形式** $\mathrm{ord}_\ell(\kappa_n)=\mu\ell^{2n}+\frac{k(\ell+1)}{\ell-1}\ell^n-2n+\nu$（命題 W）。
  $L\times L$ トーラスの $\ell=3$ 塔で $\mathrm{ord}_3(\tau(3^n))=4\cdot3^n-2n-4$（独立検算、$n=0,1,2$ で 0,6,28）。$\ell=2$ は退化で射程外。
  **文献 Kataoka arXiv:2606.03579 を発見**（$\mathbb{Z}_p^d$ グラフ被覆の主要係数の明示公式）。
- **T1 命題 T の一般化**: `outputs/reports/cycle14_T1_proposition_T_generalization.md`。
  定理 A–F を証明（判定条件／次元の漸化式／$L$ 奇なら任意の $d$ で $4\mid v_p$／命題 T の10行証明／
  部分トーラス下界 $\ge L^{\lfloor d/p\rfloor}-1$／$p=2,d=2$ が特別な理由＝$\bmod2$ で零点集合が2部分トーラスの合併）。
  **負の結果も確定**: 奇素数に clean な法則は無い（$L=13,p=5$ 等）、$d\ge3$ で等号不成立、$c(L^{d-1}-1)$ 型は誤り。
- **新規性はいずれも主張しない**（命題 V は folklore の可能性、命題 W は Kataoka が同種公式、定理 A–F は本文未確認）。
- **002 の G1 は依然未達**。残るのは **(a) グラフのラプラシアンでない一般の $P$ で $p\mid P(1,1)$ の増大の完全な形、
  (b) $\ell^{2n}$ 係数の上界方向（Kataoka 本文未取得）** の2点のみ。
- cycle15 step列: Kataoka 本文取得で (b) を閉じる / 一般の $P$ で (a) / $d=3,p=2$ の追加解の分類。

## cycle 13 完了（2026-07-26, 証明のサイクル）

- **T1 step1（誤りの検出＝最大の成果）**: `outputs/reports/cycle13_T1_padic_entropy_generality.md`。
  002 が既知として並置していた「**$p$ 進エントロピー ＝ $p$ 進 Mahler 測度 ＝ 岩澤 $\mu_p$**」は**誤り**。
  $\hbar_p,m_p$ は岩澤対数（$\log_p p=0$）で定義され**付値部分を捨てる**ので $v_p$ の増大を測らない。
  定義域もほぼ排他的（定義できる条件 $P=ct^\nu(1+pg)$ の下では $v_p(a_L)=L^d v_p(c)$ と自明化）。
  正しい量は Ueki の $\mathrm M_p$。**($\infty$) 側の一般性は文献本文で確定**（LSW Thm 3.1/7.1、LSV Thm 1.2/1.3 の3段）。002 を訂正した。
- **T3 step2（証明）**: `outputs/reports/cycle13_T3_mu_content_criterion_proof.md`。
  cycle 12 で数値照合のみだった $(★)$ と判定式 $(☆)$ を**証明**。さらに cycle 12 が既知理論に依拠していた
  **岩澤型漸近そのものを証明**し $\lambda=\lambda_{\mathrm W}-1\ge1$ も決定。$(★)$ は連結性の仮定なしの形へ強化。
  **射程の限界も特定**: $\ell\nmid N$ の段は content が支配しない（反例6件）、**$d\ge2$ の塔は対象外
  ＝$L\times L$ トーラスにはそのまま適用できない**。新規性は主張しない（McGown–Vallières III Thm 6.1 の言い換え）。
  - **2026-07-31 追記（救済PR #25 の残余を統合）**: 同じ主張を独立に証明していた並行成果から、
    main に無かった部分だけを**追記**した（既存節は 1 つも削っていない）。
    (1) **命題 7.3**: $\mu_\ell>0\iff\det(L\bmod\ell)=0$ over $\mathbb{F}_\ell(z)$（$d=1$ の有限判定）。
    (2) **命題 7.4**: bouquet で $\mathrm{content}_z(D)=\gcd_a m_a$ の**証明**（cycle 12 は 125 件の数値観察のみだった）。
    (3) **命題 9.5**: $p\neq\ell$ での下界 $v_p(\kappa_n)\ge\mu_p\ell^n+(v_p(\kappa_0)-\mu_p)$。
        **$v_p(R_n)$ の有界性は未解決**で、$0$ から正へ増えてから止まる実例が 2 件ある（例5 $\ell=2,p=5$ で $0,0,2,2,2$）。
    (4) **§8.1/§8.2 で出典を特定**: [E] Corollary 5.6 の $P=\det M$ 代入で $Q(T)=\det L(1+T)$ と同定でき、
        「Corollary 5.6 の $Q(T)$ の定義は未確認」という §10 の宣言が**解消**した。$(★)$ の出典は
        Vallières 論文 式(7)、および Hammer–Mattman–Sands–Vallières Thm 2.11 / Cor 3.5。
        **ただしこの本文取得は並行成果が行ったもので、本セッションでは PDF を再取得していない**（§8.1 に明記）。
    (5) **§13** で使った体を棚卸しし、$\ell$ 進脱出が Weierstrass 準備定理の 1 点に隔離されることを整理。
    検証は `sagemath/check/cycle13_T3_criterion_proof/` に `lib_voltage.sage` ＋
    `verify_star.sage`（D 節）＋ `verify_criterion.sage`（F・G 節）を追加し、**自分で sage を実行して FAIL 0**。
    救済元の A/B/C/E 節は `proof_steps.sage` の Step 2〜6 と重複するので持ち込まなかった（判断は同 README に記録）。
- **T1 step3（証明）**: `outputs/reports/cycle13_T1_observation_T_settlement.md`。
  **観察 T（奇 $L$ で $v_2(\tau(L))=2(L-1)$）を証明**し、002 の未証明観察から確定部分命題「命題 T」へ昇格。
  骨子: $\tau(L)=\prod_j(r_j^L-1)^2/r_j^L$ へ分解 → 2 の不分岐性 → Newton 多角形で $v(m_j)=1$ → LTE 段。
  敵対的レビューで反証されず、独立経路（終結式）で合成奇数 $9,15,21,25,27,33,35$ と $L=19$ まで確認。新規性は主張しない。
- **002 の状態**: G1 は依然**未達**だが理由が正確になった。残るボトルネックは**2 変数・$\mathbb{Z}_p^2$ 塔での $v_p$ 増大則**の1点のみ。
- cycle14 step列: T3 判定式の $\mathbb{Z}_\ell^2$-塔への拡張 / T1 2変数の $v_p$ 増大則 / T1 命題 T の一般化。

## cycle 12 完了（2026-07-26, 3トラック並走）

- **T1**: 11 cycle の蓄積を統合した paper-plan `outputs/paper-plans/002_R_Lambda_duality.md`（ℝ/Λ 双対）。既知と寄与を表で分離、確定部分命題 A/B/C/N/L と未証明の観察 T を分節。**据え置き**（G1 未達＝双対命題 D の一般性が未確定）。
- **T2→T1 統合（cycle 11 の方針判断1を実行）**: `sagemath/check/cycle12_T2_onsager_qqbar/`。Onsager 解の有限 L 構造を $\mathbb{Z}[x]$・円分体・`QQbar`/`AA` 上の**記号的等号**で厳密検証（分散関係・±γ ペアリング・臨界条件 $(x^2+2x-1)^2$・KW 双対不変性）。**ℝ 脱出は 2 点に隔離**。新厳密解は無い＝既知の書き換えと明記。統合方針は機能した。
- **T3（白眉）**: `sagemath/check/cycle12_T3_nonzero_mu_p/`。「$\mu_p$ は generic に 0」の**外側**を明示構成。判定式 **$\mu_\ell=v_\ell(\mathrm{content}_z\det L(z))$**（決定可能）を得て、$\mu_2=2\,\&\,\mu_3=1$（同一塔）/$\mu_2=4$/$\mu_{23}=1$/$\mu_3=2$/$\mu_5=1$ を matrix-tree 直接計算で独立検証。bouquet では自明例に限り、2頂点以上の行列式の content での相殺が源。**新規性は文献本文を取得できず未確認（主張しない）**。
- **運用**: 昇格ゲート G1–G6 新設、選別基準 (iv) に**メタ軸**（可算化・決定可能性・形式検証可能性）を明文化、検証3ディレクトリの README 補完。
- cycle13 step列: T1 p 進エントロピーの一般性特定（002 の G1）/ T3 判定式 $(☆)$ の証明 / T1 観察 T の決着。

## 昇格基準を文書化（2026-07-26）

- `outputs/paper-plans/README.md` を新設。**paper-plans → papers の昇格ゲート G1–G6 ＋ユーザー承認の最終ゲート**を定義。判定語彙（達成/未達/評価不能/非該当）、G1 を他ゲートの前提とする規則、状態語彙、昇格手順、昇格後にゲートが崩れた場合の扱いを含む。
- G3 は本プロジェクトの実運用規約（`sagemath/check/<dir>/` に `README.md` ＋ `.out` 実行ログ）に合わせた。Ising プロジェクト側の `overview.md` / `verify-check-linkage.mjs` / `lean/scripts/` は integrable-lattice に**存在しない**ので要求しない。
- G6 は過去サイクルの実際の誤り（cycle 4→5→6 の代理指標による構造判定、cycle 5→6 の 0/43→572件で 4.5% 反例、cycle 10 のスケール偶然一致）を再発防止条項として明文化。
- `001_finite_N_decidable_unsolved.md` に G1–G6 判定表を追加。現状**全ゲート未達 ＋ 最終ゲート未取得＝据え置き**。旧「昇格条件（cycle 1 総括時点）」の記述は削除せず保存。
- レビューを5周回して一次情報と突合（存在しないツール参照・MEMORY 誤引用・`paper_potential: high` は1件も無い等を是正）。

## 解決済み: gap map / candidates 再作成の依頼は撤回（2026-07-26）

- 依頼元が **140 コミット古い MEMORY.md**（削除前の cycle 0 の「完了」節）を読んで出した誤依頼だった。ユーザーが訂正し、**作らない・現行の Λ-statement プログラムを継続**で確定。正しいゴールは cycle 12 step 列の完遂。
- 以下は判断の根拠として保存する。

### 根拠

- 依頼「収集済みコーパスから `outputs/maps/001_six_vertex_dwbc_determinant_seed_map.md` を作り、unknown/needs_review から `outputs/candidates/000_seed_candidates.md` へ候補を起こす」は、**2026-06-21 にユーザー合意で全削除した cycle 0（文献分類版）の成果物そのもの**。削除コミット c7fe283、復元点 918af09。`inputs/corpus/` は空で「収集済みコーパス」は現存しない。
- 削除理由（`lambda-statement-program.md` に明記）: 文献分類（determinant か character か・境界が何か）で集めたため、梯子・四軸を使わず**可解性（文献の exact）と帰属（Λ）を混同していた**。
- 以後 cycle 1–11 は Λ-statement プログラム（3トラック）で進行。MEMORY.md 末尾の「完了」節に残る cycle 0 の記録（gap map 作成済み等）は削除前の記述で、現状と食い違う。
- **ユーザー判断（2026-07-26）: 作らない。現行の Λ-statement プログラムを継続する。** gap map 001 / candidates 000 の再作成・復元はしない。以後この依頼が再来しても、この判断を根拠に再作成しないこと。

## cycle 11 完了（2026-07-04, 3トラック並走）

- **T1**: v_2(τ(L))=2(L−1)(奇 L, L=3..19)+グラフ岩澤理論接地(全域木の ℓ 進付値=類数の岩澤と平行)=cycle6 の p 進エントロピー=岩澤 μ と同構造。`cycle10_T1_vp_law/iwasawa_graph_README.md`。
- **T2**: XXZ 2マグノン∈ℚ̄。**T2 正直整理: 新厳密解未産出=T1 重複**。真の solve は専門機構要。`cycle11_T2/`。
- **T3**: Lehmer は ℝ側固有, Λ側(岩澤 μ_p∈ℤ, Ferrero–Washington)は決定可能=双対の非対称集約。`cycle10_T3_lehmer/padic_analog_README.md`。
- **方針判断点**: T2 の扱い(1.T1 統合 / 2.特定量に深張り / 3.現状維持)。指定なければ cycle12 は 1+paper-plan 化。
- cycle12 step列: T1 双対 paper-plan / T2→T1 Ising Onsager 可算 Reframe / T3 非自明 μ_p グラフ例。

## cycle 10 完了（2026-07-03, 3トラック並走）

- **T1**: 全域木数 τ(L) の clean 法則 奇 L で v_2(τ(L))=2(L−1)(L=3..11)。一般 v_p は円分的。`cycle10_T1_vp_law/`。
- **T2**: AMP 1989 照合 — 超可積分は Ising 的 √(1+λ²−2λcosθ)(整合)。cosθ=±1/3 の運動量同定は論文本体照合が要(未)。`amp_reconcile_README.md`。
- **T3**: 自由エネルギー=Mahler 測度=エントロピー→Lehmer 問題への地図。4G/π vs Lehmer 数はスケール違いの偶然(注意)。`cycle10_T3_lehmer/`。
- cycle11 step列: T1 v_2=2(L−1) 証明 / T2 τ^(2)-model / T3 Lehmer の p 進版。

## cycle 9 完了（2026-07-01, 3トラック並走）

- **T1**: 2変数曲線=離散ラプラシアン(全域木)。ℝ側 (1/L²)logτ(L)→4G/π(既知 Catalan)一致=枠組み裏付け, Λ側=τ(L)素因数分解。`cycle9_T1_spanning_tree/`。
- **T2**: N=4 で cubic 因子(判別式621=S₃)=cubic 運動量存在 confirmed。厳密 cosθ 同定は超可積分スペクトル理論照合が要(cycle10+)。`dispersion_N4*`。
- **T3**: D-U2 Λ 側の統合命題確定 `outputs/candidates/D-U2_consolidated_proposition.md`(周期性+π(p,1)精密+上界+Newton+Wall 否定, 決定可能, Lean 仕様)。
- cycle10 step列: T1 τ(L) の v_p 則 / T2 超可積分スペクトル公式照合 / T3 Mahler-Lehmer 接続。

## cycle 8 完了（2026-06-30, 3トラック並走）

- **T1**: z−c の完結双対命題(R: f=log c=m(z−c); Λ: v_p(c^L−1)=LTE 完全形 p 奇/p=2, 決定可能・Lean decide 可)。`outputs/reports/cycle8_T1_lte_proposition.md`。
- **T2**: N=3 でも Onsager 分散 confirmed, cosθ=±1/3, deg-4 に追加運動量。`cycle7_T2_dispersion/dispersion_N3*`。
- **T3**: π(p,1)=lcm{ord(λ): p∤m_λ}(精密, rigorous, 全31例)＋等号条件＋strict 構成例。`pi_p1_refined*`。
- cycle9 step列: T1 2変数 P(z,w) 双対 / T2 N=4 cubic 運動量 / T3 Λ側周期を統合命題化(Lean 仕様)。

## cycle 7 完了（2026-06-29, 3トラック並走）

- **T1**: 双対の Λ 側の本体=全 L の LTE 構造(z−c で v_p(c^L−1)=LTE, 岩澤 μ_p generic 0)。`cycle7_T1_lte/`。
- **T2（白眉）**: カイラル Potts N=2 から Onsager 分散 ε∝√(1+λ²−2λcosθ), cosθ=±1/3 を有限 N ℚ̄ から抽出。`cycle7_T2_dispersion/`。
- **T3**: π(p,1)=lcm{固有値順序}(全25例 等号)→ D-U2 命題 A の周期に閉形上界 π(p,k)|p^{k-1}lcm{ord}。`pi_p1_closed_form*`。
- cycle8 step列: T1 LTE 命題化/Lean / T2 N=3,4 運動量 cosθ_k 抽出 / T3 π(p,1) 等号条件。

## cycle 6 完了（2026-06-28, 3トラック並走）

- **T1（大成果）**: ℝ/Λ 双対の Λ 側＝既知理論(Deninger p 進エントロピー＝Besser–Deninger p 進 Mahler 測度＝岩澤 μ_p)に接地。`cycle6_T1_padic_mahler_grounding.md`, 研究ノート更新。
- **T2（再訂正）**: Dolan–Grady で超可積分=Onsager 確定。cycle5 の「Onsager でない」撤回は過剰訂正で誤り(次数3,6 は cubic 運動量由来)。`cycle6_T2_superintegrable/`。
- **T3（仮説棄却）**: 六頂点 Wall 572件で破れ4.5%→「可積分が Wall 保護」棄却(0/43,0/91 は小標本偶然)。rigorous 上界のみ残る。`wall_large_scale*`。
- 教訓: 構造判定は Dolan–Grady で(次数でなく); 0件は有意性検定してから結論。
- cycle7 step列: T1 非自明 μ_p 例 / T2 Onsager 分散抽出 / T3 π(p,1) 閉形(Wall は棄却済)。

## cycle 5 完了（2026-06-27, 3トラック並走）

- **T1（大成果）**: ℝ/Λ 双対を最小・厳密に実証。`sagemath/check/cycle5_T1_mahler/`。同一 P の周期点数 a_L∈ℤ で (1/L²)log a_L→log m(P)(ℝ)と a_L 素因数分解=Φ_L∈Λ(Λ)。
- **T2（自己訂正）**: cycle4 の「カイラル Potts=Onsager 多重2次体」撤回（N=4,5 で非2冪因子, 一般 λ は超可積分点でない）。robust は有限 N∈ℚ̄ のみ。`sqrt_set_*`。
- **T3（統計的に正直）**: Wall は非退化でも一般不成立（Pell p=13 確定）。六頂点 0/43 は有意でない→可積分の効果未確定。`wall_nondegenerate_*`。
- cycle6 step列: T1 p 進 Mahler 同定 / T2 真の超可積分点で再検証 / T3 Wall 大規模統計。

## cycle 4 完了（2026-06-26, 3トラック並走）

- **T1**: ℝ/Λ 双対を Mahler 測度で命題化 `outputs/reports/cycle4_T1_R_Lambda_mahler.md`。ℝ側=自由エネルギー=log m(P)(既知, Ising で楕円曲線/L 函数)。Λ側=同 P の p 進 Mahler(予想)。研究ノート `docs/research/R-Lambda-duality/` 更新。
- **T2**: カイラル Potts スペクトルの Onsager/多重2次体構造を有限 N 観察(全2冪次数・全実・少数√, λ=1/2 で ℚ(√33,√57) 安定)。`sagemath/check/cycle3_T2_chiral_potts/onsager_*`。
- **T3**: Wall 等式は一般には不成立(退化+Pell p=13 で破れ)。rigorous 上界は不変。可積分での成立は退化交絡で未確定。`sagemath/check/cycle3_T3_period/wall_search*`。
- cycle 5 step 列(state): T1 スペクトル曲線 m(P) 両素点実証 / T2 √集合 N 依存則 / T3 非退化 Wall 比較。

## cycle 3 完了（2026-06-25, 3トラック並走）

- **T1**: D-U2 厳密命題化 `outputs/reports/cycle3_T1_D-U2_rigorous.md`。命題 A（min(v_p(Z_N),k) は T^N mod p^k の周期 π で最終周期, 決定可能・Lean decide 可）＋命題 B（線形傾き=Newton 多角形）。`sagemath/check/cycle3_T1_period_bound/` 全例検証。
- **T2**: 本命カイラル Potts（超可積分 ℤ_3）で有限 N スペクトル∈ℚ̄・全実・代数的（witness x²−6）。`sagemath/check/cycle3_T2_chiral_potts/`。
- **T3**: 周期を Pisano/Wall 理論に接続。`outputs/candidates/T3_wall_type_period_candidate.md`。上界 π(p,k)|p^{k-1}π(p,1)（rigorous）、Wall 等式（一般未証明）が全テスト例成立 → 候補命題。
- cycle 4 step 列（state）: T1 ℝ/Λ 双対命題化 / T2 有限 N→極限(Onsager) / T3 Wall 証明 or 反例。次発火で連続消化。

## テーマ3トラック化（2026-06-24, ユーザー合意。正典 `docs/themes.md`）

- **T1 Reframe（本流）**: 理論物理の既知結果を可算（Λ/ℚ̄）で厳密化・自動証明可能化。D-U2 等。「既知の再框」は first-class 成果。
- **T2 Solve**: 未解決模型の実際の厳密解（カタログ `outputs/maps/integrable_unsolved_catalog.md`）。
- **T3 Pure（追加）**: 道具(Λ,ℚ̄,p進,決定可能性,逆数学,形式検証)が効く基礎論・数論の未解決問題。
- 2本立て(T1,T2)主軸＋T3 随時。共通土台＝梯子＋四軸＋選別 (i)-(iv)（`lambda-statement-program.md`）。cycle 3 step 列は state 参照。
- **ℝ/Λ 双対**（D-U2 で発見: 同じ固有値集合の絶対値↔ℝ側自由エネルギー / p 進付値↔Λ側 Φ 数論）はユーザー依頼で root `docs/research/R-Lambda-duality/` に切り出し（別セッションで深掘り）。

## 収集対象の再定義（2026-06-21, ユーザー合意）

- 集める statement = **「Λ/ℚ̄ で決定可能・ℝ脱出隔離・形式検証可能」**。整理軸は決定可能性の梯子（ℕ⊂ℚ⊂Λ⊂ℚ̄ ⊂ ℝ）＋四軸（帰属／計算可能性／複雑性／可解性）。定義 `inputs/seeds/lambda-statement-program.md`、土台 `docs/discussion/対数順序群上の統計力学/`。
- 旧アプローチ（文献の exact 分類＝determinant/character で集めた cycle 0）は**全削除**。文献分類に引きずられて帰属と可解性を混同していたため。**復元点 918af09**（全 intact）／削除コミット c7fe283。
- 探索方向 A–F（A 零点∈ℚ̄ / B 臨界点代数性・双対 / C ℝ脱出隔離・自由フェルミオン / D Massieu Φ∈Λ / E 複雑性×可解性分類 / F 形式検証可能性）は **絞らず広く** 探す（ユーザー指示）。

## 自動ループ（daily）

- 手順 `docs/tasks/auto-loop-runbook.md`、状態 `docs/tasks/auto-loop-state.md`。各 step 完了ごとに点検 → main 差分 push（マージ結果を必ず報告）→ 次 step。**1発火で todo を尽きるまで連続消化**（リポジトリ CLAUDE.md「自律実行：判断を要さない限り止まらない」）。
- cron は session-only（Claude 起動中のみ・7日失効）。

## cycle 2 進捗（2026-06-24, D-U2 数論）

- 定理候補 `outputs/candidates/D-U2_vp_law_theorem_candidate.md`: 整数転送行列の Massieu Φ_N の v_p(Z_N)=μ_min(p)N+最終周期(SML 例外), μ_min=p 進 Newton 多角形。SageMath で六頂点・Potts 検証（`sagemath/check/D-U2_padic_law/`, `potts_phi/`）。ℝ/Λ 双対 λ_max↔μ_min 発見。
- **正直な総括**: 既知 p 進線形漸化理論の可積分 Φ への適用＝構造的/基礎論寄り、新厳密解でない。cycle 0-2 通して Λ 収集は「既知数学の可算再框」に流れ、新しい数学的結果は未産出。
- **cycle 3 方向はユーザー判断待ち**（state「cycle 2 総括」）: 1.基礎論ノート化 / 2.カイラル Potts 直撃 / 3.実際の厳密解に挑む別設計 / 4.撤退。私見=3 かテーマ再設定。

## cycle 1 進捗（2026-06-23, finite_N_decidable 深掘り）

- 母集団を「可積分だが極限未解決」へ refocus（カタログ `outputs/maps/integrable_unsolved_catalog.md`, McCoy/Baxter 原典）。
- SageMath 10.6 で実証（`sagemath/check/`）: XXZ・六頂点・スピン1 BT で有限 N 量が Λ/ℚ̄ 決定可能・witness、ℝ脱出は極限のみ。六頂点 Φ に非自明な数論構造（v₂(Z_N)=N+2 等, D-U2）。
- paper-plan `outputs/paper-plans/001_finite_N_decidable_unsolved.md`。Lean は環境未導入でブロック（仕様確定済）。
- **cycle 1 総括＝state「cycle 1 総括」**。成果は基礎論・形式検証寄与（可積分の新定理ではない）。cycle 2 方向は**ユーザー判断待ち**（基礎論寄与に価値を置くか／カイラル Potts 直撃／D-U2 数論定理化／撤退）。

## cycle 0 完了（2026-06-22, Λ-statement 版・A-F 広い探索）

- A-F 全方向を広く浅く1周。maps/candidates `outputs/{maps,candidates}/{A,B,C,D,E,F}_*`、観察 `outputs/reports/cycle0_lambda_observation.md`。
- **横断観察**: A-F が「有限・離散・可積分 ⇒ 全量が Λ/ℚ̄ で決定可能・形式検証可能、相転移=ℝ脱出 N→∞ 一点」に収束。
- **cycle 1 方向確定**: 束 `finite_N_decidable`（零点 A・臨界点 B・スペクトル C・Massieu Φ D を Λ/ℚ̄ 決定可能・witness 付きで確立、F で形式検証）。深掘りサイクルなので sagemath QQbar・Lean を投下。step 列は state の「cycle 1 step 列」（次回 verify:A-U1_resolved_check から）。

## 未解決

### Harvest policy

- 論文コーパス取得を arXiv source 優先にするか、metadata/abstract 優先にするか。

### Classification / verification policy

- 初期分類を rule-based にするか、LLM-assisted にするか。
- 「未解決」の判定をどこまで自動化するか。

### Tooling

- `integrable-lattice/skills/` を Codex の自動発見対象にするか、プロジェクトローカル運用に留めるか。

## 完了

### Project setup

- プロジェクト雛形を作成した。
- `outputs/papers/` を最終論文の置き場として追加した。
- `integrable-lattice-` prefix のプロジェクト専用 skill を7つ作成した。

### Seeds / schema

- `inputs/seeds/` に seed taxonomy と初期クエリを追加した。
- `docs/schemas.md` に候補ステートメントの最小スキーマを追加した。
- `inputs/seeds/canonical-papers.md` を追加し、MVPの代表文献アンカーを seed 化した。
- `inputs/seeds/canonical-papers.md` に mvp_role / operation_type / gap_axes と追加アンカーを入れて補強した。
- 補強後の subagent review で「harvestへ進む」と判定され、minor 指摘の first-pass axis を反映した。

### Harvest

- `six_vertex_dwbc_determinant` の first-pass query log と curated corpus を追加した。

### Gap map

- 案A（curated corpus 内の Immediate Map Hints を分類成果物として扱い、02_extract/03_classify の独立成果物を作らず直接 gap map）で `outputs/maps/001_six_vertex_dwbc_determinant_seed_map.md` を作成した。
- known 7 / probably_known 1 / needs_review 4 / unknown 6（U1–U6）でセル化。

### Candidate generation（05_generate, first pass）

- gap map の unknown 最有力セル U1 / U3 を `outputs/candidates/000_seed_candidates.md` に StatementCandidate 形式で起こした。
- U1-corr（partial DWBC 境界1点相関 det）/ U1-efp（partial DWBC EFP det）/ U3-corr（half-turn 一般パラメータ境界相関 det）の3件。いずれも known anchor 付き・小サイズ検証可能。
