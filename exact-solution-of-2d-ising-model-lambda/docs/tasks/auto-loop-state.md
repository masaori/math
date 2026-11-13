# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-11-13（主経路の連続実行）、内側を右に置く歩道の方向対応の必要十分版を示した。** 四方向の番号と境界表の逆向き番号の対応を Lean で抽象化した。次は接触点分割・平滑化・横断数の具体版の委譲を一件外す。
- **2026-11-13（主経路の連続実行）、内側を右に置く歩道の始点の入方向を方向表に対応させた。** 平面持ち上げの一歩から実際の辺の方向番号を得て、方向表の入方向が二だけずれることを Lean 具体版で示した。次は右に置く歩道の方向対応の必要十分版である.
- **2026-11-13（並列の連続実行）、多項式の有限和の積の添字写像展開（`claim_polynomial_product_of_sums`）の Lean 具体版から必要十分版への委譲を外した。** 並列の表の先頭の行は主経路の「内側を右に置く歩道の方向対応の必要十分版」がまだ未完なので、末尾の行を進めた。具体版 `qbarPolynomial_prod_sum_eq_sum_prod_family` は本文の $\mathfrak F(S)$・$\operatorname{ins}$・$\operatorname{spl}$ と重みの分離を必要十分版の `FamilyOn`・`insertFamilyEquiv`・`prod_attach_insertFamily` で済ませていた。本文の $\mathfrak F(S)$（`QbarFiniteMapsOn`）、$W_S$、$\operatorname{ins}$、$\operatorname{spl}$、二つの往復、重みの四等号を同じファイルに置き、本文と同じ順で示す形へ直した。例外の台帳の行を消した（45 件から 44 件）。末尾の行の残りは `def_integer_matrix_determinant` の 1 件と、下の備考に足したブロック対角の補題である。
- **2026-11-13（主経路の連続実行）、内側を右に置く歩道の終点の出方向を方向表に対応させた。** 平面持ち上げの差から実際の辺の方向を得て、方向表の出方向は二だけずれることを Lean 具体版で示した。次は始点の入方向である。
- **2026-11-13（並列の連続実行）、多項式行列式の乗法性（`claim_polynomial_determinant_mul`）と非単射の添字写像による内側和の相殺（`claim_polynomial_determinant_noninjective_cancellation`）の Lean 具体版から必要十分版への委譲を外した。** 並列の表の先頭の行が主経路の表の「内側を右に置く歩道の入出方向」を待つので、表の末尾の行「行列式・マッチングの具体版の委譲を外す」を進めた。具体版 `qbarPolynomial_sign_comp` は符号の乗法性を必要十分版の `sign_comp` で、`qbarPolynomial_sign_right_transposition_neg`・`qbarPolynomial_noninjective_inner_sum_zero` は互換と互換の符号と乗法性を必要十分版の `transpositionPerm`・`sign_transposition`・`sign_comp` で済ませていた。乗法性を具体版 `finiteOrderedSign_comp`、互換を具体版 `KacWard.finiteTranspositionPerm`（本文の $t_{a,b}$）、互換の符号を具体版 `KacWard.finiteTransposition_sign` へ替え、例外の台帳の三行を消した（48 件から 45 件）。末尾の行の残りは `claim_polynomial_product_of_sums`・`def_integer_matrix_determinant` の 2 件である。


## レビュー記録

