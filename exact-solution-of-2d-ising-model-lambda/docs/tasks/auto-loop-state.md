# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地
- **2026-08-19 の tick 454 は、todo が空で七点の観察から本文へ昇格できる命題候補も無いため前進せず、姉妹側の $\det A(\tilde\theta_\mu)=1$ と固有値の積の証明で散文に畳まれていた $\gamma_1(\theta)^2=1+r^2$ の導出を主張の左辺から始まる三段の鎖へ開いた。**
  前進前レビューでは tick 453 のコミット `ee5cf891` を差分で突き合わせ、$\gamma_2(-\tilde\theta_\mu)=-\overline{\gamma_2(\tilde\theta_\mu)}$ の一段の鎖と補助計算・(5) の終端の行末根拠が、元の内容と `euler_formula_cos_sin`・`relation_of_gamma_2` の参照を失っていないことを確認した。「何も言っていない主張」の候補を四則・分母・移項・約分の記述から検索し、いずれも行末根拠内の記述で独立ブロックの削除対象は無かった。本文末尾（命題候補待ちの 1 項目のみ）とセクション表（todo 空）も一致している。修正なし。式変形統一では、姉妹側 `015_A_theta_tilde_diagonalization.ts` の「$\det A(\tilde\theta_\mu)=1$ と固有値の積」（`det_A_theta_tilde`）で、Step 3 の展開 2 式と Step 4 の鎖の先頭行に行末根拠を補い、末尾で散文に畳まれていた $\gamma_1(\theta)^2=1+r^2$ の導出を `relation_of_gamma_2_theta_tilde` (2) と Step 5 を行末根拠で引く三段の鎖へ開いた（内容・参照は不変）。Lambda 側 check 516 ブロック・linkage 296 件・Lean 9520 jobs・sorry 非依存 1459 件・PDF 280 ページ、姉妹側 SageMath 対象検算（check_04）・check 300 ブロック・PDF 332 ページ通過。
- **2026-08-19 の tick 453 は、todo が空で七点の観察から本文へ昇格できる命題候補も無いため前進せず、姉妹側の $\gamma_2(-\tilde\theta_\mu)=-\overline{\gamma_2(\tilde\theta_\mu)}$ の証明で散文に置かれていた符号反転を主張の左辺から始まる式変形へ移した。**
  前進前レビューでは tick 452 のコミット `436a335f` を差分で突き合わせ、$P_{21}$ の補助等式と六段の鎖が元の内容と `theorem_exp_product`・`euler_formula_cos_sin`・`duality_c2_star_eq_s2_star_c2` の参照を失っていないことを確認した。「何も言っていない主張」の候補を四則・分母・移項・約分の記述から検索し、独立ブロックはいずれも well-defined 性・住処・非零性または後続の反復利用を担うため削除対象は無かった。本文末尾（命題候補待ちの 1 項目のみ）とセクション表（todo 空）も一致している。修正なし。式変形統一では、姉妹側 `015_A_theta_tilde_diagonalization.ts` の「$\gamma_2(-\tilde\theta_\mu)=-\overline{\gamma_2(\tilde\theta_\mu)}$ とその帰結」（`relation_of_gamma_2_theta_tilde`）で、補助的な共役計算のあと散文で行っていた符号反転を主張 (1) の左辺から始まる一段の鎖へ移し、補助計算と (5) の終端にも行末根拠を補った（内容・参照は不変）。Lambda 側 check 516 ブロック・linkage 296 件・Lean 9520 jobs・sorry 非依存 1459 件・PDF 280 ページ、姉妹側 SageMath 対象検算・check 300 ブロック・PDF 332 ページ通過。
- **2026-08-19 の tick 452 は、todo が空で七点の観察から本文へ昇格できる命題候補も無いため前進せず、姉妹側の $A(\theta)$ の因数分解の証明で「Step 4 とまったく同じ計算」に畳まれていた $P_{21}$ の導出を一続きの鎖へ開いた。**
  前進前レビューでは tick 451 のコミット `ac27ef15` を差分で突き合わせ、転送行列作用の結論の二段の鎖が元の内容と `def_B1_theta_B2`・`factorization_of_A_theta_general` の参照を失っておらず、$\tilde\theta$ は証明冒頭の略記宣言 $\tilde\theta:=\tilde\theta_\mu$ に従っていることを確認した。「何も言っていない主張」の候補を四則・分母・移項・約分の記述から検索し、独立ブロックの削除対象は無かった。本文末尾（命題候補待ちの 1 項目のみ）とセクション表（todo 空）も一致している。修正なし。式変形統一では、姉妹側 `014_even_sector_T_action.ts` の「$B_1(\theta)B_2B_1(\theta)=A(\theta)$」（`factorization_of_A_theta_general`）の Step 5 で、補助等式の導出と $P_{21}$ の整理が「Step 4 とまったく同じ計算（$\theta\to-\theta$）」の一行に畳まれていたのを、Step 4 と同形の補助等式 5 段と $P_{21}$ の 6 段の一続きの鎖と行末根拠へ開いた（内容・参照は不変）。Lambda 側 check 516 ブロック・linkage 296 件・Lean 9520 jobs・sorry 非依存 1459 件・PDF 280 ページ、姉妹側 check 300 ブロック・PDF 331 ページ通過。
