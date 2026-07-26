# SageMath Check: 046_claim_even_sector_modes

## 対象

**対象ラベル**: `H1_H2_via_check_Z_Y` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/013_even_sector_modes.ts`
- 併せて検証:
  - `why_008_applies_only_to_minus_sector`（008 章が `(−)` 専用である理由）
  - `antiperiodic_exp_sum` / `def_half_integer_modes`
  - `commutator_of_H_and_check_Z_Y`（(A)〜(D)）
  - `anticommutator_of_check_Z_Y` / `recover_Z_Y_from_check_Z_Y`

### 何を確定させるための検証か

`remark_remaining_input_even_sector`（012 章）が指摘した「残っている唯一の入力」——
`V^{(+)}` の固有値が半整数運動量で与えられること——へ向けた**土台**を 013 章で据えた。
この検証はその土台を数値で固定する。

とくに 2 点を確定させる。

1. **008 章が `(−)` 専用である理由が等式として正しいこと**：
   `[H_2, hatZ^{(−)}_μ] = −2 hatY_μ` は成り立つが、
   `[H_2, hatZ^{(+)}_μ] = −2 hatY_μ + 4 e^{−iθ_μ} Y_1 ≠ −2 hatY_μ` である。
2. **半整数運動量モードなら閉じること**：`checkZ, checkY` は `H_1^{(+)}, H_2` に対して
   008 章の (A)〜(D) と同じ形の交換関係を満たし、反交換関係の対は `μ+ν ≡ 1 (mod M)` になる。

## 検証の枠組み

`sagemath/_shared/spin_ops.sage` の演算子構成に、本ディレクトリの `_prelude.sage` で

```
θ~_μ = 2π(μ − 1/2)/M
checkZ_μ = Σ_{j=1}^{M} Z_j e^{−i j θ~_μ},   checkY_μ = Σ_{j=1}^{M} Y_j e^{−i j θ~_μ}
```

を加えた。パラメータは `M = 2,3,4,5`。

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_why_minus_only.sage | `[H_2, hatZ^{(±)}]` の比較、`hatZ^{(+)} = hatZ^{(−)} − 2e^{−iθ}Z_1` | PASS | （run-log.txt 参照） |
| 02 | check_02_commutators.sage | 反周期性 `e^{−iMθ~}=−1`、添字周期性、共役添字、(A)〜(D) | PASS | （run-log.txt 参照） |
| 03 | check_03_anticommutators_and_inversion.sage | 反交換関係、復元公式、`H_1^{(+)}, H_2` の表示、半整数運動量の指数和 | PASS | （run-log.txt 参照） |

## 備考

- **仕組みは 1 つの等式に集約される**: `e^{−iM θ~_μ} = −1`（反周期性）。
  `hatZ^{(±)}` では境界の符号を第 1 項に置いていたのに対し、`checkZ` では位相が
  `j = M` から `j = 0` へ回るときに自動的に符号を出す。この違いが `H_2` との交換関係が
  壊れるか壊れないかを分ける（整数運動量では `e^{−iMθ_μ} = +1` なので同じ計算が閉じない）。
- check_01 は「(+) 側が `−2 hatY` と一致しない」ことを**全 μ についての最小残差**で判定している
  （どの μ でも一致しないことを主張するため）。
- `H_1^{(+)}` の境界項 `−Y_M Z_1` の符号は、`antiperiodic_exp_sum` の `l = 1` の因子 `(−1)^1` として
  自動的に現れる。整数運動量版で `hatZ^{(±)}` の第 1 項の符号が担っていた役割を、
  ここでは指数和の符号が担っている。

## 実行方法

```bash
for f in sagemath/check/046_claim_even_sector_modes/check_*.sage; do sage "$f"; done
```

## 実行ログ

`run-log.txt` に実際の実行出力（全チェックの残差と PASS/FAIL）を保存してある。
