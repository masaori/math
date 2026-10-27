# ねじれたモードの周期端の検証

**対象ラベル**: `claim_twisted_mode_wrap_phase`

代数的数体で辺長 1〜8、符号二通り、各多項式の全根を厳密に調べる。一般の辺長の証明は本文と Lean が担う。

| ファイル | 検証内容 | 状態 | 結果 |
|---|---|---|---|
| `check_forward_wrap.sage` | 前進端の二行 | PASS（2026-10-27） | 辺長 1〜8、符号二通りの全根 |
| `check_backward_product.sage` | 後退端の積の五行 | PASS（2026-10-27） | 辺長 1〜8、符号二通りの全根 |
| `check_backward_inverse.sage` | 逆元による結論 | PASS（2026-10-27） | 辺長 1〜8、符号二通りの全根 |