- **2026-08-19 の tick 451 は、todo が空で七点の観察から本文へ昇格できる命題候補も無いため前進せず、前回の一ステップ一定理違反を修正してから、姉妹側の転送行列の作用の結論を一続き二段の鎖へ統一した。**
  前進前レビューでは tick 450 のコミット `519bc120` を差分で突き合わせ、交換関係の境界項二本が元の等式と `anticommutator_of_Z_and_Y` の参照を失っていないことを確認した。ただし第 2 の鎖に、単位行列の消去と同類項の統合を同じ等号で行う一ステップ一定理違反があったため、中間行を補ってコミット `b0d645a7` を前進前に push した。「何も言っていない主張」の候補も四則・分母・移項・約分の記述から検索し、独立ブロックはいずれも住処・定義域・共通分母の存在または後続の反復利用を担うため削除対象は無かった。本文末尾（命題候補待ちの 1 項目のみ）とセクション表（todo 空）も一致している。式変形統一では、姉妹側「$T_{(V^{(+)})}$ の $\check Z,\check Y$ への作用」の証明末尾で、二列を並べる等式と $B_1(\tilde\theta_\mu)B_2B_1(\tilde\theta_\mu)=A(\tilde\theta_\mu)$ の適用が表示と散文に分かれていたのを、主張の左辺から始まる二段の鎖と行末根拠へまとめた（内容・参照は不変）。Lambda 側 check 516 ブロック・linkage 296 件・Lean 9520 jobs・sorry 非依存 1459 件・PDF 280 ページ、姉妹側 SageMath 対象検算・check 300 ブロック・PDF 331 ページ通過。
- **2026-08-19 の tick 450 は、todo が空で七点の観察から本文へ昇格できる命題候補も無いため前進せず、姉妹側の交換関係の証明の境界項二本を「同じ計算」の一行から一操作ずつの鎖へ開いた。**
  前進前レビューでは tick 449 のコミット `57eb8cd3` を差分で突き合わせ、$H_2$・$H_1^{(+)}$ の二本の鎖が、準備の $\check Z_{M+1-\mu}$ の表示と `def_half_integer_modes`・`conjugate_index_of_check_Z_Y`・`theorem_exp_product`・`antiperiodic_exp_sum`・`def_transfer_matrix_symbols`・`def_V1_pm` の参照を失っていないことを確認した。「何も言っていない主張」の候補を四則・分母・移項・約分の記述から検索し、独立ブロックの削除対象は無かった。本文末尾（命題候補待ちの 1 項目のみ）とセクション表（todo 空）も一致している。修正なし。式変形統一では、姉妹側「$H_1^{(+)},H_2$ と $\check Z,\check Y$ の交換関係」の証明で、境界項 $[-Y_MZ_1,Z_1]$・$[-Y_MZ_1,Y_M]$ の鎖が「直前の displayMath と同じ計算」の一行に 8 段・6 段の計算を畳んでいたのを、$(Y_M,Z_1)$ に対する交換子の定義・結合法則・`anticommutator_of_Z_and_Y`・単位行列・同類項の一操作ずつの行へ開いた（内容・参照は不変）。Lambda 側 check 516 ブロック・linkage 296 件・Lean 9520 jobs・sorry 非依存 1459 件・PDF 280 ページ、姉妹側 check 300 ブロック・PDF 331 ページ通過。
