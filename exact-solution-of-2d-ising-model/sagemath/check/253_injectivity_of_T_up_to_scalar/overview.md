# SageMath Check: 253_injectivity_of_T_up_to_scalar

## 対象

**対象ラベル**: `injectivity_of_T_up_to_scalar` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.mjs`

- 範囲: (i) 乗法群の中心がスカラー行列全体、(ii) T_g = T_{g′} ⟺ g′ = cg

(ii) の ⟹ は、T_g = T_{g′} ⟺ g^{-1}g′ が中心に属する、に帰着する。中心の解空間が 1 次元であることを連立一次方程式の特異値で確認しているので、cg 以外に無いことが言える。スカラーでない倍率では T が実際に変わることも見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_center_and_injectivity.sage` | 中心の次元、⟸ 方向、⟹ の根拠、非スカラー倍率での反例 | 30 | 8.856e-14 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

`center_of_multiplicative_group_is_scalar` は同じブロックのもう 1 つのラベルで、内容はこの check に含まれる。

## 実行時に出力された観測値

```
  M=1: [W,g]=0 の解空間の次元 = 1
  M=2: [W,g]=0 の解空間の次元 = 1
  M=3: [W,g]=0 の解空間の次元 = 1
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 253
```

実行ログは `sagemath/check/253_injectivity_of_T_up_to_scalar/logs/` に保存してある（この表の数値はそのログから取った）。
