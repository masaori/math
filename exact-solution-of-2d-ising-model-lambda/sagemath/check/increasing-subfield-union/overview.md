# SageMath Check: 増大列にある部分体の和集合は部分体である

**対象ラベル**: `claim_increasing_subfield_union_is_subfield`

**実行日**: 2026-11-17

## 確認内容

$F_0=\mathbb Q$、$F_n=\mathbb Q(\sqrt2)$（$n\ge1$）の有限標本で、零・一・和・積・負・逆元の式を厳密に検算する。全称命題は Lean 二版で示す。

| ファイル | ステータス | 結果 |
|---|---|---|
| `check.sage` | PASS | 元 30 件、組 900 件で成立 |
