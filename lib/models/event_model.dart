//   public static table= "events"
//   @column({ isPrimary: true })
//   public id: number

//   @column({serializeAs:"name"})
//   public name: string

//   @column({serializeAs:"description"})
//   public description: string

//   @column({serializeAs:"category_id"})
//   public categoryId: number

//   @column({serializeAs:"organizer_id"})
//   public organizerId: number

//   @column({serializeAs:"start_date"})
//   public start_date: string

//   @column({serializeAs:"end_date"})
//   public end_date: string

//   @column({serializeAs:"status"})
//   public status: string

//   @column({serializeAs:"views"})
//   public views: number

//   @column({serializeAs:"capacity"})
//   public capacity: number

//   @column({serializeAs:"thanking_message"})
//   public thanking_message: string

//   @belongsTo(()=>Category)
//   public category: BelongsTo<typeof Category>

//   @belongsTo(()=>User,{
//     foreignKey:"organizerId"
//   })
//   public organizer: BelongsTo<typeof User>

//   @manyToMany (()=>Interaction)
//   public eventInteraction: ManyToMany<typeof Interaction>

//   @manyToMany (()=>Tag)
//   public eventTag: ManyToMany<typeof Tag>

//   @hasMany (()=>Image)
//   public images: HasMany<typeof Image>

//   @hasMany (()=>Report)
//   public report: HasMany<typeof Report>

//   @hasMany (()=>Spot)
//   public spot: HasMany<typeof Spot>
// }

//----------------------------

class Event {
  int id;
  String name;
  String description;
  int category_id;
  int organizer_id;
  DateTime start_date;
  DateTime end_date;
  String status;
  int views;
 int capacity;
   String thanking_message;
   String Category;


  Event(this.id, this.name,this.description ,this.category_id ,this.organizer_id,this.start_date,this.end_date ,this.status ,this.views,this.capacity,this.thanking_message,this.Category      );
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(json['id'], json['name'], json['description'], json['category_id'], json['organizer_id'], json['start_date'], json['end_date'], json['status'], json['views'], json['capacity'], json['thanking_message'], json['Category']);
  }
}
