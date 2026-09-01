# SageMath Check: 同じ接触対での平滑化の対合性

**対象ラベル**: `claim_contact_smoothing_same_pair_involution`

一辺 $L=2$ のトーラスの全非後退置換について、切り替え可能な接触対を全列挙する。像を交換した置換でも同じ対が切り替え可能な接触対の三条件を満たすこと、証明が使う等式（$\psi(\vec f)=\varphi(\vec e)$、$\psi(\vec e)=\varphi(\vec f)$、非後退性からの後続所属 $\varphi(\vec e)\in\operatorname{Next}(\vec e)$・$\varphi(\vec f)\in\operatorname{Next}(\vec f)$）、および同じ対で再び平滑化すると元の置換へ戻ることを有限集合の等号として厳密検査する。

- 実行: `sage sagemath/check/contact-smoothing-same-pair-involution/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 非後退置換 $30{,}784$ 個中、切り替え可能な接触対を持つ置換 $29{,}905$ 個、切り替え可能な接触対 $192{,}896$ 件について全ての条件と等式が成立した。

計算は有限集合の比較だけであり、浮動小数点は使わない。
