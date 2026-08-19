# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地
- **2026-08-19 の tick 460 は、todo が空で七点の観察から本文へ昇格できる命題候補も無いため前進せず、tick 459 の周期性の鎖に残った二操作一行を直してから、姉妹側の $\check\psi$ の反交換関係の証明の式変形を統一した。**
  前進前レビューでは tick 459 のコミット `d04c21f6` を差分で突き合わせ、周期性と共役添字の証明で開かれた鎖が元の内容と参照を失っていないことを確認したが、運動量の分配則の行に分数の分割が、共役添字の分配則の行に可換則の並べ替えが同居していた（二操作一行）ため、中間行を補って一操作ずつへ分け、コミット `5e977456` を前進前に push した。「何も言っていない主張」の候補を四則・分母・移項・約分の記述から検索し、独立ブロックの削除対象は無かった。本文末尾（命題候補待ちの一項目のみ）と todo 表（空）も一致している。式変形統一では姉妹側 `016_even_sector_fermions.ts` の「$\check\psi$ の反交換関係」（`anticommutator_of_check_psi`）で、行末根拠の機械識別子と「直前の displayMath」という指し方を人間可読な名前へ直し、一行二等号を一操作ずつに分け、根拠の無かった行に行末根拠を補い、散文に畳まれていた反交換子の双線型性の計算を四段の鎖へ開いた（内容・参照は不変）。姉妹側 SageMath 対象検算（check\_01・check\_02 PASS）・check 300 ブロック・PDF 333 ページ、Lambda 側 check 516 ブロック・linkage 296 件・Lean 9520 jobs・sorry 非依存 1459 件・PDF 280 ページ通過。
- **2026-08-19 の tick 459 は、todo が空で七点の観察から本文へ昇格できる命題候補も無いため前進せず、姉妹側の $\gamma_1,\gamma_2$ の周期性と共役添字の証明で、「同じ計算」に省略していた二本の導出を一続きの鎖へ開いた。**
  前進前レビューでは tick 458 のコミット `17a03b59` を差分で突き合わせ、$\gamma_2(\tilde\theta_\mu)\neq0$ の等価変形が一行一操作・行末根拠つきで、元の内容と参照を失っていないことを確認した（本文の修正なし）。「何も言っていない主張」の候補を四則・分母・移項・約分の記述から検索し、独立ブロックはいずれも住処・定義域・非零性または後続の反復利用を担うため削除対象は無かった。本文末尾と todo 表（空）も一致している。式変形統一では姉妹側 `016_even_sector_fermions.ts` の「$\gamma_1,\gamma_2$ の周期性と共役添字 $M+1-\mu$」（`periodicity_of_check_fermi`）で、機械識別子の根拠を人間可読な名前とラベル参照へ直し、分配則の行に根拠を補い、共役添字の二本の省略計算を左辺から始まる鎖へ開いた（内容・参照は不変）。姉妹側 SageMath 対象検算（check\_01 PASS）・check 300 ブロック・PDF 333 ページ、Lambda 側 check 516 ブロック・linkage 296 件・Lean 9520 jobs・sorry 非依存 1459 件・PDF 280 ページ通過。
- **2026-08-19 の tick 458 は、todo が空で七点の観察から本文へ昇格できる命題候補も無いため前進せず、姉妹側の $\gamma_2(\tilde\theta_\mu)\neq0$（例外なし）の証明で、鎖の行末根拠に残っていたラベル識別子の生文字列と二操作一行を一操作ずつの形へ直した。**
  前進前レビューでは tick 457 のコミット `193a0981`・`1f05046f` を差分で突き合わせ、固有ベクトルの第二成分の約分の二段の鎖、行列式の同類項の統合の四段の鎖、対角化の右乗の四段の鎖が、いずれも一行一操作・行末根拠つきで、元の内容と `eigenvector_of_A_theta_tilde`・`gamma_2_theta_tilde_nonzero`・`relation_of_gamma_2_theta_tilde`・`complex_numbers_form_a_field` の参照を失っていないことを確認した（本文の修正なし）。「何も言っていない主張」の候補を四則・分母・移項・約分の記述から検索し、独立ブロックの削除対象は無かった。本文末尾（命題候補待ちの一項目のみ）と todo 表（空）も一致している。式変形統一では、姉妹側 `015_A_theta_tilde_diagonalization.ts` の「$\gamma_2(\tilde\theta_\mu)\neq0$（例外なし）」（`gamma_2_theta_tilde_nonzero`）で、Step 1・Step 2 の鎖の行末根拠をラベル識別子の生文字列（def\_gamma1\_gamma2\_of\_theta 等）から人間可読な名前へ直し、Step 2 の「両辺を π で割って M 倍する」を一操作ずつの二行に分け、最終行 $2(\mu-\frac12)=2\mu-1$ に行末根拠を補って鎖の後の重複した散文根拠を外した（内容・参照は不変）。姉妹側 SageMath 対象検算（check_01 PASS）・check 300 ブロック・PDF 333 ページ、Lambda 側 check 516 ブロック・linkage 296 件・Lean 9520 jobs・sorry 非依存 1459 件通過。
