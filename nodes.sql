/* PROBLEM */

You are given a table, BST, containing two columns: 

N and P, where N represents the value of a node in Binary Tree,
 and P is the parent of N.



Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.
Sample Input



Sample Output

1 Leaf
2 Inner
3 Leaf
5 Root
6 Leaf
8 Inner
9 Leaf

/* SOLUTION */

A Leaf = has no childs. thus p is null
A Root = has no Fathers. thus n is never a p
A Inner = the remainings. n is not null and n is not in leaf


with



full_list as ( select distinct c.n 
 from ( 
 
 (select n from `data-dog-250809.hereee.tree`)  
 union all 
 (select p as n from `data-dog-250809.hereee.tree`)
 )as c  
 where c.n is not null
 order by c.n asc
)
    
Leaf as (select a.n    from full_list as a left join `data-dog-250809.hereee.tree` as b on a.n=b.n  where b.p is NULL),
Root as (select a.p as n from `data-dog-250809.hereee.tree` as a left join `data-dog-250809.hereee.tree` as b on a.p = b.n where b.p is null)
inner as (select a.n from `data-dog-250809.hereee.tree` as a left  join leaf as b on a.n = b.n 
        
where )







