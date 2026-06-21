# 038 `T_(V) = T_(V')` — SageMath 検証

## 対象
`parts/008_T_V1_hatZとhatZ_hatYの関係/038_claim_T_V_eq_T_Vprime.typ`:
任意の `x ∈ Mat(2,CC)^(⊗M)` で `V x V^(-1) = V' x V'^(-1)`。

## 検証方針
`V := (V_1^(-))^(1/2) V_2 (V_1^(-))^(1/2)`（def_T_V, **セクター '-'**）と
`V' := exp(X)`（X はフェルミオン二次形式, def 032）を具体行列で構築し、
- check_01: 生成元 `Z_m, Y_m` 上で `T_(V)=T_(V')`（038 Step2 の中核）
- check_02: ランダム `x` 数個で `T_(V)=T_(V')`（全空間での一致）
を確認。`Mat(2,CC)^(⊗M)` は `Z_m,Y_m` が環として生成する（014）ので Z,Y 上一致＋代数準同型から全空間一致が従う。

## 実行
`sage -python check_01_TV_eq_TVprime_on_Z_Y.py`
`sage -python check_02_TV_eq_TVprime_on_random_x.py`
（numpy/scipy を使うため `sage -python` で実行。共通機構は `common_full.py`。）

## 結果: 全 PASS（M=2,3,4 × 5パラメータ）
- check_01 `max|T_V(Z,Y)-T_V'(Z,Y)|`: 7.9e-16 〜 2.1e-12（臨界点で最大）→ PASS
- check_02 `max|T_V(x)-T_V'(x)|` (random x): 1.4e-15 〜 1.7e-10 → PASS

## 重要な知見（セクター）
`θ_μ = 2πμ/M`（整数モード）に対応するのは **`V_1^(-)`（境界項 `+Y_M Z_1`）= 周期セクター**。
`V_1^(+)`（`-Y_M Z_1`）で構築すると誤差 ~0.5 で FAIL する。`def_V1_plus_minus`(006) の
`∓Y_M Z_1` のうち、本主張で使うのは `-` 上付き = `+Y_M Z_1` 側。
（005 は `V_1 = V_1^(±)` を固有空間 `F^(±)` 上に制限して主張するが、`def_T_V` は `V_1^(±)`
そのもの＝Majorana 二次形式の exp を全空間で用いており、共役は全空間で span{Z,Y} を保つ。）