- **2026-08-19 の tick 457 は、todo が空で七点の観察から本文へ昇格できる命題候補も無いため前進せず、前回の因数分解に残った一ステップ一定理違反を修正してから、姉妹側の $A(\tilde\theta_\mu)$ の対角化証明を一続きの鎖へ統一した。**
  前進前レビューでは tick 456 のコミット `1784a3bf` を差分で突き合わせ、固有値と固有ベクトルの証明に追加された因数分解を確認したところ、分配則と同類項の統合を一つの等号へまとめた行が二箇所あったため中間行を補い、コミット `193a0981` を前進前に push した。元の恒等式と `def_gamma1_gamma2_of_theta`・`relation_of_gamma_2_theta_tilde`・`gamma_2_theta_tilde_nonzero`・`complex_numbers_form_a_field`・`abs_basic_properties` の参照は失っていない。「何も言っていない主張」の候補を本文・ノート・SageMath・Lean の四則・分母・移項・約分の記述から検索し、独立ブロックはいずれも住処・非零性・定義域または後続の反復利用を担うため削除対象は無かった。本文末尾（命題候補待ちの一項目のみ）と todo 表も一致している。式変形統一では、姉妹側 `015_A_theta_tilde_diagonalization.ts` の「$A(\tilde\theta_\mu)$ の対角化」（`diagonalization_check_P_D`）で、固有ベクトルの第二成分の約分、行列式の同類項の統合、対角化の右乗を、それぞれ主張の左辺から始まる一続きの鎖と行末根拠へ開いた（内容・参照は不変）。姉妹側 SageMath 対象検算（check_03 PASS）・check 300 ブロック・PDF 333 ページ、Lambda 側 check 516 ブロック・linkage 296 件・Lean 9520 jobs・sorry 非依存 1459 件・PDF 280 ページ通過。
