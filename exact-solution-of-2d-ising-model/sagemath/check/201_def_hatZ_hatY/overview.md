# SageMath Check: 201_def_hatZ_hatY

## 対象

**対象ラベル**: `def_hatZ_hatY` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`（ブロック `transfer_matrix_010_definition_hatZ_hatY`）

- 範囲: hatZ^{(±)}_μ・hatY_μ の定義そのもの（μ ∈ 𝓜 = {−M,…,−1,1,…,M}）

本文は hatZ^{(±)}_μ を 2 通りの式で書き、両者を等号で結んでいる。

- 形 (i): `Σ_{j=1}^{M} {∓1 (j=1), 1 (j≠1)} Z_j exp(−i 2π j μ / M)`（cases 記法）
- 形 (ii): `∓ Z_1 exp(−i 2π μ / M) + Σ_{j=2}^{M} Z_j exp(−i 2π j μ / M)`（j=1 の項を和の外へ出した形）

この等号は本文が主張している事柄であり、定義が一意に定まること（well-defined 性）に直結する。
ここではその一致を数値で確認する。併せて、j=1 に掛かる重みが本文どおり ∓1（sign='+' で −1、
sign='−' で +1）であることを、行列成分 (0,0) から係数を直接読み取る別経路で確認する。

なお、周期性（hatZ_μ = hatZ_{μ+M} 等）と hatZ^{(+)}・hatZ^{(−)} の差は
`191_hatZ_hatY_M_periodicity` が担当しており、ここでは扱わない。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_two_forms_of_definition.sage` | 形 (i) と形 (ii) の一致、および j=1 の重み ∓1 | 116 | 3.708e-17 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 201
```

実行ログは `sagemath/check/201_def_hatZ_hatY/logs/` に保存してある（この表の数値はそのログから取った）。
