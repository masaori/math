# SageMath Check: 257_def_pauli_group

## 対象

**対象ラベル**: `def_pauli_group` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.mjs`

- 範囲: Pauli 群 P_M が積で閉じ、位数が 4·4^M であること

M = 1,2,3 で列挙し、重複が無いこと、積・単位元・逆元について閉じていることを確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_pauli_group.sage` | 位数、重複なし、積・単位元・逆元での閉性 | 640 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

`def_clifford_group` は同じブロックのもう 1 つのラベル。クリフォード群そのものの列挙は無限群なので行わず、254 で V₂ が属さないことを示す形で扱っている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 257
```

実行ログは `sagemath/check/257_def_pauli_group/logs/` に保存してある（この表の数値はそのログから取った）。