- **2026-08-19 の tick 456 は、todo が空で七点の観察から本文へ昇格できる命題候補も無いため前進せず、保管庫から漏れていた tick 435〜450 の台帳記録を git 履歴から復元し、姉妹側の固有値と固有ベクトルの証明で散文に畳まれていた特性多項式の因数分解を一続きの鎖へ開いた。**
  前進前レビューでは tick 455 のコミット `e55a53ce` を差分で突き合わせ、$\gamma_1(\tilde\theta_\mu)>1$ の三つの鎖（Step 1 の正値性・Step 2 の平方評価・Step 3 の背理法）が元の内容と `def_gamma1_gamma2_of_theta`・`det_A_theta_tilde`・`gamma_2_theta_tilde_nonzero` の参照を失っていないことを確認した（本文の修正なし）。ただし台帳の保守で、保管庫の最新が tick 434 分で止まり、tick 435〜450 の「現在地」「前進の記録」「式変形統一」「レビュー記録」が保管されないまま台帳から落とされていたことを見つけ、git 履歴の六つの版から復元して保管庫へ追記した（tick 441 は備考訂正のみの回で独立項目が元々無く、レビュー記録だけを復元）。「何も言っていない主張」の独立ブロックの削除対象は無く、本文末尾と todo 表も一致している。式変形統一では、姉妹側 `015_A_theta_tilde_diagonalization.ts` の「$A(\tilde\theta_\mu)$ の固有値と固有ベクトル」（`eigenvector_of_A_theta_tilde`）で、Step 1 の「右辺を展開すれば左辺に一致する」と散文に畳まれていた特性多項式の因数分解を、準備の恒等式の三段と行列式の鎖の六段へ開き、固有ベクトル成分の二本の鎖の根拠なしの行（分配則による括り出し）に行末根拠を補った（内容・参照は不変）。姉妹側 SageMath 対象検算（check_03 PASS）・check 300 ブロック・PDF 332 ページ、Lambda 側 check 516 ブロック・linkage 296 件・Lean 9520 jobs・sorry 非依存 1459 件・PDF 280 ページ通過。
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
- 2026-08-19（tick 460）: todo 表が空であり、$L=2,\dots,8$ の七点の観察から本文へ昇格できる命題候補も立っていないため、未登録のセクションや追加の数値観察には着手しなかった。前進なしの状態を維持し、レビュー修正一件と runbook の別枠である式変形統一一件を進めた。
- 2026-08-19（tick 459）: todo 表が空であり、$L=2,\dots,8$ の七点の観察から本文へ昇格できる命題候補も立っていないため、未登録のセクションや追加の数値観察には着手しなかった。前進なしの状態を維持し、runbook の別枠である式変形統一だけを 1 件進めた。
- 2026-08-19（tick 458）: todo 表が空であり、$L=2,\dots,8$ の七点の観察から本文へ昇格できる命題候補も立っていないため、未登録のセクションや追加の数値観察には着手しなかった。前進なしの状態を維持し、runbook の別枠である式変形統一だけを 1 件進めた。
- 2026-08-19（tick 457）: todo 表が空であり、$L=2,\dots,8$ の七点の観察から本文へ昇格できる命題候補も立っていないため、未登録のセクションや追加の数値観察には着手しなかった。前進なしの状態を維持し、レビュー修正一件と runbook の別枠である式変形統一一件を進めた。
- 2026-08-19（tick 456）: todo 表が空であり、$L=2,\dots,8$ の七点の観察から本文へ昇格できる命題候補も立っていないため、未登録のセクションや追加の数値観察には着手しなかった。前進なしの状態を維持し、保管庫の記録復元（レビューの一部）と、runbook の別枠である式変形統一 1 件を進めた。
## 式変形の書き方の統一（並列の作業ストリーム。毎 tick 1 件）

規則は両プロジェクトの README にある「式変形は一続きにする。根拠は行末に $(\because\ \dots)$ で書く」。
**毎 tick 1 件だけ**書き換え、検証を通し、ここへ記録する。中身は変えない（書き方だけ）。

- 2026-08-19（tick 460）: 姉妹側の半整数運動量のフェルミオン章（`016_even_sector_fermions.ts`）の「$\check\psi$ の反交換関係」（`anticommutator_of_check_psi`）で、行末根拠の機械識別子（periodicity\_of\_check\_fermi・relation\_of\_gamma\_2\_theta\_tilde・abs\_basic\_properties・def\_check\_fermi・anticommutator\_of\_check\_Z\_Y）と「直前の displayMath」という指し方を人間可読な名前へ直し、$a_\nu,b_\nu$ の鎖と Step 4 の末尾の一行二等号を一操作ずつに分け、根拠の無かった行（$r_\nu=r_\mu$・乗法の可換則・負号の移動・0 行列の項の消去・符号の積・同類項の統合・約分）に行末根拠を補い、散文に畳まれていた反交換子の双線型性の計算 $[\alpha X,\beta W]_+=\alpha\beta(XW+WX)$ を四段の鎖へ開いた。元の内容と `def_check_fermi`・`anticommutator_of_check_Z_Y`・`periodicity_of_check_fermi`・`relation_of_gamma_2_theta_tilde`・`abs_basic_properties`・`scalar_identity_commutes`・`gamma_2_theta_tilde_nonzero` の参照は不変。姉妹側 SageMath 対象検算（check\_02 PASS）・check 300 ブロック・PDF 333 ページ通過。

