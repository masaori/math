# SageMath Check: 165_centralizer_is_scalar

## 対象

**対象ラベル**: `centralizer_is_scalar` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`

- 範囲: すべての元と可換な W はスカラー行列

ランダムな W を試すのではなく、**連立一次方程式 [W, g] = 0（g は生成元 Z_m, Y_m）の解空間の次元が 1 であること**を特異値で確認する。vec(gW−Wg) = (g⊗I − I⊗gᵀ)vec(W) を使う。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_nullspace.sage` | 解空間の次元（M=1,2,3） | 15 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

生成元だけで十分なのは <Z_Y_generate_algebra>（164 で検証）により Z,Y が全体を生成するため。

## 実行時に出力された観測値

```
  M=1: 未知数=4, 解空間の次元=1
  M=2: 未知数=16, 解空間の次元=1
  M=3: 未知数=64, 解空間の次元=1
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 165
```

実行ログは `sagemath/check/165_centralizer_is_scalar/logs/` に保存してある（この表の数値はそのログから取った）。
