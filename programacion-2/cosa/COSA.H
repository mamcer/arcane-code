#ifndef COSA_H
#define COSA_H
template <class t>
class cosa{
	t dato;
public:
	cosa(void);
	~cosa(void);
	void agregar(t);
	t ver(void);
}
#endif