- 2026-08-19（tick 459）: 姉妹側の半整数運動量のフェルミオン章（`016_even_sector_fermions.ts`）の「$\gamma_1,\gamma_2$ の周期性と共役添字 $M+1-\mu$」（`periodicity_of_check_fermi`）で、Euler の公式・運動量・共役添字の根拠を機械識別子の生文字列から人間可読な名前とラベル参照へ直し、運動量の導出で根拠の無かった分配則の行を補った。また、「同じ計算」に省略していた $\gamma_2(-\tilde\theta_{M+1-\mu})=\gamma_2(\tilde\theta_\mu)$ と $\gamma_1(\tilde\theta_{M+1-\mu})=\gamma_1(\tilde\theta_\mu)$ の導出を、各結論の左辺から始まる鎖へ開いた。元の内容と `euler_formula_cos_sin`・`antiperiodic_exp_sum`・`conjugate_index_of_check_Z_Y`・`def_gamma1_gamma2_of_theta` の参照は不変。姉妹側 SageMath 対象検算（check\_01 PASS）。

- 2026-08-19（tick 458）: 姉妹側の半整数運動量における $A(\tilde\theta)$ の対角化章（`015_A_theta_tilde_diagonalization.ts`）の「$\gamma_2(\tilde\theta_\mu)\neq0$（例外なし）」（`gamma_2_theta_tilde_nonzero`）で、Step 1・Step 2 の同値変形の鎖の行末根拠をラベル識別子の生文字列（def\_gamma1\_gamma2\_of\_theta・def\_half\_integer\_modes・definition\_of\_cc・complex\_numbers\_form\_a\_field）から人間可読な名前へ直し、Step 2 の「両辺を $\pi$ で割って $M$ 倍する」を「両辺を $\pi>0$ で割る」「両辺を $M\neq0$ 倍する」の二行に分け、最終行 $2(\mu-\frac12)=2\mu-1$ に行末根拠（分配則）を補って、鎖の直後で同じ根拠を繰り返していた散文を外した。元の内容と `def_gamma1_gamma2_of_theta`・`abs_basic_properties`・`euler_formula_cos_sin`・`complex_numbers_form_a_field`・`definition_of_cc`・`def_half_integer_modes`・`gamma_2_theta_is_0` の参照は不変。姉妹側 SageMath 対象検算（check_01 PASS）・check 300 ブロック・PDF 333 ページ通過。

- 2026-08-19（tick 457）: 姉妹側の半整数運動量における $A(\tilde\theta)$ の対角化章（`015_A_theta_tilde_diagonalization.ts`）の「$A(\tilde\theta_\mu)$ の対角化」（`diagonalization_check_P_D`）で、固有ベクトルの第二成分 $cb=1/(2\sqrt M)$ の約分を二段の鎖へ、行列式の末尾にあった一行二等号を四段の鎖へ、散文で済ませていた $A\check P=\check P\check D$ の右からの $\check P^{-1}$ の乗算を四段の鎖へ開き、各行末に根拠を置いた。元の内容と `eigenvector_of_A_theta_tilde`・`gamma_2_theta_tilde_nonzero`・`relation_of_gamma_2_theta_tilde`・`complex_numbers_form_a_field` の参照は不変。姉妹側 SageMath 対象検算（check_03 PASS）・check 300 ブロック・PDF 333 ページ通過。

- 2026-08-19（tick 456）: 姉妹側の半整数運動量における $A(\tilde\theta)$ の対角化章（`015_A_theta_tilde_diagonalization.ts`）の「$A(\tilde\theta_\mu)$ の固有値と固有ベクトル」（`eigenvector_of_A_theta_tilde`）で、Step 1 の「右辺を展開すれば左辺に一致する」と散文に畳まれていた特性多項式の因数分解 $\lambda^2-2g_1\lambda+(g_1^2-r^2)=(\lambda-(g_1+r))(\lambda-(g_1-r))$ を、準備の恒等式の三段の鎖と、行列式から因数分解形へ至る六段の一続きの鎖（$\mathbb C$ の四則・分配則と同類項の統合・準備の略記 $ab=-r^2$・準備の恒等式を行末根拠で引く）へ開き、固有ベクトル成分の二本の鎖で根拠の無かった分配則の行二つに行末根拠を補った。元の内容と `def_gamma1_gamma2_of_theta`・`relation_of_gamma_2_theta_tilde`・`gamma_2_theta_tilde_nonzero`・`complex_numbers_form_a_field`・`abs_basic_properties` の参照は不変。姉妹側 SageMath 対象検算（check_03 PASS）・check 300 ブロック・PDF 332 ページ通過。


### 本プロジェクト（`exact-solution-of-2d-ising-model-lambda`）