- 全章（何も言っていない主張の一掃）: 1 セクション
- 零点の詰め寄り・固有値の代数性（本文の lean: から引かれていない Lean の配線）: 1 セクション
- 検算（終結式による $d_1(3)$ の定義多項式の直接構成）: 1 セクション
- 検算（$L=4$ の区間観察）: 1 セクション
- 検算（$L=5$ の区間観察。跡定理経由の構成）: 1 セクション
- 検算（$L=6$ の区間観察。跡定理経由の構成）: 1 セクション
- 検算（$L=7$ の区間観察。跡定理経由の構成）: 1 セクション
- 検算（$L=8$ の区間観察。跡定理経由の構成）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| — | 現在の todo なし | — | $L=2,\dots,8$ の七点では定義多項式の次数も実対数へ脱出した読みも一般則・収束先を一意に定めない。命題候補が立つまでは本文へ項目を追加しない。 |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
- 2026-08-19（tick 454）: todo 表が空であり、$L=2,\dots,8$ の七点の観察から本文へ昇格できる命題候補も立っていないため、未登録のセクションや追加の数値観察には着手しなかった。前進なしの状態を維持し、runbook の別枠である式変形統一だけを 1 件進めた。
- 2026-08-19（tick 453）: todo 表が空であり、$L=2,\dots,8$ の七点の観察から本文へ昇格できる命題候補も立っていないため、未登録のセクションや追加の数値観察には着手しなかった。前進なしの状態を維持し、runbook の別枠である式変形統一だけを 1 件進めた。
- 2026-08-19（tick 452）: todo 表が空であり、$L=2,\dots,8$ の七点の観察から本文へ昇格できる命題候補も立っていないため、未登録のセクションや追加の数値観察には着手しなかった。前進なしの状態を維持し、runbook の別枠である式変形統一だけを 1 件進めた。
- 2026-08-19（tick 451）: todo 表が空であり、$L=2,\dots,8$ の七点の観察から本文へ昇格できる命題候補も立っていないため、未登録のセクションや追加の数値観察には着手しなかった。前進なしの状態を維持し、runbook の別枠である式変形統一だけを 1 件進めた。
- 2026-08-19（tick 450）: todo 表が空であり、$L=2,\dots,8$ の七点の観察から本文へ昇格できる命題候補も立っていないため、未登録のセクションや追加の数値観察には着手しなかった。前進なしの状態を維持し、runbook の別枠である式変形統一だけを 1 件進めた。
## 式変形の書き方の統一（並列の作業ストリーム。毎 tick 1 件）

規則は両プロジェクトの README にある「式変形は一続きにする。根拠は行末に $(\because\ \dots)$ で書く」。
**毎 tick 1 件だけ**書き換え、検証を通し、ここへ記録する。中身は変えない（書き方だけ）。

- 2026-08-19（tick 454）: 姉妹側の半整数運動量における $A(\tilde\theta)$ の対角化章（`015_A_theta_tilde_diagonalization.ts`）の「$\det A(\tilde\theta_\mu)=1$ と固有値の積」（`det_A_theta_tilde`）で、Step 3 の展開 2 式（$\gamma_1(\theta)^2$ の二項展開と $\gamma_2(\theta)\gamma_2(-\theta)$ の分配）と Step 4 の二本の鎖の先頭行（積の結合律と可換律による並べ替え）に行末根拠を補い、証明末尾で「Step 5 と $\gamma_2(\theta)\gamma_2(-\theta)=-r^2$ から得る」と散文に畳まれていた $\gamma_1(\theta)^2=1+r^2$ の導出を、主張の左辺から始まり `relation_of_gamma_2_theta_tilde` (2)・$\mathbb C$ の加法の結合律・Step 5 を行末根拠で引く三段の鎖へ開いた。元の内容と参照は不変。姉妹側 SageMath 対象検算（check_04 PASS）・check 300 ブロック・PDF 332 ページ通過。

- 2026-08-19（tick 453）: 姉妹側の半整数運動量における $A(\tilde\theta)$ の対角化章（`015_A_theta_tilde_diagonalization.ts`）の「$\gamma_2(-\tilde\theta_\mu)=-\overline{\gamma_2(\tilde\theta_\mu)}$ とその帰結」（`relation_of_gamma_2_theta_tilde`）で、補助的な共役計算のあと散文で行っていた両辺の符号反転を、主張 (1) の左辺から始まる一段の鎖へ移した。補助的な共役計算の因数 $-1$ の括り出しと、(5) の $\cos(\pi/2)=0,\sin(\pi/2)=1$ による終端にも行末根拠を補った。元の内容と `def_gamma1_gamma2_of_theta`・`definition_of_cc`・`euler_formula_cos_sin`・`relation_of_gamma_2` の参照は不変。姉妹側 SageMath 対象検算・check 300 ブロック・PDF 332 ページ通過。

