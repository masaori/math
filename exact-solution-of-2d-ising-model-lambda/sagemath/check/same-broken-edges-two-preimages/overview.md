# SageMath Check: 同じ破れた辺の集合の二つの原像

## 対象

**対象ラベル**: `claim_same_broken_edges_equal_or_global_reversal`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check.sage` | $L=1,2,3$ の全配位を破れた辺の真偽値列で類別し、各原像が配位とその全スピン反転の二つだけであること | PASS | 2、16、512 配位を全数検査 |

## 備考

各 $L$ では配位を全数検査した。$L$ 全体については標本である。スピン値は `ZZ`、格子・辺・配位は有限集合だけで表し、浮動小数点と $\mathbb{R}/\mathbb{C}$ は使わない。

## 実行方法

```sh
sage sagemath/check/same-broken-edges-two-preimages/check.sage
```

**2026-10-03 再実行: 全 530 配位・265 種類の破れ集合が通過。**

今回の環境では Sage の起動コマンドから `.sage` へ渡される `__file__` が実行対象を指さないため、
Sage を導入した Python で対象のパスを明示し、同じコードを Sage の前処理後に実行した。

```sh
python -c 'from sage.all import *; from sage.repl.preparse import preparse; from pathlib import Path; p = Path("sagemath/check/same-broken-edges-two-preimages/check.sage").resolve(); exec(compile(preparse(p.read_text()), str(p), "exec"), dict(globals(), __file__=str(p)))'
```
