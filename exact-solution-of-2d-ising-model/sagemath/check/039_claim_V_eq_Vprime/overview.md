# 039 `V = c V'` — SageMath 検証

## 対象
`parts/008_T_V1_hatZとhatZ_hatYの関係/039_claim_V_eq_Vprime.typ`:
ある `c ∈ CC^×` で `V = c V'`。

## 検証方針
`W := V'^(-1) V` を構築し `W = c I`（c≠0）を確認（中心性経由の証明と一致）。
V, V' の構築は 038 の `common_full.py` を共有（セクター '-'）。

## 実行
`sage -python check_01_W_is_scalar.py`

## 結果: 全 PASS（M=2,3,4 × 5パラメータ）
- `max|W - cI|`: 4.5e-16 〜 3.2e-12 → PASS
- `c = 1.0000 + 0.0000j`（全ケース。V_2 の前因子 `(2 sinh 2K_2)^(M/2)` を除いた構築では
  V がフェルミオン版 V' と厳密一致する。前因子を戻すと c はその値になる。）