- 2026-11-13: 「完全マッチングの符号は対の列挙順序に依存しない」の主張文は $\operatorname{sgn}(\mathcal D)\in\{-1,1\}$ を述べるのに、証明は列挙の取り替えと空集合の場合だけを示し、値が $\{-1,1\}$ に属することを示していなかった（定義ブロックが $\in\{-1,1\}$ と書くだけ）。$\pi:=\pi_{W(\mathcal L_0)}$ を置き、`def_perfect_matching_sign`・`def_matching_word_sign`・`def_permutation_sign` を引く三等号と、整数 $(-1)^k$ の偶奇による所属の一行を証明に足した（主張は不変）。SageMath に四行の検算 `check_sign_values.sage` を足した（520 等式、否定の対照を含む）。
- 2026-11-12: 「分散因子の最小値は自己双対点で零になる」の本文の証明が、$0<r<1$ を実現写像の四つの主張の列挙で、$2r(1-r^2)>0$ を根拠なしに、$B_\xi-(1-2r-r^2)^2$ を「$\mathbb R$ の分配則」の一行で、$(1-2r-r^2)^2=0\iff1-2\xi-\xi^2=0$ を「単射性と四則保存」の一行で、$-1-s<_R0$ を「$0<_Rx_c$ と $-2<_R0$」（推移律と加法の両立を引かずに）で、$1+x_c\ne0$ を「$s=1+x_c>_R0$」で済ませ、主張文に無い $s$ を置かずに使っていた。$s$ を `def_critical_point` から置き、五つの事実（$\rho(0)=0<\rho(\xi)$ と $\rho(\xi)<\rho(1)=1$、$c=2r((1-r)(1+r))>0$、$\rho(p)$ の七行、$s\ne0$ と $-1-s<_R-2<_R0$ を差の平方で示して推移律、$\xi\ne-1-s$ を $0<_R0$ からの $v\cdot v=0$ で）、差の六行、$B_\xi(0,0)$ の四行、零条件の七行の同値、$1+x_c=s\ne0$ の三行へ直した（主張は不変）。SageMath を各行の検算へ書き直した（4,364 件、否定の対照を含む）。
- 2026-11-12: 「複素根の角表示は分散因子の実現値を余弦で表す」の本文の証明が、この主張に要らない「角の組は全モードの組を重複なく走る」を置き、$\rho_{R\to\mathbb R}(\varpi+\varpi^{-1})=\rho_{\overline{\mathbb Q}\to\mathbb C}(\varpi+\varpi^{-1})$ を $\varpi+\varpi^{-1}\in R$ と実数・複素数の写像を示さずに書き、主張文が別の主張の証明の中で置いた記号 $e_{L,a,k}$ を使い、負号の保存を本文に節の無い事実として引いていた。共役の主張から $\varpi+\varpi^{-1}=2\alpha+0\cdot\omega$ の三行、$\varpi\ne0$ の三行、$\rho_{\overline{\mathbb Q}\to\mathbb C}(\varpi^{-1})$ の八行、実部 $\operatorname{Re}$ を置いて $\rho_{R\to\mathbb R}(2\alpha)=2\cos\theta_1$ を出す九行、$\rho(m-w)=\rho(m-w)+\rho(w)-\rho(w)=\dots$ の十行へ直し、主張文の右辺を $r:=\iota_{\mathbb Q\to\mathbb R}(q)$ で書いた（主張は不変。下流の `claim_dispersion_angle_log_continuous` の $B_q$ と同じ形）。SageMath を各行の検算へ書き直した（42,435 件、否定の対照を含む）。
- 2026-11-12: 「下組の実現像の上限は列の実数極限に等しい」の本文の証明が、結論に使わない「$\rho$ は狭義順序を保つ」の七行の鎖を先に置き、$0<_{\Lambda_{\mathbb Q}}\varepsilon$ を $s=m/n$ と共通分母の証人で日本語で示し、$c=\log_{\mathbb R}2>0$ を根拠なしに置き、Archimedes 性の段を「有理数の稠密性を二度用い…を選べばよい」と日本語で済ませ、上限の存在を「実数の完備性」に頼っていた。三つの事実（実現値の狭義比較を全順序性と単調性で順序へ戻す、$\rho(0)=0$ の四行、$c>0$ の八行）を先に置き、上からの四行、下からの三つの鎖（$b<\rho(\mu)$ の四行、$\rho(\mu+\varepsilon)<I$ の六行、$\rho(\varepsilon)>0=\rho(0)$ の四行）、$I$ が最小上界であることで上限を示す形へ直した。主張文と脱出理由から完備性を外した（主張は不変）。SageMath を各行の検算へ書き直した（5,402 件、区間演算、否定の対照を含む）。

## 式変形の書き方の統一