| 証明 | 状態 |
|---|---|
| 分配多項式の係数は多重度である | 済（2026-08-08） |
| 多重度の総和は配位の総数に等しい | 済（2026-08-08） |
| すべての配位を等しく数える点での自由エントロピー | 済（2026-08-08） |

（済んだ分の一覧は [auto-loop-archive.md](auto-loop-archive.md)。）

## レビュー記録
- 2026-08-19（tick 460）: tick 459 のコミット `d04c21f6` を差分で突き合わせ、「$\gamma_1,\gamma_2$ の周期性と共役添字」で開かれた鎖が元の内容と `conjugate_index_of_check_Z_Y`・`def_gamma1_gamma2_of_theta` の参照を失っていないことを確認したが、運動量の分配則の行に分数の分割が、共役添字の分配則の行に可換則の並べ替えが同居していた（二操作一行）ため、中間行を補って一操作ずつへ分け、コミット `5e977456` を前進前に push した。「何も言っていない主張」の候補を四則・分母・移項・約分の記述から検索し、独立ブロックの削除対象は無かった。本文末尾（命題候補待ちの一項目のみ）と todo 表（空）も一致している。
- 2026-08-19（tick 459）: tick 458 のコミット `17a03b59` を差分で突き合わせ、$\gamma_2(\tilde\theta_\mu)\neq0$ の等価変形は一行一操作・行末根拠つきで、元の内容と `def_gamma1_gamma2_of_theta`・`abs_basic_properties`・`euler_formula_cos_sin`・`complex_numbers_form_a_field`・`definition_of_cc`・`def_half_integer_modes`・`gamma_2_theta_is_0` の参照を失っていなかった（本文の修正なし）。「何も言っていない主張」の候補を本文・ノート・SageMath・Lean の四則・分母・移項・約分の記述から検索し、独立ブロックはいずれも住処・定義域・非零性または後続の反復利用を担うため削除対象は無かった。本文末尾と todo 表も一致している。
- 2026-08-19（tick 458）: tick 457 のコミット `193a0981`・`1f05046f` を差分で突き合わせ、固有ベクトルの第二成分の約分の二段の鎖・行列式の同類項の統合の四段の鎖・対角化の右乗の四段の鎖が、いずれも一行一操作・行末根拠つきで、元の内容と `eigenvector_of_A_theta_tilde`・`gamma_2_theta_tilde_nonzero`・`relation_of_gamma_2_theta_tilde`・`complex_numbers_form_a_field` の参照を失っていないことを確認した（本文の修正なし）。「何も言っていない主張」の候補を四則・分母・移項・約分の記述から検索し、独立ブロックの削除対象は無かった。本文末尾（命題候補待ちの一項目のみ）とセクション表（todo 空）も一致している。
- 2026-08-19（tick 457）: tick 456 のコミット `1784a3bf` を差分で突き合わせ、固有値と固有ベクトルの因数分解に分配則と同類項の統合を同時適用した行が二箇所残っていることを見つけた。分配・可換則・同類項の統合・並べ替えを一操作ずつの中間行へ分け、コミット `193a0981` を前進前に push した。元の内容と参照は不変。「何も言っていない主張」の候補を本文・ノート・SageMath・Lean の四則・分母・移項・約分の記述から検索し、独立ブロックはいずれも住処・非零性・定義域または後続の反復利用を担うため削除対象は無かった。本文末尾と todo 表も一致している。
- 2026-08-19（tick 456）: tick 455 のコミット `e55a53ce` を差分で突き合わせ、$\gamma_1(\tilde\theta_\mu)>1$ の三つの鎖が一行一操作・行末根拠つきで、元の内容と `det_A_theta_tilde`・`gamma_2_theta_tilde_nonzero` の参照を失っていないことを確認した（本文の修正なし）。また保管庫の最新が tick 434 分で止まり、tick 435〜450 の台帳記録が保管されないまま落とされていたのを見つけ、git 履歴の六つの版（tick 439・442・444・449・450・454 時点）から復元して保管庫へ追記した。「何も言っていない主張」の候補を四則・分母・移項・約分の記述から検索し、独立ブロックはいずれも住処・非零性・共通分母の存在または後続の反復利用を担うため削除対象は無かった。本文末尾（命題候補待ちの 1 項目のみ）とセクション表（todo 空）も一致している。
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
