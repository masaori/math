# 複素実現の乗法・単位元保存

**対象ラベル**: `claim_complex_realization_preserves_multiplication`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check.sage` | 実の数体 $K=\mathbb Q(\sqrt2+\sqrt3)$ を実閉部分体の代わりに、$L=K(\omega)$（$\omega^2=-1$）を代数的数の代わりに取り、本文の三つの式変形（$\xi\eta=(ac-bd)+(ad+bc)\omega$ の六行、$\rho_{\overline{\mathbb Q}\to\mathbb C}(\xi\eta)$ から $\rho(\xi)\rho(\eta)$ までの十行、$\rho_{\overline{\mathbb Q}\to\mathbb C}(1)=1$ の三行）と係数表示の一意性を、係数の 7 個の標本の全ての組 2,401 件で厳密計算した。否定の対照として、$\omega^2=+1$ と誤って実部を $ac+bd$ にした式が最後の行と一致しないことを $bd\ne0$ の 1,764 件で確かめた | PASS（2026-11-12） |

- 計算はすべて数体の中の厳密計算である。`RR(sqrt(2) + sqrt(3))` は $K$ の実埋め込みを選ぶためだけに使い、等号の判定には使わない。
- 実数への実現 $\rho_{R\to\mathbb R}$ は、$K$ の元の値そのものなので $K\to L$ の包含で表し、複素数の虚数単位 $i$ を $\omega$ で表した。
- 有限例は固定した実閉部分体のすべての元に対する乗法保存を証明しない。本文は係数表示の一意性と実現写像の加法・乗法の保存と有理数上の一致を使う。