- 2026-11-13（主経路の書式統一）: 「正の有理点での有限自由エントロピー密度は非負である」の零写像の値の式鎖で、三行の行末根拠の中の句点を読点または接続語へ直した（主張と式は不変）。
- 2026-11-13（主経路の書式統一）: 「全プラス配位は破れボンドを持たない」（`claim_constant_plus_breaks_no_bond`）の式鎖で、全プラス配位の定義を引く行末根拠の句点を読点へ直した（主張と式は不変）。
- 2026-11-13（並列の連続実行の書式統一。研究管理がこの作業を主経路へ移す前に着手したもの）: 「正の有理点での開いた長方形の分配多項式の値は 1 以上である」（`claim_open_rectangle_value_ge_one_at_positive_rational`）の $1\le Z^{\mathrm{op}}_{a,b}(q)$ の式鎖で、三行の行末根拠の中の句点を読点へ直した（この主張の行末根拠の句点は全て片付いた）。
- 2026-11-13（並列の連続実行の書式統一）: 「有理係数の対数順序群の加法は順序と両立する」（`claim_rational_log_order_group_add_monotone`）の $N\cdot(\lambda+\nu)$ の式鎖で、二行の行末根拠の中の句点を読点へ直した（この主張の行末根拠の句点は全て片付いた）。
- 2026-11-13（並列の連続実行の書式統一）: 「正の有理点での分配多項式の値の上からの評価」（`claim_partition_value_upper_bound_at_positive_rational`）の $Z_L(q)$ の式鎖で、五行の行末根拠の中の句点を読点へ直した（この主張の行末根拠の句点は全て片付いた）。

## 前進の記録

- 2026-11-13: 主経路の先頭「内側を右に置く歩道の方向対応の必要十分版」を済ませた。四方向の番号と境界表の逆向き番号の対応を抽象化した Lean 必要十分版を置き、既存の実際の歩道に関する具体版二件とともに本文の Lean 対応へ登録した。本文の主張と SageMath は不変。次は接触点分割・平滑化・横断数の具体版の委譲を一件外す。
- 2026-11-13: 主経路の先頭「内側を右に置く歩道の始点の入方向」を済ませた。Lean 具体版 `vertexSimpleWalk_incoming_direction_eq_boundary_right` は、実際の辺の方向番号と四セル方向表の入方向が二だけずれることを平面持ち上げの座標差から示す。本文・SageMath は不変。次は右側の方向対応の必要十分版。
- 2026-11-13: 並列の表の先頭の行は主経路の表の「内側を右に置く歩道の方向対応の必要十分版」（未着手）を待つので、末尾の行「行列式・マッチングの具体版の委譲を外す」の `claim_polynomial_product_of_sums` を済ませた。`QbarPolynomialProductSum.lean` は必要十分版の定義・定理を開かず、導出版は恒等の往復 `qbarFiniteMapsOnEquivFamilyOn` で必要十分版の和の添字を具体版の $\mathfrak F(S)$ へ移す。ブロック対角の具体版 `blockDiagonal_det_eq_prod_fiber_dets` が呼ぶ private 補題 `polynomial_prod_sum_fibers` は必要十分版の `FamilyOn`・`insertFamilyEquiv`・`prod_attach_insertFamily` を使っている（検査は登録名の本体だけを見るので数えない）ことを見つけ、末尾の行の備考へ足した。本文・SageMath は不変。
- 2026-11-13: 右に置く歩道の入出方向の行は始点の入方向・終点の出方向・必要十分版へ割った。終点の出方向は、四セル表の右側の補題と平面持ち上げの一歩の差から、実際の方向番号に二を足した値と等しいことを Lean 具体版で示した。本文と SageMath は既存のままである。
- 2026-11-13: 並列の表の先頭の行（各出発位置の回転数と境界頂点の局所回転数の同定）は主経路の表の「内側を右に置く歩道の入出方向」の完了待ちなので、末尾の行「行列式・マッチングの具体版の委譲を外す」の `claim_polynomial_determinant_mul`・`claim_polynomial_determinant_noninjective_cancellation` を済ませた。`QbarPolynomialDeterminantMultiplicativity.lean` の `qbarPolynomial_sign_comp` は符号の乗法性の一行を具体版 `finiteOrderedSign_comp` で示す。`QbarPolynomialNoninjectiveCancellation.lean` は互換を `KacWard.finiteTranspositionPerm`、その各点の値を `finiteTransposition_apply_*`、互換の符号を `KacWard.finiteTransposition_sign`、乗法性を `finiteOrderedSign_comp` で示し、必要十分版の定理を開かない。導出版二ファイルは橋 `KacWard.finiteTranspositionPerm_eq_necSuf` で互換を必要十分版のものへ移して渡す。本文・SageMath は不変。
