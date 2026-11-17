# SageMath Check: 二次体の台集合の部分体性

**対象ラベル**: `claim_quadratic_field_set_is_subfield`

**実行日**: 2026-11-17

## 確認内容

単位元の有理係数表示を `QQ` と `QQbar` の厳密な等号で確認する。零元・加法・加法逆元・乗法・非零元の逆元の閉性は、本文の既存の各主張に対応する検証が確認済みである。全称命題は Lean 二版で示す。

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_unit_embedding.sage` | 単位元の包含 | PASS | 厳密な等号が成立 |
| `check_add_zero.sage` | 加法の単位元 | PASS | 厳密な等号が成立 |
| `check_zero_product.sage` | 零元との積 | PASS | 厳密な等号が成立 |
| `check_zero_embedding.sage` | 零元の包含 | PASS | 厳密な等号が成立 |
| `check_unit_membership.sage` | 単位元の二次体表示 | PASS | 厳密な等号が成立 |
