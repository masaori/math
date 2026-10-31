# SageMath Check: 標準接触対の平滑化不変性と標準対での平滑化の対合性

旧主張は参照用ノート「不採用経路: 標準接触対の平滑化」に退避した。

**対象ラベル**: `def_nonbacktracking_permutations`

接触対の集合 $\operatorname{Ct}(\varphi)$（切り替え可能に限らない）と、参照用ノートの辞書式順序（辺の番号、次に向き。対は最小元・最大元の順）による最小元 $\operatorname{ct}_{\min}(\varphi)$ を全非後退置換で計算する。切り替え可能な接触対での平滑化の前後で $\operatorname{Ct}$・$N_{\mathrm{ct}}$・$\operatorname{ct}_{\min}$ が変わらないこと、標準接触対が切り替え可能な置換の集合 $\mathcal A_L$ の上で $S(\varphi)=\operatorname{Sm}_{\operatorname{ct}_{\min}(\varphi)}(\varphi)$ が $\mathcal A_L$ に留まり、二回適用で元へ戻り、不動点を持たず、$M$・$D$・$E_1$ を保つことを有限集合の等号だけで検査する。

- 実行: `sage sagemath/check/standard-contact-smoothing-involution/check.sage`
- 状態: PASS（2026-10-31、退避後に再実行）
- 結果: 一辺 $L=2$ の非後退置換 $30{,}784$ 個のうち、接触対を持つ置換は $30{,}735$ 個。切り替え可能な接触対 $192{,}896$ 件の平滑化すべてで $\operatorname{Ct}$・$N_{\mathrm{ct}}$・$\operatorname{ct}_{\min}$ の不変性が成り立った。標準接触対が切り替え可能な置換は $11{,}980$ 個あり、その全てで対合・不動点なし・ファイバー保存が成り立った。

接触対を持つが標準接触対が切り替え可能でない置換が $18{,}755$ 個残る。この残りの相殺（または符号読み）は後続のセクションで扱う。

計算は有限集合の比較だけであり、浮動小数点は使わない。