- 2026-08-19（tick 452）: 姉妹側の偶セクターの転送行列作用章（`014_even_sector_T_action.ts`）の「$B_1(\theta)B_2B_1(\theta)=A(\theta)$」（`factorization_of_A_theta_general`）の Step 5 で、$P_{21}$ の括弧内の整理が「Step 4 とまったく同じ計算（$\theta\to-\theta$）」の一行に畳まれていたのを、Step 4 と同形の補助的な等式 $a^2+b^2e^{-2i\theta}=e^{-i\theta}(c_1\cos\theta+i\sin\theta)$ の五段の鎖と、直前の $P_{21}$ の表示から始まる六段の一続きの鎖（`theorem_exp_product`・`euler_formula_cos_sin`・倍角公式・`duality_c2_star_eq_s2_star_c2` を行末根拠で引く）へ開いた。元の内容と参照は不変。姉妹側 check 300 ブロック・PDF 331 ページ通過。

- 2026-08-19（tick 451）: 姉妹側の偶セクターの転送行列作用章（`014_even_sector_T_action.ts`）の「$T_{(V^{(+)})}$ の $\check Z,\check Y$ への作用」（`T_V_plus_check_Z_Y`）で、$(z),(y)$ の二本の鎖から得た二列を並べる等式と、`factorization_of_A_theta_general` による $B_1(\tilde\theta_\mu)B_2B_1(\tilde\theta_\mu)=A(\tilde\theta_\mu)$ の適用が表示と散文に分かれていたのを、主張の左辺から始まる一続き二段の鎖と行末根拠へまとめた。元の内容と `def_B1_theta_B2`・`factorization_of_A_theta_general` の参照は不変。姉妹側 SageMath 対象検算・check 300 ブロック・PDF 331 ページ通過。

- 2026-08-19（tick 450）: 姉妹側の偶セクター章（`013_even_sector_modes.ts`）の「$H_1^{(+)},H_2$ と $\check Z,\check Y$ の交換関係」（`commutator_of_H_and_check_Z_Y`）の証明で、境界項 $[-Y_MZ_1,Z_1]$・$[-Y_MZ_1,Y_M]$ の鎖が「直前の displayMath と同じ計算 $(Y_m,Z_{m+1})\to(Y_M,Z_1)$」という一行に 8 段・6 段の計算を畳んでいたのを、$(Y_M,Z_1)$ に対する交換子の定義・行列の積の結合法則・`anticommutator_of_Z_and_Y`・単位行列の性質・同類項の統合の一操作ずつの行へ開いた。元の内容と参照は不変。姉妹側 check 300 ブロック・PDF 331 ページ通過。


### 本プロジェクト（`exact-solution-of-2d-ising-model-lambda`）

| 証明 | 状態 |
|---|---|
| 分配多項式の係数は多重度である | 済（2026-08-08） |
| 多重度の総和は配位の総数に等しい | 済（2026-08-08） |
| すべての配位を等しく数える点での自由エントロピー | 済（2026-08-08） |

（済んだ分の一覧は [auto-loop-archive.md](auto-loop-archive.md)。）

