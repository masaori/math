# SageMath Check: 1 乗して 1 になる代数的数は 1 だけである

**対象ラベル**: `claim_first_root_of_unity_set`

$w^1=1$ ならば $w=1$ であることと、逆に $1^1=1$ であることを
$\overline{\mathbb{Q}}$ の厳密計算で確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/first-root-of-unity-set/check.sage
```

**2026-08-12 実行: すべて通過。**

2026-09-05: 本文の逆包含で、冪根集合への所属の根拠をその行末へ移した。
LLM による検証では、両包含の論法・等式・参照を保存していることを確認した。
プログラミングによる検証では同じ `check.sage` を再実行し、両方向が通過した。
