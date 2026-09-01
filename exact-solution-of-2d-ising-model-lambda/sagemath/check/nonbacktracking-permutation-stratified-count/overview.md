# SageMath Check: 非後退置換の母関数は反転対と単純通過で層別される

**対象ラベル**: `claim_nonbacktracking_permutation_stratified_count`

$L=2$ の非後退置換 $30{,}784$ 個を全列挙し、次を厳密検査する。

- 各置換の像 $(D(\varphi),E_1(\varphi))$ が $D(\varphi)\cap E_1(\varphi)=\varnothing$ と
  $\operatorname{Even}_L(E_1(\varphi))$ を満たすこと、
- 像ごとのファイバー $\mathcal N_L(D,E)$ が全置換を互いに素に分割すること、
- 各置換について軌道長総和が $2|D|+|E|$ に等しいこと、
- したがって二つの有限和が $\mathbb Z[x]$ の同じ多項式になること。

- 実行: `sage sagemath/check/nonbacktracking-permutation-stratified-count/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 非空ファイバーは $609$ 個で、両辺は
  $6561x^{16}+8424x^{14}+9164x^{12}+4536x^{10}+1670x^8+344x^6+76x^4+8x^2+1$
  に一致した。

すべて有限集合の数え上げと整数係数多項式の計算であり、浮動小数点は使わない。
