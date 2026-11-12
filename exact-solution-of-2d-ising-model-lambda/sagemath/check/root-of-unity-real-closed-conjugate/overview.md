# 1 の冪根の逆元と実閉部分体上の共役

**対象ラベル**: `claim_root_of_unity_inverse_is_real_closed_conjugate`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check.sage` | 共役写像の加法・乗法の保存の各行、`R` の固定と対合、$N=\alpha^2+\beta^2$ の二行（$\mathbb Q[a,b,c,d][\omega]/(\omega^2+1)$ の恒等式）。$1<_RN$・$N<_R1$ の帰納段の各行（$N=c^2$ を代入した $\mathbb Q[c,u]$ の恒等式、$m=1,\dots,6$）。次数 1〜12 の冪根での $N^n$ の鎖と $\alpha^2+\beta^2=1$、$\zeta^{-1}$ の四行（`QQbar` の厳密計算、$R$ として実代数的数、$\omega=i$）。514 行、否定の対照 85 件 | PASS（2026-11-12） |

順序による帰納法そのもの（任意の $m$）は本文と Lean が受け持つ。SageMath は各行の等式だけを確かめる。
