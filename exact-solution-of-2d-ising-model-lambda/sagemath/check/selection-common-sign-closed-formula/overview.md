# 選択項の共通符号の閉じた式

**対象ラベル**: `claim_selection_sum_character_evaluation`,
`claim_winding_parity_symmetric_difference_additivity`

鍵 $(D,E)$ の選択項 $w^{a,b}(D\cup C)\,w^{a,b}(D\cup(E\setminus C))$ は、
$A:=D\cup C$ と置くと巻き付き偶奇の $\mathbb F_2$ 双線形計算だけから

$$(-1)^{(1+a)\varepsilon_{\mathrm h}(E)+(1+b)\varepsilon_{\mathrm v}(E)
+\varepsilon_{\mathrm h}(E)\varepsilon_{\mathrm v}(E)}
\cdot(-1)^{\varepsilon_{\mathrm h}(A)\varepsilon_{\mathrm v}(E)
+\varepsilon_{\mathrm h}(E)\varepsilon_{\mathrm v}(A)}$$

に等しい。第二因子は巻き付きベクトルの交差対 $\langle A,E\rangle$ であり、
選択集合を巡回空間の元 $z$ で動かすと $\langle z,E\rangle$ だけ変わる。従って
文字が自明な鍵では選択項は $C$ に依らない共通符号を持ち、非自明な鍵では
$C\mapsto C\mathbin\triangle z$（$\langle z,E\rangle=1$）が符号反転の不動点なし
対合になって選択和が零になる。

- 実行: `sage sagemath/check/selection-common-sign-closed-formula/check.sage`
- 状態: PASS（2026-09-04。一辺二の選択非空 $417$ 鍵・恒等式 $4{,}096$ 件、
  一辺三の $D=\varnothing$ の恒等式 $34{,}352$ 件、自明文字 $677$ 鍵の共通符号、
  非自明文字 $346$ 鍵の対合消滅 $21{,}808$ 件）
- 方法: 有限集合、$\mathbb F_2$、整数の厳密演算のみ。浮動小数点は使わない。
