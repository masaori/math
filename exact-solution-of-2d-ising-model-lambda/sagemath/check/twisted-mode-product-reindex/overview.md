# 横・縦モードの直積の全単射

**対象ラベル**: `claim_twisted_mode_product_bijection`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check.sage` | 辺長 $L=1,\dots,6$ と $(a,b)\in\{0,1\}^2$ で、$\Theta_{L,a,b}$ の値が $E_{L,a}\times E_{L,b}$ に属すること、像が一致する組について $\mathrm{pr}_1$・$\mathrm{pr}_2$ を通す三行ずつと組の等号の二行、$E_{L,a}\times E_{L,b}$ の各元について逆像の取り方と $\Theta_{L,a,b}(\varpi,\varsigma)=(z,w)$ の三行を厳密計算した（4,392 行。添字の取り替えによる有限和の一致の具体例を含む）。否定の対照として、相異なる組の像が相異なることを 8,736 件で確かめた | PASS（2026-11-12） |

- 複素実現 $\rho_{\overline{\mathbb Q}\to\mathbb C}$ は QQbar の標準の複素埋め込みで代えた。本文は固定した原始根の像を指定しないので、これは一つの埋め込みでの検算である。浮動小数点は使わない。
- 有限例は全ての辺長での全単射の証明ではない。本文は成分ごとの全単射（`claim_twisted_modes_complex_roots_bijection`）を根拠とする。
