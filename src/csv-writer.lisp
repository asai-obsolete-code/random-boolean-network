
(in-package :random-boolean-network)
(enable-annot-syntax)

@export @doc "output the result graph of an RBN states to the
specified path as a csv file."
(defun output-graph-to-csv (graph &optional (path "graph.csv"))
  (format t "processing ~a~%" path)
  (with-open-file (s path :direction :output
					 :if-exists :overwrite
					 :if-does-not-exist :create)
	(iter (for target in-vector graph with-index source)
		  (write-csv-line (list source target) s))))


@export @doc "output the node connection of an RBN to the specified
path as a csv file."
(defun output-nodes-to-csv (nodes &optional (path "nodes.csv"))
  (format t "processing ~a~%" path)
  (with-open-file (s path :direction :output
					 :if-exists :overwrite
					 :if-does-not-exist :create)
	(iter (for node in-vector nodes with-index i)
		  (iter (for input in (inputs node))
				(write-csv-line (list input i) s)))))

