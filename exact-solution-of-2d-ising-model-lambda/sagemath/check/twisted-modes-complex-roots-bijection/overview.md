# 横・縦モードと複素根集合の全単射

**対象ラベル**: `claim_twisted_modes_complex_roots_bijection`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check.sage` | 辺長 $L=1,\dots,8$ と $c\in\{0,1\}$ で、一段落目の $|E_{L,c}|=L$（候補 $e_{L,c,k}$ の集合と $X^L-(-1)^c$ の根の集合の一致。`claim_complex_root_candidates_bijection` の全単射から）と、モード集合の像が $E_{L,c}$ に含まれ単射で一致することを一行ずつ厳密計算した（80 行）。候補の添字付けの全単射性の行は `complex-root-candidates-bijection` へ移した | PASS（2026-11-16） |

- $\exp(2\pi i r)$（$r\in\mathbb Q$）は QQbar の 1 の冪根 $\zeta_d^m$（$r=m/d$）で厳密に表した。浮動小数点は使わない。
- 複素実現 $\rho_{\overline{\mathbb Q}\to\mathbb C}$ は QQbar の標準の複素埋め込みで代えた。本文は固定した原始根の像を指定しないので、これは一つの埋め込みでの検算である。
- 有限例は全ての辺長での全単射の証明ではない。本文では候補の添字付けの全単射性と複素実現の単射性を使う。