## レビュー記録
- 2026-08-19（tick 455）: tick 454 のコミット `26e0132c` を差分で突き合わせ、$\det A(\tilde\theta_\mu)=1$ の証明末尾に追加された三段の鎖が元の等式と `relation_of_gamma_2_theta_tilde` (2)・Step 5 の内容を失っていないことを確認した。ただし最初の根拠が既存主張を機械的な参照ではなく識別子の生文字列で指していたため、直前に引いた「$\gamma_2(-\tilde\theta_\mu)=-\overline{\gamma_2(\tilde\theta_\mu)}$ とその帰結 (2)」を人間可読な名前で指す形へ直した。「何も言っていない主張」の候補を本文・ノート・SageMath・Lean の四則・分母・移項・約分の記述から検索し、独立ブロックはいずれも住処・定義域・共通分母の存在または後続の反復利用を担うため削除対象は無かった。本文末尾と todo 表も一致している。
- 2026-08-19（tick 454）: tick 453 のコミット `ee5cf891` を差分で突き合わせた。$\gamma_2(-\tilde\theta_\mu)=-\overline{\gamma_2(\tilde\theta_\mu)}$ の一段の鎖と補助計算・(5) の終端の行末根拠は、元の内容と `euler_formula_cos_sin`・`relation_of_gamma_2` の参照を失っていなかった。「何も言っていない主張」の候補を四則・分母・移項・約分の記述から検索し、いずれも行末根拠内の記述で独立ブロックの削除対象は無かった。本文末尾（命題候補待ちの 1 項目のみ）とセクション表（todo 空）も一致している。修正なし。
- 2026-08-19（tick 453）: tick 452 のコミット `436a335f` を差分で突き合わせた。$P_{21}$ の補助等式と六段の鎖は、元の内容と `theorem_exp_product`・`euler_formula_cos_sin`・`duality_c2_star_eq_s2_star_c2` の参照を失っていなかった。「何も言っていない主張」の候補を本文・ノート・SageMath・Lean の四則・分母・移項・約分の記述から検索し、独立ブロックはいずれも well-defined 性・住処・非零性または後続の反復利用を担うため削除対象は無かった。本文末尾（命題候補待ちの 1 項目のみ）とセクション表（todo 空）も一致している。修正なし。
- 2026-08-19（tick 452）: tick 451 のコミット `ac27ef15` を差分で突き合わせた。転送行列作用の結論の二段の鎖は、元の内容と `def_B1_theta_B2`・`factorization_of_A_theta_general` の参照を失わず、$\tilde\theta$ の表記は証明冒頭の略記宣言 $\tilde\theta:=\tilde\theta_\mu$ に従っていた。「何も言っていない主張」の候補を四則・分母・移項・約分の記述から検索し、独立ブロックの削除対象は無かった。本文末尾（命題候補待ちの 1 項目のみ）とセクション表（todo 空）も一致している。修正なし。
- 2026-08-19（tick 451）: tick 450 のコミット `519bc120` を差分で突き合わせた。境界項二本は元の等式と `anticommutator_of_Z_and_Y` の参照を失っていなかったが、第 2 の鎖で単位行列の消去と同類項の統合を同じ等号に適用していたため、中間行を補いコミット `b0d645a7` を前進前に push した。「何も言っていない主張」の候補を本文・ノート・SageMath・Lean の四則・分母・移項・約分の記述から検索し、独立ブロックはいずれも住処・定義域・共通分母の存在または後続の反復利用を担うため削除対象は無かった。本文末尾と todo 表も一致している。
## 判断待ち（人間に問うべき論点）

- **content のファイルを分けるときの文書順の決め方。** システムは `content/` のファイル名昇順を
  文書順とみなすが、リポジトリの規約はファイル名の連番を禁じている。
  2026-08-08（tick 5）に 2 つめの章を書くときこれに当たった。連番は振らず、章ごとにファイルを
  分けることもせず、**本文を 1 ファイル `content/main-text.ts` へまとめて章を見出しブロックで
  区切る**形にした（ファイルが 1 つなら配列順がそのまま文書順になり、論点に当たらないため。
  旧ファイル名 `partition-polynomial.ts` は 1 章分しか指さないので改名した）。
  これは論点の解決ではなく回避である。本文が育ってファイルを分けたくなった時点で決着が要る。
  → **決着の案（人間の判断を待つ）**: システム側（リポジトリ直下 `structured-latex/`）に
  文書順の明示的な宣言（例えば `content/order.ts` にファイル名を並べる）を入れ、
  ファイル名昇順という暗黙の規則をやめる。この変更はシステム側の入力言語に触るため、
  他プロジェクト（`exact-solution-of-2d-ising-model/` 等）にも影響する。

## cron（launchd）

- ラベル: `com.masaori.ising-lambda-auto-loop`
- 定義: `~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist`
- 実体: `scripts/auto-loop-tick.sh`（毎時 5 分、見送られたときの再試行が 35 分。45 分で打ち切る）
- ログ: `logs/auto-loop.log`（git 管理外）
- 各 tick は**独立した新しいセッション**として走る（文脈を持ち越さない。持ち越すのは
  この台帳とリポジトリの中身だけ）。使うエージェントは **Claude と Codex の交互**
  （Claude は `claude-fable-5` の effort medium、Codex は `gpt-5.6-sol` の reasoning medium）。
  片方が使用量の上限に当たった間は、期限を `logs/claude-blocked-until` へ記録してもう片方だけで回す。
- 監査は別ジョブ（毎時 55 分の軽い監査 `scripts/audit-light.sh`、毎日 04:20 の重い監査
  `scripts/audit-loop.sh`）。PDF は `scripts/refresh-pdf.sh` が 5 分おきに最新へ保つ。

停止・再開・頻度変更は、**自分で `launchctl` を叩かず** tmux セッション `local-pc-management` の
ウィンドウ `tick窓口` へ依頼する（2026-08-16 に経路が固定された。`launchd-tick-loop` skill）。
